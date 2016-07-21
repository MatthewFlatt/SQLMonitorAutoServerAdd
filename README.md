# SQLMonitorAutoServerAdd
Add SQL Server machines to SQL Monitor from a file.

Use this script to take a list of SQL Server machines in a file, and add them to SQL Monitor.

File format:
Each server on a new line.
Standalone machine or cluster determined by 0 or 1 after the server name, split by a column.

Examples:
Standalone machine:

machinename,0

Cluster:

clustername,1

This script must be run on the machine on which the SQL Monitor Base Monitor service is installed, and be able to contact the SQL Monitor database.
