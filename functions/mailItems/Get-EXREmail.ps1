function Get-EXREmail
{
	[CmdletBinding()]
	param (
		[Parameter(Position = 0, Mandatory = $false)]
		[string]
		$MailboxName,
		
		[Parameter(Position = 1, Mandatory = $false)]
		[psobject]
		$AccessToken,

		[Parameter(Position = 2, Mandatory = $false)]
		[psobject]
		$ItemRESTURI,

		[Parameter(Position = 3, Mandatory = $false)]
		[psobject]
		$PropList,
		[Parameter(Position = 4, Mandatory = $false)]		
		[switch]
		$ReturnSentiment,

		[Parameter(Position = 5, Mandatory = $false)]
		[String]
		$BodyFormat
		

		
	)
	Process
	{
		if($AccessToken -eq $null)
        {
            $AccessToken = Get-ProfiledToken -MailboxName $MailboxName  
            if($AccessToken -eq $null){
                $AccessToken = Get-EXRAccessToken -MailboxName $MailboxName       
            }                 
        }
         if([String]::IsNullOrEmpty($MailboxName)){
            $MailboxName = $AccessToken.mailbox
        } 
		$HttpClient = Get-HTTPClient -MailboxName $MailboxName
		$RequestURL = $ItemRESTURI
		if($ReturnSentiment.IsPresent){
                if($PropList -eq $null){
                    $PropList = @()
                    $Sentiment = Get-EXRNamedProperty -DataType "String" -Id "EntityExtraction/Sentiment1.0" -Type String -Guid "00062008-0000-0000-C000-000000000046"
                    $PropList += $Sentiment
                }
                else{
                    $Sentiment = Get-EXRNamedProperty -DataType "String" -Id "EntityExtraction/Sentiment1.0" -Type String -Guid "00062008-0000-0000-C000-000000000046"
                    $PropList += $Sentiment
                }
        }
		if($PropList -ne $null){
               $Props = Get-EXRExtendedPropList -PropertyList $PropList -AccessToken $AccessToken
               $RequestURL += "?`&`$expand=SingleValueExtendedProperties(`$filter=" + $Props + ")"
		}
		
		$JSONOutput = Invoke-RestGet -RequestURL $RequestURL -HttpClient $HttpClient -AccessToken $AccessToken -MailboxName $MailboxName -BodyFormat $BodyFormat
		Add-Member -InputObject $JSONOutput -NotePropertyName ItemRESTURI -NotePropertyValue $ItemRESTURI
		Expand-ExtendedProperties -Item $JSONOutput
		Expand-MessageProperties -Item $JSONOutput
		return $JSONOutput 
		
	}
}
