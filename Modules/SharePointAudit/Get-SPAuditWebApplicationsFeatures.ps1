function Get-SPAuditWebApplicationsFeatures
{
  $features = Get-SPFeature | Where-Object -FilterScript {
    $_.Scope -eq 'WebApplication'
  }
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    foreach ($feature in $features)
    {
      $title = $feature.GetTitle(1033)
      $isActive = ($webApplication.Features | Where-Object {$_.DefinitionId -eq $feature.Id}) -ne $null
      
      $properties = @{
        'DisplayName'      = $webApplication.DisplayName
        'FeatureName'      = $title
        'CompatibilityLevel' = $feature.CompatibilityLevel
        'IsActive'         = $isActive
      }
    
      $output = New-Object -TypeName PSObject -Property $properties
      
      Write-Output -InputObject $output
    }
  }
}
