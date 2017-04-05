<#
    .SYNOPSIS
    SharePoint 2013 Farm Audit Script
    .DESCRIPTION
    <A detailed description of the script>
    .PARAMETER <paramName>
    <Description of script parameter>
    .EXAMPLE
    <An example of using the script>
#>

# add sharepoint pssnapin if it is not added to shell
try
{
  $null = Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction Stop
}
catch
{
  Add-PSSnapin -Name Microsoft.SharePoint.PowerShell
}

# add custom module to path
if ($env:PSModulePath -notlike '*SharePointAudit*')
{
  $env:PSModulePath += ';C:\projects\powershell-sharepoint-auditor\Modules'
}

# reload module to reflect module changes
if (Get-Module -Name SharePointAudit)
{
  Remove-Module -Name SharePointAudit
}

<#

    #region 'farm overview'

    $properties = @{
    n = 'Report Name'
    e = {
    $_.ReportName
    }
    }, 
    @{
    n = 'Farm Name'
    e = {
    $_.FarmName
    }
    }, 
    @{
    n = 'Installed SharePoint Version'
    e = {
    $_.BuildVersion
    }
    }, 
    @{
    n = 'Patch Level'
    e = {
    $_.PatchLevel
    }
    }, 
    @{
    n = 'SharePoint SKU Edition'
    e = {
    $_.SharePointLicense
    }
    }, 
    @{
    n = 'Configuration Database'
    e = {
    $_.ConfigurationDatabase
    }
    }, 
    @{
    n = 'Number of Servers in Farm'
    e = {
    $_.FarmServerCount
    }
    }, 
    @{
    n = 'Report Generated on'
    e = {
    $_.ReportCreatedOn
    }
    }

    Get-SPAuditFarmOverview |
    Select-Object -Property $properties  |
    Format-List

    #endregion

    #region 'servers in farm'
    $properties = @{
    n = 'Server Name'
    e = {
    $_.ServerName
    }
    }, 
    @{
    n = 'Role'
    e = {
    $_.Role
    }
    }, 
    @{
    n = 'Operating System'
    e = {
    $_.OperatingSystem
    }
    }, 
    @{
    n = 'Memory[GB]'
    e = {
    $_.Memory / 1GB -as [int]
    }
    }


    Get-SPAuditServersInFarm |
    Select-Object -Property $properties  |
    Format-Table -AutoSize

    #endregion

    #region 'web applications and site collections'

    $properties = @{
    n = 'Web Application'
    e = {
    $_.WebApplication
    }
    }, 
    @{
    n = 'Site Collection'
    e = {
    $_.SiteCollection
    }
    }, 
    @{
    n = 'Site Admins'
    e = {
    $_.SiteAdmins
    }
    }


    Get-SPAuditWebApplicationsAndSiteCollections |
    Select-Object -Property $properties  |
    Format-Table -AutoSize

    #endregion

    #region 'content databases'
    $properties = @{
    n = 'Name'
    e = {
    $_.Name
    }
    }


    Get-SPAuditContentDatabases |
    Select-Object -Property $properties  |
    Format-Table -AutoSize

    #endregion

    #region 'farm topology'
    $properties = @{
    n = 'Server Name'
    e = {
    $_.ServerName
    }
    }, 
    @{
    n = 'IP Address'
    e = {
    $_.IPAddress
    }
    }, 
    @{
    n = 'Role'
    e = {
    $_.Role
    }
    }, 
    @{
    n = 'Central Admin'
    e = {
    $_.HostsCentralAdmin
    }
    }

    Get-SPAuditFarmTopology |
    Select-Object -Property $properties
    #endregion

    #region 'site topology'

    $properties = @{
    n = 'Web Application'
    e = {
    $_.WebApplication
    }
    },
    @{
    n = 'Site Collection'
    e = {
    $_.SiteCollection
    }
    },
    @{
    n = 'Content Database'
    e = {
    $_.ContentDatabase
    }
    }

    Get-SPAuditSiteTopology |
    Select-Object -Property $properties |
    Format-List -Property *
    #endregion

    #region 'search topology'

    $properties = @{
    n = 'Server Name'
    e = {
    $_.ComputerName
    }
    },
    @{
    n = 'Admin Component'
    e = {
    $_.AdminComponent
    }
    },
    @{
    n = 'Analytics Processing Component'
    e = {
    $_.AnalyticsProcessingComponent
    }
    },
    @{
    n = 'ContentProcessing Component'
    e = {
    $_.ContentProcessingComponent
    }
    },
    @{
    n = 'Crawl Component'
    e = {
    $_.CrawlComponent
    }
    },
    @{
    n = 'Index Component'
    e = {
    $_.IndexComponent
    }
    },
    @{
    n = 'Query Processing Component'
    e = {
    $_.QueryProcessingComponent
    }
    }

    Get-SPAuditSearchTopology |
    Select-Object -Property $properties |
    Format-Table -Property * -AutoSize
    #endregion 'search topology'

    #region 'services on server'

    $properties = @{
    n = 'Service Name'
    e = {
    $_.ServiceName
    }
    }

    Get-SPAuditServicesOnServer |
    Select-Object -Property $properties,* -ExcludeProperty ServiceName

    #endregion 'services on server'
    
    #region 'web applications list'
    $properties = @{
    n = 'Display Name'
    e = {
    $_.DisplayName
    }
    }, 
    @{
    n = 'Url'
    e = {
    $_.Url
    }
    }

    Get-SPAuditWebApplications |
    Select-Object -Property $properties |
    Format-Table -AutoSize

    #endregion 'web applications list'
    
#>

#region 'general settings'

$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Default Time Zone'
  e = {
    $_.DefaultTimeZone
  }
}, 
@{
  n = 'Default Quota Template'
  e = {
    $_.DefaultQuotaTemplate
  }
}

Get-SPAuditWebApplicationGeneralSettings | 
Select-Object -Property $properties |
Format-Table  -AutoSize
 
#endregion 'general settings'

#region 'workflow settings'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Allow Internal Users'
  e = {
    $_.AllowInternalUsers
  }
}, 
@{
  n = 'Allow External Users'
  e = {
    $_.AllowExternalUsers
  }
}

Get-SPAuditWebApplicationWorkflowSettings|
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'workflow settings'







