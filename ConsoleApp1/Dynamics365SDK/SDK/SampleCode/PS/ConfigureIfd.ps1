param
(
    #optional params
    [string]$DiscoveryWebServiceRootDomain,
    [boolean]$Enabled,
    [string]$ExternalDomain,
    [string]$OrganizationWebServiceRootDomain,    
    [string]$WebApplicationRootDomain
)

$RemoveSnapInWhenDone = $False

if (-not (Get-PSSnapin -Name Microsoft.Crm.PowerShell -ErrorAction SilentlyContinue))
{
    Add-PSSnapin Microsoft.Crm.PowerShell
    $RemoveSnapInWhenDone = $True
}

$IfdSettings = Get-CrmSetting -SettingType IfdSettings

if($DiscoveryWebServiceRootDomain) {$IfdSettings.DiscoveryWebServiceRootDomain = $DiscoveryWebServiceRootDomain}
if($ExternalDomain) {$IfdSettings.ExternalDomain = $ExternalDomain}
if($PSBoundParameters.ContainsKey('Enabled')) {$IfdSettings.Enabled = $Enabled}
if($OrganizationWebServiceRootDomain) {$IfdSettings.OrganizationWebServiceRootDomain = $OrganizationWebServiceRootDomain}
if($WebApplicationRootDomain) {$IfdSettings.WebApplicationRootDomain = $WebApplicationRootDomain}

Set-CrmSetting -Setting $IfdSettings

$IfdSettings

if($RemoveSnapInWhenDone)
{
    Remove-PSSnapin Microsoft.Crm.PowerShell
}
