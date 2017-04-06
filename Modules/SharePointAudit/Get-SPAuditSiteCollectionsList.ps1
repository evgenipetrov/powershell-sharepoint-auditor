function Get-SPAuditSiteCollectionsList
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $sites = Get-SPSite -WebApplication $webApplication -Limit All
    
    foreach ($site in $sites)
    {
      $properties = @{
        'WebApplication' = $webApplication.DisplayName
        'Title' = $site.RootWeb.Title
        'Url' = $site.Url
        'ContentDatabase' = $site.ContentDatabase.Name
        'Owners' = $site.Owner,$site.SecondaryContact
      }
      
      $output = New-Object -TypeName PSObject -Property $properties
      
      Write-Output $output      
    }
    
  }
  

}