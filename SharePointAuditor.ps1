<#
    .SYNOPSIS
    <A brief description of the script>
    .DESCRIPTION
    <A detailed description of the script>
    .PARAMETER <paramName>
    <Description of script parameter>
    .EXAMPLE
    <An example of using the script>
#>

# add sharepoint pssnapin if it is not added to shell
try
{
  $null = Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction Stop
}
catch
{
  Add-PSSnapin -Name Microsoft.SharePoint.PowerShell
}

# add custom module to path
if ($env:PSModulePath -notlike '*SharePointAudit*')
{
  $env:PSModulePath += ';C:\projects\powershell-sharepoint-auditor\'
}

# reload module to reflect module changes
if (Get-Module -Name SharePointAudit)
{
  Remove-Module -Name SharePointAudit
}

$properties = @{
  n = 'Report Name'
  e = {
    $_.ReportName
  }
}, 
@{
  n = 'Farm Name'
  e = {
    $_.FarmName
  }
}, 
@{
  n = 'Installed SharePoint Version'
  e = {
    $_.BuildVersion
  }
}, 
@{
  n = 'Patch Level'
  e = {
    $_.PatchLevel
  }
}, 
@{
  n = 'SharePoint SKU Edition'
  e = {
    $_.SharePointLicense
  }
}, 
@{
  n = 'Configuration Database'
  e = {
    $_.ConfigurationDatabase
  }
}, 
@{
  n = 'Number of Servers in Farm'
  e = {
    $_.FarmServerCount
  }
}, 
@{
  n = 'Report Generated on'
  e = {
    $_.ReportCreatedOn
  }
}

Get-SPAuditFarmOverview |
Select-Object -Property $properties  |
Format-List


