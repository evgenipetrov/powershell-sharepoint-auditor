function Get-SPAuditFarmTopology
{
  PROCESS {
    $servers = Get-SPServer
    
    foreach ($server in $servers)
    {
      $computerName = Get-SPAuditComputerName -Address $server.Address

      $ipAddress = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -ComputerName $computerName | 
                        Where-Object {$_.IPAddress -ne $null} | 
                        Select-Object -ExpandProperty IPAddress

      $centralAdminServiceInstance = Get-SPServiceInstance | Where-Object {$_.TypeName -eq 'Central Administration' -and ($_.Server|Select-Object -ExpandProperty Name) -eq $server.Address}
      
      if($centralAdminServiceInstance -ne $null){
        $hostsCentralAdmin = $true
      } else {
        $hostsCentralAdmin = $false
      }

      $properties = @{
        'ServerName'         = $server.Address
        'IPAddress'          = $ipAddress
        'Role'               = $server.Role
        'HostsCentralAdmin'  = $hostsCentralAdmin
      }
		
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}







