function Get-SPAuditComputerName
{
  #Content
  param
  (
    [String]
    [Parameter(Mandatory)]
    $Address
  )
  
  try
  {
    $output = Get-SPAuditComputerNameByHost -Hostname $Address
  }
  catch
  {
    $output = Get-SPAuditComputerNameByAlias -Alias $Address
  }
  
  Write-Output $output
}