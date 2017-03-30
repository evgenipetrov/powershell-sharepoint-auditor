function Get-SPAuditSharePointBuild
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $BuildVersion
  )
  
  $hash = @{
    '15.0.4569.1000' = 'SharePoint 2013 Service Pack 1'
  }

  $build = $hash.GetEnumerator() | Where-Object -FilterScript {
    $_.Name -eq $BuildVersion
  }

  if ($build)
  {
    Write-Output -InputObject $build.Value
  }
  else 
  {
    Write-Output -InputObject 'Unknoun Build Version'
  }
}
