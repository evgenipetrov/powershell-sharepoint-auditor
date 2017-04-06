function Get-SPAuditObjectCacheAccounts
{
  $webApplications = Get-SPWebApplication
    
  foreach ($webApplication in $webApplications)
  {
    $superUserAccount = $webApplication.Properties['portalsuperuseraccount']
    $superUserHasFullControl = (($webApplication.Policies | Where-Object {$_.UserName -like "*$superUserAccount"} ) | Select-Object -First 1 -ExpandProperty PolicyRoleBindings ).Name -eq 'Full Control'
    $superReaderAccount = $webApplication.Properties['portalsuperreaderaccount']
    $superReaderHasFullRead = (($webApplication.Policies | Where-Object {$_.UserName -like "*$superReaderAccount"} ) | Select-Object -First 1 -ExpandProperty PolicyRoleBindings ).Name -eq 'Full Read'
    $properties = @{
      'DisplayName'     = $webApplication.DisplayName
      'SuperUserAcount' = $superUserAccount
      'SuperUserHasFullControl' = $superUserHasFullControl
      'SuperReaderAcount' = $superReaderAccount
      'SuperReaderHasFullRead' = $superReaderHasFullRead
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output $output
  }
}
