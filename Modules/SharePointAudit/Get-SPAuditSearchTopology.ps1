function Get-SPAuditSearchTopology
{
  $servers = Get-SPServer | Where-Object -FilterScript {
    $_.Role -eq 'Application'
  }
  
  $ssa = Get-SPEnterpriseSearchServiceApplication
  $active = Get-SPEnterpriseSearchTopology -Active -SearchApplication $ssa 
  
  foreach ($server in $servers)
  {
  
    $components = Get-SPEnterpriseSearchComponent -SearchTopology $active | Where-Object {$_.ServerName -eq $server.Address}
  
    $properties = @{
      'ComputerName' = $server.Address
      'AdminComponent' = ($components | Where-Object {$_.Name -like 'AdminComponent*'}) -ne $null
      'AnalyticsProcessingComponent' = ($components | Where-Object {$_.Name -like 'AnalyticsProcessingComponent*'}) -ne $null
      'ContentProcessingComponent' = ($components | Where-Object {$_.Name -like 'ContentProcessingComponent*'}) -ne $null
      'CrawlComponent' = ($components | Where-Object {$_.Name -like 'CrawlComponent*'}) -ne $null
      'IndexComponent' = ($components | Where-Object {$_.Name -like 'IndexComponent*'}) -ne $null
      'QueryProcessingComponent' = ($components | Where-Object {$_.Name -like 'QueryProcessingComponent*'}) -ne $null
      
    }
    
    $output = New-Object -TypeName PSObject -Property $properties

    Write-Output -InputObject $output
  }
}





