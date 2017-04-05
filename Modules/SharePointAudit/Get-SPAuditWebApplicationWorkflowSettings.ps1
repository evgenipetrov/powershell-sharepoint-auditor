function Get-SPAuditWebApplicationWorkflowSettings
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $properties = @{
      'DisplayName' = $webApplication.DisplayName
      'AllowInternalUsers' = $webApplication.UserDefinedWorkflowsEnabled
      'AllowExternalUsers' = $webApplication.ExternalWorkflowParticipantsEnabled
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output -InputObject $output
  }
}
