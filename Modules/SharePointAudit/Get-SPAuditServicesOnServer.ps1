function Get-SPAuditServicesOnServer
{
  $servers = Get-SPServer | Where-Object -FilterScript {
    $_.Role -eq 'Application'
  }
  
  $services = Get-SPServiceInstance
  
  foreach ($service in $services)
  {
    $properties = @{
      'ServiceName' = $service.TypeName
    }
    
    foreach ($server in $servers)
    {
      $serverName = $server.Address
      $serviceStatus = $service.Status
      
      $properties.Add($serverName,$serviceStatus)
    }
        
    $output = New-Object -TypeName PSObject -Property $properties

    Write-Output -InputObject $output
  }
}
