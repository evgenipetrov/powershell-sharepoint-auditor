function Get-SPAuditDistributedCacheConfiguration
{
  Use-CacheCluster
  $cacheHosts=Get-CacheHost
  foreach ($cacheHost in $cacheHosts)
  {
    $cacheHostConfig = Get-CacheHostConfig -ComputerName $cacheHost.Hostname -CachePort $cacheHost.PortNo
    $properties = @{
    'Host'=$cacheHostConfig.HostName
    'Size'=$cacheHostConfig.Size
    'CachePort'=$cacheHostConfig.CachePort
    'ClusterPort'=$cacheHostConfig.ClusterPort
    'ArbitrationPort'=$cacheHostConfig.ArbitrationPort
    'ReplicationPort'=$cacheHostConfig.ReplicationPort
    'Status'=$cacheHost.Status
  }

  $output = New-Object -TypeName PSObject -Property $properties

  Write-Output $output

}