function  Get-EXRMailboxUsageDetail {
    [CmdletBinding()]
    param(
        [Parameter(Position=0, Mandatory=$true)] [string]$MailboxName,
        [Parameter(Position=1, Mandatory=$false)] [psobject]$AccessToken,
        [Parameter(Position=3, Mandatory=$false)] [String]$PeriodType = "D7"  
    )
    Begin{
        
        if($AccessToken -eq $null)
        {
              $AccessToken = Get-EXRAccessToken -MailboxName $MailboxName          
        }        
        $HttpClient =  Get-HTTPClient -MailboxName $MailboxName
        $EndPoint =  Get-EndPoint -AccessToken $AccessToken -Segment "reports"
        $RequestURL =  $EndPoint + "/getMailboxUsageDetail(period='$PeriodType')/content"
        Write-Host $RequestURL
        $Output = Invoke-RestGet -RequestURL $RequestURL -HttpClient $HttpClient -AccessToken $AccessToken -MailboxName $MailboxName -NoJSON
        $OutPutStream = $Output.ReadAsStreamAsync().Result
        return ConvertFrom-Csv ([System.Text.Encoding]::UTF8.GetString($OutPutStream.ToArray()))
    }
}