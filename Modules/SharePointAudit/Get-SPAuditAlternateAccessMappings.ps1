function Get-SPAuditAlternateAccessMappings
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
    
  foreach ($webApplication in $webApplications)
  {
    $alternateUrls = Get-SPAlternateURL -WebApplication $webApplication
    
    foreach ($alternateUrl in $alternateUrls)
    {
      $properties = @{
        'DisplayName' = $webApplication.DisplayName
        'InternalUrl' = $alternateUrl.IncomingUrl
        'Zone' = $alternateUrl.Zone
        'Url' = $alternateUrl.PublicUrl
      }
      
      $output = New-Object -TypeName PSObject -Property $properties
      
      Write-Output $output
    }
  }
}