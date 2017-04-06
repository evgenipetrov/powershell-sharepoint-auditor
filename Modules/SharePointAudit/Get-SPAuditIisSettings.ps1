function Get-SPAuditIISSettings
{
  #Content
  $webApplications = Get-SPWebApplication -IncludeCentralAdministration
  
  foreach ($webApplication in $webApplications)
  {
    $alternateUrls = Get-SPAlternateURL -WebApplication $webApplication
      
    foreach ($alternateUrl in $alternateUrls)
    {
      $authenticationProvider = Get-SPAuthenticationProvider -WebApplication $webApplication -Zone $alternateUrl.Zone
      $ssl = $webApplication.Url -like 'https*'
      if ($authenticationProvider.DisableKerberos -eq $true -and $authenticationProvider.UseWindowsIntegratedAuthentication -eq $true)
      {
        $authentication = 'NTLM'
      }
      elseif ($authenticationProvider.DisableKerberos -eq $false -and $authenticationProvider.UseWindowsIntegratedAuthentication -eq $true)
      {
        $authentication = 'Kerberos'
      }
      
      $properties = @{
        'DisplayName'           = $webApplication.DisplayName
        'Url'                  = $alternateUrl.IncomingUrl
        'Zone'                  = $alternateUrl.Zone
        'Authentication'        = $authentication
        'ApplicationPoolName'   = $webApplication.ApplicationPool.Name
        'ApplicationPoolIdentity' = $webApplication.ApplicationPool.Username
        'SSl'                   = $ssl
        'ClaimsAuth'            = $webApplication.UseClaimsAuthentication
        'CEIP'                  = $webApplication.BrowserCEIPEnabled
      }
      $output = New-Object -TypeName PSObject -Property $properties
              
      Write-Output -InputObject $output
    }
  }
}
