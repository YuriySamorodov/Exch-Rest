function Export-EXRContactFolderToCSV{

	   [CmdletBinding()] 
    param( 
		[Parameter(Position=1, Mandatory=$false)] [psobject]$AccessToken,
	    [Parameter(Position=2, Mandatory=$false)] [string]$MailboxName,
		[Parameter(Position=3, Mandatory=$true)] [string]$FileName,
		[Parameter(Position=4, Mandatory=$false)] [string]$ContactsFolderName
		

    )  
 	Begin
	{
		    $ExportCollection = @()     
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
			if([String]::IsNullOrEmpty($ContactsFolderName)){
			    $Contacts = Get-EXRDefaultContactsFolder -MailboxName $MailboxName -AccessToken $AccessToken
			}
			else{
			    $Contacts = Get-EXRContactsFolder -MailboxName $MailboxName -AccessToken $AccessToken -FolderName $ContactsFolderName
			    if([String]::IsNullOrEmpty($Contacts)){throw "Error Contacts folder not found check the folder name this is case sensitive"}
			}    
            $HttpClient =  Get-HTTPClient -MailboxName $MailboxName
            $EndPoint =  Get-EndPoint -AccessToken $AccessToken -Segment "users" 
            $RequestURL =  $EndPoint + "('" + $MailboxName + "')/contactFolders('" + $Contacts.id  + "')/contacts/?`$Top=1000"
            do{
                $JSONOutput = Invoke-RestGet -RequestURL $RequestURL -HttpClient $HttpClient -AccessToken $AccessToken -MailboxName $MailboxName
                foreach ($Message in $JSONOutput.Value) {
						$expObj = "" | select DisplayName,Title,GivenName,Surname,Email1DisplayName,Email1EmailAddress,imAddress,BusinessPhone,MobilePhone,HomePhone,BusinessStreet,BusinessCity,BusinessState,HomeStreet,HomeCity,HomeState,Birthday,CompanyName,Department,OfficeLocation  
					    $expObj.title = $Message.title
						$expObj.DisplayName = $Message.DisplayName  
						$expObj.GivenName = $Message.GivenName  
						$expObj.Surname = $Message.Surname  						
						if($Message.businessPhones.Count -gt 0){
							if($Message.businessPhones -is [array]){
								$expObj.BusinessPhone = $Message.businessPhones[0]
							}
							else{
								$expObj.BusinessPhone = $Message.businessPhones
							}
							
						}
						$expObj.MobilePhone = $Message.mobilePhone
						if($Message.homePhones.Count -gt 0){
							if($Message.homePhones -is [array]){
								$expObj.HomePhone = $Message.homePhones[0]
							}
							else{
								$expObj.HomePhone = $Message.homePhones
							}
							
						}           
						if($Message.emailAddresses.PSobject.Properties.name -match "address" -gt 0){
							$expObj.Email1DisplayName = $Message.emailAddresses[0].name  
							$expObj.Email1EmailAddress = $Message.emailAddresses[0].address  
						}	 
					    if($Message.imAddresses.Count -gt 0){
							if($Message.imAddresses -is [array]){
								$expObj.imAddress = $Message.imAddresses[0]
							}
							else{
								$expObj.imAddress = $Message.imAddresses
							}
							
						}
						if($Message.businessAddress.PSobject.Properties.name -match "street"){
							$expObj.BusinessStreet = $Message.businessAddress[0].Street  
							$expObj.BusinessCity = $Message.businessAddress[0].City  
							$expObj.BusinessState = $Message.businessAddress[0].State  
						}
						if($Message.homeAddress.PSobject.Properties.name -match "street"){
							$expObj.HomeStreet = $Message.homeAddress[0].Street  
							$expObj.HomeCity = $Message.homeAddress[0].City  
							$expObj.HomeState = $Message.homeAddress[0].State  
						}			
						$expObj.Birthday = $Message.birthday
						$expObj.CompanyName = $Message.companyName
						$expObj.Department = $Message.department
						$expObj.OfficeLocation = $Message.officeLocation  						
						$ExportCollection += $expObj  
                }           
                $RequestURL = $JSONOutput.'@odata.nextLink'
            }while(![String]::IsNullOrEmpty($RequestURL)) 
			$ExportCollection | Export-Csv -NoTypeInformation -Path $FileName
			"Exported to " + $FileName 
	} 
}

