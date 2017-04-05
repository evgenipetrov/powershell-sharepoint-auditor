function Get-SPAuditTimeZoneById {
    param(
        [int]$Id
    )

    $output = [Microsoft.SharePoint.SPregionalSettings]::GlobalTimeZones | Where-Object {$_.ID -eq $Id} | Select-Object -ExpandProperty Description
    if($output -eq $null){
        $output = '(none)'
    }

    Write-Output $output
}