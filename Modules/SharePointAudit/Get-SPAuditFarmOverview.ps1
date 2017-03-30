function Get-SPAuditFarmOverview 
{
  PROCESS {
    $farm = Get-SPFarm
    $date = Get-Date
    
    $properties = @{
      'ReportName'          = 'Farm Overview'
      'FarmName'            = $farm.Name
      'BuildVersion'        = $farm.BuildVersion.ToString()
      'SharePointEdition'   = ''
      'ConfigurationDatabase' = ''
      'FarmServerCount'     = $farm.Servers.Count
      'ReportCreatedOn'     = $date.ToString()
    }
		
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}
