function Get-SPAuditContentDatabases
{
  $contentDatabases = Get-SPContentDatabase
  
  foreach ($contentDatabase in $contentDatabases)
  {
    $properties = @{
      'Name' = $contentDatabase.Name
    }
    		
    $output = New-Object -TypeName PSObject -Property $properties

    Write-Output -InputObject $output
  }
}
