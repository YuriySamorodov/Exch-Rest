function Invoke-RestPut
{
	[CmdletBinding()]
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$RequestURL,
		
		[Parameter(Position = 1, Mandatory = $true)]
		[String]
		$MailboxName,
		
		[Parameter(Position = 2, Mandatory = $true)]
		[System.Net.Http.HttpClient]
		$HttpClient,
		
		[Parameter(Position = 3, Mandatory = $true)]
		[psobject]
		$AccessToken,
		
		[Parameter(Position = 4, Mandatory = $true)]
		[String]
		$ContentHeader,
		
		[Parameter(Position = 5, Mandatory = $true)]
		[PSCustomObject]
		$Content
		
	)
	Begin
	{
		if($Script:TraceRequest){
			write-host $RequestURL
		}
		#Check for expired Token
		$minTime = new-object DateTime(1970, 1, 1, 0, 0, 0, 0, [System.DateTimeKind]::Utc);
		$expiry = $minTime.AddSeconds($AccessToken.expires_on)
		if ($expiry -le [DateTime]::Now.ToUniversalTime())
		{
			write-host "Refresh Token"
			$AccessToken = Invoke-RefreshAccessToken -MailboxName $MailboxName -AccessToken $AccessToken
		}
		$method = New-Object System.Net.Http.HttpMethod("PUT")
		$HttpRequestMessage = New-Object System.Net.Http.HttpRequestMessage($method, [Uri]$RequestURL)
		$HttpClient.DefaultRequestHeaders.Authorization = New-Object System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", (ConvertFrom-SecureStringCustom -SecureToken $AccessToken.access_token));
		if (![String]::IsNullorEmpty($ContentHeader))
		{
			$HttpRequestMessage.Content = New-Object System.Net.Http.ByteArrayContent -ArgumentList @( ,$Content)
			$HttpRequestMessage.Content.Headers.ContentType = new-object System.Net.Http.Headers.MediaTypeHeaderValue($ContentHeader);
		}
		else
		{
			$HttpRequestMessage.Content = New-Object System.Net.Http.StringContent($Content, [System.Text.Encoding]::UTF8, "application/json")
		}
		$ClientResult = $HttpClient.SendAsync($HttpRequestMessage)
		if ($ClientResult.Result.StatusCode -ne [System.Net.HttpStatusCode]::OK)
		{
			if ($ClientResult.Result.StatusCode -ne [System.Net.HttpStatusCode]::Created)
			{
				write-Host ($ClientResult.Result)
			}
			if ($ClientResult.Result.Content -ne $null)
			{
				Write-Host ($ClientResult.Result.Content.ReadAsStringAsync().Result);
			}
		}
		else{
			write-host $ClientResult.Result.StatusCode
		}
		if (!$ClientResult.Result.IsSuccessStatusCode)
		{
			Write-Host ("Error making REST Get " + $ClientResult.Result.StatusCode + " : " + $ClientResult.Result.ReasonPhrase)
			Write-Host ("RequestURL : " + $RequestURL)
		}
		else
		{
			if ($NoJSON)
			{
				return $ClientResult.Result.Content
			}
			else
			{
				$JsonObject = ExpandPayload($ClientResult.Result.Content.ReadAsStringAsync().Result)
				#$JsonObject = ConvertFrom-Json -InputObject  $ClientResult.Result.Content.ReadAsStringAsync().Result
				if ([String]::IsNullOrEmpty($ClientResult))
				{
					write-host "No Value returned"
				}
				else
				{
					if($JsonObject -ne $null){
						Add-Member -InputObject $JsonObject -NotePropertyName DateTimeRESTOperation -NotePropertyValue (Get-Date).ToString("s")
					}
					return $JsonObject
				}
				
			}
			
		}
		
	}
}
