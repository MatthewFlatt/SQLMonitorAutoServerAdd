Add a server to SQL Monitor using the web API.

Parameters:

Required:
$monitorServer (the base URL of the SQL Monitor server - http://monitor.red-gate.com)
$authToken (Found on webserver machine in %programdata%\Red Gate\SQL Monitor\WebApi.config)
$sqlServer (The machine/cluster name of the SQL Server to add)

Optional:
$group (Group name to put server into - [1 - Production])
$baseMonitorAccount (specify "false" if you want to use an alernate account to connect to the windows host)
$windowsUserName (If "false" for $baseMonitorAccount, the Windows UserName to connect to the windows host) 
$windowsPassword (If "false" for $baseMonitorAccount, the Windows Password to connect to the windows host)
$sameAsWindowsCredentials (specify "false" to use an alternate account to connect to SQL instance)
$authenticationMode ("windows" or "sqlServer")
$sqlUserName (SQL login username to connect to SQL Server instance with) 
$sqlPassword (SQL login password to connect to SQL Server instance with)

