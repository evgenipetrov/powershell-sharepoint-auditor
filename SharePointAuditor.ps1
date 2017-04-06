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
if ($env:PSModulePath -notlike "*$PSScriptRoot*")
{
  $env:PSModulePath += ';C:\projects\powershell-sharepoint-auditor\Modules'
}

# reload module to reflect module changes
if (Get-Module -Name SharePointAudit)
{
  Remove-Module -Name SharePointAudit
}



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
Select-Object -Property $properties, * -ExcludeProperty ServiceName

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

#region 'Resource Throttling'
$properties = @{
  n = 'Display Name'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'View Threshold'
  e = {
    $_.MaxItemsPerThrottledOperation
  }
}, 
@{
  n = 'View Threshold Admins'
  e = {
    $_.MaxItemsPerThrottledOperationOverride
  }
}, 
@{
  n = 'API Override'
  e = {
    $_.AllowOMCodeOverrideThrottleSettings
  }
}, 
@{
  n = 'Lookup Threshold'
  e = {
    $_.MaxQueryLookupFields
  }
}, 
@{
  n = 'Large Queries Window'
  e = {
    $_.UnthrottledPrivilegedOperationWindowEnabled
  }
}, 
@{
  n = 'Permission Threshold'
  e = {
    $_.MaxUniquePermScopesPerList
  }
}, 
@{
  n = 'Back. Comp. Event Handlers'
  e = {
    $_.IsBackwardsCompatible
  }
}, 
@{
  n = 'Monitor HTTP Requests'
  e = {
    $_.PerformThrottle
  }
}, 
@{
  n = 'Delete Change Log'
  e = {
    $_.Days
  }
}
Get-SPAuditWebApplicationsResourceThrottling |
Select-Object -Property $properties |
Format-Table -AutoSize

#endregion 'Resource Throttling'

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

Get-SPAuditWebApplicationWorkflowSettings |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'workflow settings'

#region 'web applications features'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Feature Name'
  e = {
    $_.FeatureName
  }
}, 
@{
  n = 'Compatibility Level'
  e = {
    $_.CompatibilityLevel
  }
}, 
@{
  n = 'Active'
  e = {
    $_.IsActive
  }
}
Get-SPAuditWebApplicationsFeatures |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'web applications features'

#region 'web application managed paths'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Name'
  e = {
    $_.Name
  }
}, 
@{
  n = 'Prefix Type'
  e = {
    $_.PrefixType
  }
}

Get-SPAuditWebApplicationsManagedPaths |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'web application managed paths'


#region 'self service site creation'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Url'
  e = {
    $_.Url
  }
}, 
@{
  n = 'Allowed'
  e = {
    $_.Allowed
  }
}, 
@{
  n = 'Require Secondary Contact'
  e = {
    $_.RequireSecondaryContact
  }
}

Get-APAuditSelfServiceSiteCreation|
Select-Object -Property $properties|
Format-Table -AutoSize
#endregion 'self service site creation'

#region 'web part security
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Online Web Part Gallery'
  e = {
    $_.OnlineWebPartGallery
  }
}, 
@{
  n = 'Web Part Connections'
  e = {
    $_.WebPartConnections
  }
}, 
@{
  n = 'Scriptable Web Parts'
  e = {
    $_.ScriptableWebParts
  }
}

Get-SPAuditWebApplicationWebPartSecurity|
Select-Object -Property $properties|
Format-Table -AutoSize
#endregion 'web part security

#region 'user policy'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'User'
  e = {
    $_.UserDisplayName
  }
}, 
@{
  n = 'Username'
  e = {
    $_.Username
  }
}, 
@{
  n = 'Policy Role Bindings'
  e = {
    $_.PolicyRoleBindings
  }
}, 
@{
  n = 'SystemUser'
  e = {
    $_.SystemUser
  }
}
Get-SPAuditWebApplicationUserPolicy |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'user policy'

#region alternate access mappings
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
}, 
@{
  n = 'Internal Url'
  e = {
    $_.InternalUrl
  }
}, 
@{
  n = 'Zone'
  e = {
    $_.Zone
  }
}, 
@{
  n = 'Url'
  e = {
    $_.Url
  }
}
Get-SPAuditAlternateAccessMappings |
Select-Object -Property $properties |
Format-Table -AutoSize


#endregion alternate access mappings

#region 'IIS settings'
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
},
@{
  n = 'Url'
  e = {
    $_.Url
  }
}, 
@{
  n = 'Zone'
  e = {
    $_.Zone
  }
}, 
@{
  n = 'Authentication'
  e = {
    $_.Authentication
  }
}, 
@{
  n = 'Application Pool Name'
  e = {
    $_.ApplicationPoolName
  }
}, 
@{
  n = 'Application Pool Identity'
  e = {
    $_.ApplicationPoolIdentity
  }
}, 
@{
  n = 'SSL'
  e = {
    $_.SSL
  }
}, 
@{
  n = 'Claims Auth'
  e = {
    $_.ClaimsAuth
  }
}, 
@{
  n = 'CEIP'
  e = {
    $_.CEIP
  }
}
Get-SPAuditIISSettings |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'IIS settings'

#region 'object cache accounts
$properties = @{
  n = 'Web Application'
  e = {
    $_.DisplayName
  }
},
@{
  n = 'Super User Account'
  e = {
    $_.SuperUserAcount
  }
},
@{
  n = 'Has Full Control'
  e = {
    $_.SuperUserHasFullControl
  }
},
@{
  n = 'Super Reader Account'
  e = {
    $_.SuperReaderAcount
  }
},
@{
  n = 'Has Full Read'
  e = {
    $_.SuperReaderHasFullRead
  }
}

Get-SPAuditObjectCacheAccounts |
Select-Object -Property $properties |
Format-Table -AutoSize
#endregion 'object cache accounts

#region 'site collections list'
$properties = @{
  n = 'Web Application'
  e = {
    $_.WebApplication
  }
},
@{
  n = 'Title'
  e = {
    $_.Title
  }
},
@{
  n = 'Url'
  e = {
    $_.Url
  }
},
@{
  n = 'Content Database'
  e = {
    $_.ContentDatabase
  }
},
@{
  n = 'Owners'
  e = {
    $_.Owners
  }
}
Get-SPAuditSiteCollectionsList |
Select-Object -Property $properties |
Format-Table -AutoSize 
#endregion 'site collections list'

#region 'site collection usage and properties'

$properties = @{
  n = 'Site Collection Title'
  e = {
    $_.Title
  }
},
@{
  n = 'Url'
  e = {
    $_.Url
  }
},
@{
  n = 'Language'
  e = {
    $_.Language
  }
},
@{
  n = 'Number of webs'
  e = {
    $_.WebsCount
  }
},
@{
  n = 'UI Version'
  e = {
    $_.UIVersion
  }
},
@{
  n = 'Storage[GB]'
  e = {
    $_.Storage/1GB -as [int]
  }
}

Get-SPAuditSiteCollectionsUsageAndProperties |
Select-Object -Property $properties |
Format-Table -AutoSize 
#endregion 'site collection usage and properties'
















