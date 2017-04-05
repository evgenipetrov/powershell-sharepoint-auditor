function Get-SPAuditWebApplicationsResourceThrottling
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach($webApplication in $webApplications)
  {
    $properties = @{
      'DisplayName'                               = $webApplication.DisplayName
      'MaxItemsPerThrottledOperation'             = $webApplication.MaxItemsPerThrottledOperation
      'MaxItemsPerThrottledOperationOverride'     = $webApplication.MaxItemsPerThrottledOperationOverride
      'AllowOMCodeOverrideThrottleSettings'       = $webApplication.AllowOMCodeOverrideThrottleSettings
      'MaxQueryLookupFields'                      = $webApplication.MaxQueryLookupFields
      'UnthrottledPrivilegedOperationWindowEnabled' = $webApplication.UnthrottledPrivilegedOperationWindowEnabled
      'MaxUniquePermScopesPerList'                = $webApplication.MaxUniquePermScopesPerList
      'IsBackwardsCompatible'                     = $webApplication.IsBackwardsCompatible
      'PerformThrottle'                           = $webApplication.HttpThrottleSettings.PerformThrottle
      'Days'                                      = $($webApplication.ChangeLogRetentionPeriod.days)
    }
		
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}
