function Get-SPAuditWebApplicationsManagedPaths
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $managedPaths = Get-SPManagedPath -WebApplication $webApplication
    
    foreach ($managedPath in $managedPaths)
    {
      if($managedPath.Name -eq '')
      {
        $name = '/'
      }
      else 
      {
        $name = '/{0}/' -f $managedPath.Name
      }
      
      if ($managedPath.Type -eq 'ExplicitInclusion')
      {
        $prefixType = 'Explicit Inclusion'
      }
      elseif($managedPath.Type -eq 'WildcardInclusion') 
      {
        $prefixType = 'Wildcard Inclusion'
      }
      
    
      $properties = @{
        'DisplayName' = $webApplication.DisplayName
        'Name'      = $name
        'PrefixType' = $prefixType
      }
    
      $output = New-Object -TypeName PSObject -Property $properties
    
      Write-Output -InputObject $output
    }
  }
}
