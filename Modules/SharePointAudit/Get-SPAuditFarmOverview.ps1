function Get-SPAuditFarmOverview 
{
  PROCESS {
    $farm = Get-SPFarm
    $date = Get-Date
    $configurationDatabase = Get-SPDatabase | Where-Object -FilterScript {$_.Type -eq 'Configuration Database'}
    
    $properties = @{
      'ReportName'          = 'Farm Overview'
      'FarmName'            = $farm.Name
      'BuildVersion'        = $farm.BuildVersion.ToString()
      'SharePointEdition'   = ''
      'ConfigurationDatabase' = $configurationDatabase.Name
      'FarmServerCount'     = $farm.Servers.Count
      'ReportCreatedOn'     = $date.ToString()
    }
		
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}
