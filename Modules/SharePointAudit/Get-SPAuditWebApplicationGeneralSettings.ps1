function Get-SPAuditWebApplicationGeneralSettings
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  foreach ($webApplication in $webApplications)
  {
    $timezone = Get-SPAuditTimeZoneById -Id $webApplication.DefaultTimeZone
    $quotaTemplate = Get-SPAuditWebApplicationDefaultQuotaTemplate -WebApplication $webApplication

    $properties = @{
      'DisplayName'        = $webApplication.DisplayName
      'DefaultTimeZone'    = $timezone
      'DefaultQuotaTemplate' = $quotaTemplate
    }
    
    $output = New-Object -TypeName PSObject -Property $properties

    Write-Output -InputObject $output
  }
}



