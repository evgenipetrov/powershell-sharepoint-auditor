function Get-SPAuditWebApplicationWebPartSecurity
{
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $properties = @{
      'DisplayName' = $webApplication.DisplayName
      'OnlineWebPartGallery' = $webApplication.AllowAccessToWebPartCatalog
      'WebPartConnections' = $webApplication.AllowPartToPartCommunication
      'ScriptableWebParts' = $webApplication.AllowContributorsToEditScriptableParts
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output -InputObject $output
  }
}
