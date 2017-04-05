#requires -Version 2.0
#requires -PSSnapin Microsoft.SharePoint.PowerShell
function Get-SPAuditSiteTopology
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $sites = Get-SPSite -WebApplication $webApplication
    
    foreach ($site in $sites)
    {
      $properties = @{
        'WebApplication' = '{0} - {1}' -f $webApplication.DisplayName, $webApplication.Url
        'SiteCollection' = '{0} ({1})' -f $site.RootWeb.Title, $site.Url
        'ContentDatabase' = $site.ContentDatabase.Name
      }
      
      $output = New-Object -TypeName PSObject -Property $properties
      Write-Output -InputObject $output
    }
  }
}
