#description: Install the SentinelOne agent.
#execution mode: Individual
#tags: Nerdio, SentinelOne, Preview

<#
Notes:
The installation script requires an Agent version, Site token and API token.

    Agent version: In the Management Console, click Sentinels > Packages. Copy the
version number of the Agent to deploy.

    Site token: In Sentinels > Packages, click Copy token.

    API token: Click Settings > Users > My User. Click Generate or Options > Regenerate
API Token.

You must provide secure variables to this script as seen in the Required Variables section. 
Set these up in Nerdio Manager under Settings->Portal. The variables to create are:
    S1AgentVersion
    S1SiteToken
    S1APItoken
#>

##### Required Variables #####

$SiteToken = $SecureVars.S1SiteToken
$AgentVersion = $SecureVars.S1AgentVersion
$APItoken = $SecureVars.S1APItoken

##### Script Logic #####

$sub = get-azsubscription -SubscriptionId $AzureSubscriptionId

set-azcontext -subscription $sub 

$Settings = @{"WindowsAgentVersion" = $AgentVersion; "SiteToken" = $SiteToken}

$ProtectedSettings = @{"SentinelOneConsoleAPIKey" = $APItoken};

Set-AzVMExtension -ResourceGroupName $AzureResourceGroupName -Location $AzureRegionName -VMName $AzureVMName -Name "SentinelOne.WindowsExtension" -Publisher "SentinelOne.WindowsExtension" -Type "WindowsExtension" -TypeHandlerVersion "1.0" -Settings $Settings -ProtectedSettings $ProtectedSettings


