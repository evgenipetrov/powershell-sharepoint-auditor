function Get-SPAuditWebApplicationUserPolicy
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  $managedAccountUsernames = Get-SPManagedAccount | Select-Object -ExpandProperty UserName
  
  foreach ($webApplication in $webApplications)
  {
    $policies = $webApplication.Policies
    
    foreach ($policy in $policies)
    {
        $systemUser = $managedAccountUsernames.Contains($policy.UserName)
          $properties = @{
            'DisplayName' = $webApplication.DisplayName
            'UserDisplayName' = $policy.DisplayName
            'Username' = $policy.UserName
            'PolicyRoleBindings' = $policy.PolicyRoleBindings.Name
            'SystemUser' = $systemUser
          }
          
          $output = New-Object -TypeName PSObject -Property $properties
          
          Write-Output $output
    }
    

  }
  
}