function Get-EXRUsers{
    [CmdletBinding()]
    param( 
        [Parameter(Position=0, Mandatory=$false)] [string]$MailboxName,
        [Parameter(Position=1, Mandatory=$false)] [psobject]$AccessToken,
	[Parameter(Position=2, Mandatory=$false)] [psobject]$filter
    )
    Begin{
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
        $HttpClient =  Get-HTTPClient -MailboxName $MailboxName
        $EndPoint =  Get-EndPoint -AccessToken $AccessToken -Segment "users"
        $RequestURL = $EndPoint
        if(![String]::IsNullOrEmpty($filter)){
                $RequestURL =  $EndPoint + "?`$Top=999&`$filter=" + $filter
        }        
        else{
             $RequestURL =  $EndPoint + "?`$Top=999"
        }
             write-host $RequestURL           
        do{
            $JSONOutput = Invoke-RestGet -RequestURL $RequestURL -HttpClient $HttpClient -AccessToken $AccessToken -MailboxName $MailboxName
            foreach ($Message in $JSONOutput.Value) {
                Write-Output $Message
            }           
            $RequestURL = $JSONOutput.'@odata.nextLink'
        }while(![String]::IsNullOrEmpty($RequestURL))       
        
        
    }
}
