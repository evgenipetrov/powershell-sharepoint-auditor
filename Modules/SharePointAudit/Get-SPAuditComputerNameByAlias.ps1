function Get-SPAuditComputerNameByAlias
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $Alias  
  )
  
  $registryKey = Get-ItemProperty HKLM:\software\Microsoft\MSSQLServer\Client\ConnectTo
  
  $array = ($registryKey.$Alias) -split ","
  $output = $array[1]
  
  Write-Output $output

}