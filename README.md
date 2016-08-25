# Add SQL Server machines to SQL Monitor from a file.


Use this script to take a list of SQL Server machines in a file, and add them to SQL Monitor.

File format:
Each server on a new line.
Standalone machine or cluster determined by 0 or 1 after the server name, split by a comma. Group name after the 0 or 1, split by a comma.

Examples:
Standalone machine:

machinename,0,groupname

Cluster:

clustername,1,groupname

This script must be run on the machine on which the SQL Monitor Base Monitor service is installed, and be able to contact the SQL Monitor database.
