$dateTimeString = Get-Date -Format "ddMMyyyy_HHmm"
$deployedAppLocation = Read-Host "Enter the deployed application path: "
$backupDestination = Join-Path $deployedAppLocation "Backup\Equipcom_$dateTimeString"
$excludeBackup = Join-Path $deployedAppLocation "Backup"

$zipFilePath = Read-Host "Enter the zip file path: "

# Create the backup destination folder
New-Item -ItemType Directory -Path $backupDestination -Force

# Copy the contents of the deployedAppLocation excluding the specified folder
Get-ChildItem -Path $deployedAppLocation -Exclude $excludeBackup | 
	Where-Object { $_.FullName -notlike $excludeBackup } | 
	ForEach-Object { Copy-Item -Path $_.FullName -Destination $backupDestination -Recurse -Force }  
