function Get-APAuditSelfServiceSiteCreation
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $properties = @{
      'DisplayName'           = $webApplication.DisplayName
      'Url'                   = $webApplication.Url
      'Allowed'               = $webApplication.SelfServiceSiteCreationEnabled
      'RequireSecondaryContact' = $webApplication.RequireContactForSelfServiceSiteCreation
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output -InputObject $output
  }
}
