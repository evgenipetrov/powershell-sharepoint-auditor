function Get-SPAuditSiteCollectionsQuotas
{
  $sites = Get-SPSite -Limit All
  $siteQuotas = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates
  foreach ($site in $sites)
  {
    $siteQuota = $siteQuotas | Where-Object {$_.QuotaID -eq $site.Quota.QuotaID}
    $properties = @{
      'SiteCollection'=$site.RootWeb.Title
      'Url'=$site.Url
      'QuotaName'=$siteQuota.Name
      'LockStatus'= $site.ReadOnly
      'StorageMaximumLevel' = $site.Quota.StorageMaximumLevel
      'StorageWarningLevel' = $site.Quota.StorageWarningLevel
      'Usage'=$site.Usage.Storage
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output $output
  }
  

}