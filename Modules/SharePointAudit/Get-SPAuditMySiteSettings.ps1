function Get-SPAuditMySiteSettings
{

$webAppUrl=Get-SPWebApplication | select -First 1  | select -ExpandProperty URL
$sc = Get-SPServiceContext($webAppUrl)
$upm = new-object Microsoft.Office.Server.UserProfiles.UserProfileManager($sc)

$upsa=Get-SPServiceApplication | where {$_.TypeName -eq 'User Profile Service Application'}


    $properties = @{
      'Service Application'= $upsa.Name
      'MySite URL'=$upm.MySiteHostUrl
      'Multilingual'    = $upm.IsPersonalSiteMultipleLanguage
      'Read Permission Level' = $upm.PersonalSiteReaders
      'Sender Email Address' = $upm.MySiteEmailSenderName
      'Enable Net Bios Domain Name' = $upsa.NetBIOSDomainNamesEnabled
      'My Site Managed Path'=$upm.PersonalSiteInclusion
      'Profile Count'=$upm.Count
    }
    
    
    $output = New-Object -TypeName PSObject -Property $properties

    Write-Output -InputObject $output
  
}
