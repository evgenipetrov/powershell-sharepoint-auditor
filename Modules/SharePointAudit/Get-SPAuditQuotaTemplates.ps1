function Get-SPAuditQuotaTemplates
{
  $quotaTemplates = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates
  
  foreach ($quotaTemplate in $quotaTemplates)
  {
    $properties=@{
      'TemplateName' = $quotaTemplate.Name
      'StorageMaximumLevel'=$quotaTemplate.StorageMaximumLevel
      'StorageWarningLevel'=$quotaTemplate.StorageWarningLevel
      'InvitedUserMaximumLevel'=$quotaTemplate.InvitedUserMaximumLevel
      'UserCodeMaximumLevel'=$quotaTemplate.UserCodeMaximumLevel
      'UserCodeWarningLevel'=$quotaTemplate.UserCodeWarning.Level
      'WarningLevelEmail' = '?'
    }
    
    $output = New-Object -TypeName PSObject -Property $properties
    
    Write-Output $output
  }
  
}