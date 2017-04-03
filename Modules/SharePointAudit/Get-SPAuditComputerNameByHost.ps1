function Get-SPAuditComputerNameByHost
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $Hostname  
  )
  
  $output = ([System.Net.Dns]::GetHostByName($Hostname)).Hostname
  
  Write-Output $output
}