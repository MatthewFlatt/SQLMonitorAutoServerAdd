# Connection details for the SQL Monitor database
$sqlMonitorDatabaseServer = "mymonitordatabaseserver.domain.local"
$sqlMonitorDatabase = "RedGateMonitor"
$username = "sa"
$password = "Password"

# Stop the SQL Monitor Base Monitor service while we insert server data
Stop-Service -DisplayName "SQL Monitor Base Monitor"

# Loop through the file containing server list
$reader = [System.IO.File]::OpenText("C:\temp\ExampleServerList.txt")
try{
    for() {
        $line = $reader.ReadLine()
        # break at end of file
        if ($line -eq $null) { break }
        # Split line on , - server name and whether cluster or not
        $parts = $line.Split(',')
        $clusterName = $parts[0]
        # 1 for a cluster, 0 for a single machine
        $isCluster = $parts[1]

        # Insert row into SQL Montitor database
        Invoke-Sqlcmd "INSERT INTO [settings].[Clusters]
            ([Id], [CreatedDate], [ModifiedDate], [IsValid], [IsSuspended], [CredentialsDiscriminator], [User], [Domain], [Password], [Name], [IsCluster],
            [IsAddressDetected], [NodeCount], [RequestedLicenceLevel], [EffectiveLicenceLevel], [MW_IsEnabled], [MW_Start], [MW_Duration], [MW_Monday], [MW_Tuesday],
            [MW_Wednesday], [MW_Thursday], [MW_Friday], [MW_Saturday], [MW_Sunday])
                VALUES
            (NEWID(), utils.DateTimeToTicks(GETDATE()), utils.DateTimeToTicks(GETDATE()), 1, 0, 0, NULL, NULL, NULL, '$clusterName', '$isCluster', 1, 1, 1, 1, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0);" -ServerInstance $sqlMonitorDatabaseServer -Database $sqlMonitorDatabase -Username $username -Password $password
    }
}
finally {
    $reader.Close()
}

# Start SQL Monitor service
Start-Service -DisplayName "SQL Monitor Base Monitor"

# Wait two minutes for SQL Monitor to detect nodes and instances, then restart to complete configuration
Start-Sleep -Seconds 120
Stop-Service -DisplayName "SQL Monitor Base Monitor"
Start-Service -DisplayName "SQL Monitor Base Monitor"
