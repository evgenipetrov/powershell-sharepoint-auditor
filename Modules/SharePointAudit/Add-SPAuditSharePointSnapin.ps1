function Add-SPAuditSharePointSnapin
{
  $snapin = Get-PSSnapin -Name Microsoft.SharePoint.PowerShell
  
  if (-not $snapin)
  {
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell
  }
}