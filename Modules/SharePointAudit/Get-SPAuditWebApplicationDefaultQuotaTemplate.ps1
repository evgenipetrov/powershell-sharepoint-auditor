function Get-SPAuditWebApplicationDefaultQuotaTemplate
{
  param
  (
    [Microsoft.SharePoint.Administration.SPWebApplication]
    [Parameter(Mandatory)]
    $WebApplication
  )
  
  $quotaTemplateName = $WebApplication.DefaultQuotaTemplate
  
  if ($quotaTemplateName -eq '')
  {
    $output = 'No Quota'
  }
  else 
  {
    $output = $quotaTemplateName
  }
  
  Write-Output -InputObject $output
}
