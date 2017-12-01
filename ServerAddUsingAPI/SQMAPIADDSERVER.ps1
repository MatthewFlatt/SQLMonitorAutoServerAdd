Param(
[Parameter(Mandatory=$True)]
[string]$monitorServer,

[Parameter(Mandatory=$True)]
[string]$authToken,


[Parameter(Mandatory=$True)]
[string]$sqlServer,

[string]$group,
[string]$baseMonitorAccount,
[string]$windowsUserName,
[string]$windowsPassword,

[string]$sameAsWindowsCredentials,
[string]$authenticationMode,
[string]$sqlUserName,
[string]$sqlPassword
)

if ([string]::IsNullOrWhiteSpace($baseMonitorAccount)) { $baseMonitorAccount = "true" }
if ([string]::IsNullOrWhiteSpace($sameAsWindowsCredentials)) { $sameAsWindowsCredentials = "true" }
if ([string]::IsNullOrWhiteSpace($authenticationMode)) { $authenticationMode = "windows" }  
 



$body = @"
          [  
            {
                "group" : "$group",
                "SqlServers" : "$sqlServer",
                "WindowsMachineCredentials": 
                {
                    "IsBaseMonitorAccount" : "$baseMonitorAccount",
                    "UserName" : "$windowsUserName",
                    "Password" : "$windowsPassword"
                },
                "SqlServerCredentials" :
                {
                    "IsSameAsWindowsCredentials" : "$sameAsWindowsCredentials",
                    "AuthenticationMode" : "$authenticationMode",
                    "UserName" : "$sqlUserName",
                    "Password" : "$sqlPassword"
                }
                           
            }
          ]
"@


$url = "$monitorServer/api/v1/monitoredservers?AuthToken=$authToken"

Invoke-RestMethod -Method Post -Uri $url -ContentType 'application/json' -Body $body -Verbose

