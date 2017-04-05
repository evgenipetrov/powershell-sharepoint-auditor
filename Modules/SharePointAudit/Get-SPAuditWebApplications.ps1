function Get-SPAuditWebApplications
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $properties = @{
      'DisplayName' = $webApplication.DisplayName
      'Url'       = $webApplication.Url
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output -InputObject $output
  }
}
