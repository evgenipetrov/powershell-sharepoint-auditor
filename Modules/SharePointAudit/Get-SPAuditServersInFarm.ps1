function Get-SPAuditServersInFarm
{
  PROCESS {
    $servers = Get-SPServer
    
    foreach ($server in $servers)
    {
      $computerName = Get-SPAuditComputerName -Address $server.Address
      
      $os = Get-CimInstance -ClassName CIM_OperatingSystem -ComputerName $computerName
      $memory = Get-CimInstance -ClassName CIM_PhysicalMemory -ComputerName $computerName
    
      $properties = @{
        'ReportName'    = 'Servers in Farm'
        'ServerName'    = $server.Address
        'Role'          = $server.Role
        'OperatingSystem' = $os.Caption
        'Memory'        = $memory.Capacity
      }
		
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}







