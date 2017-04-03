function Get-SPAuditWebApplicationsAndSiteCollections
{

  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach($webApplication in $webApplications){
    $sites=Get-SPSite -WebApplication $webApplication -Limit All

    foreach ($site in $sites)
    {
    
        $siteAdmins = $site.RootWeb.SiteAdministrators
        
           $properties = @{
        'ReportName'    = 'Web applications and site collections'
        'WebApplication'    = $webApplication.DisplayName
        'SiteCollection'          = $site.Url
        'SiteAdmins' = $siteAdmins | Select-Object -ExpandProperty DisplayName
      }
		
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
    
  }  
  


}