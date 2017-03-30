function Get-SPAuditSharePointLicense
{
  param
  (
    [Parameter(Mandatory)]
    [System.Guid[]]
    $Products
  )
  
  #$Products
  
  foreach ($product in $Products)
  {
    switch -Exact ($product.Guid.ToString().ToUpper())
    {
      '9FF54EBC-8C12-47D7-854F-3865D4BE8118' 
      {
        $license = 'SharePoint Foundation 2013'
      } 
      'B7D84C2B-0754-49E4-B7BE-7EE321DCE0A9' 
      {
        $license = 'SharePoint Server 2013 Enterprise'
      } 
      '298A586A-E3C1-42F0-AFE0-4BCFDC2E7CD0' 
      {
        $license = 'SharePoint Server 2013 Enterprise Preview'
      }
      default      
      {
        $license = 'Unknown License'
      } 
    }
  }
  

    
  Write-Output -InputObject  $license

}
