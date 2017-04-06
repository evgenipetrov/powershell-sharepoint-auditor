function Get-SPAuditSiteCollectionsUsageAndProperties
{
  $sites = Get-SPSite -Limit All
  
  foreach ($site in $sites)
  {
    $properties = @{
      'Title' = $site.RootWeb.Title
      'Url' = $site.Url
      'Language' = $site.RootWeb.Language
      'Template' = $site.RootWeb.WebTemplate
      'WebsCount' = Get-SPWeb -Site $site | Measure-Object | Select-Object -ExpandProperty Count
      'UIVersion' = $site.RootWeb.UIVersion
      'Storage' = $site.Usage.Storage
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output $properties
  }
  
  

}