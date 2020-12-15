try {

$backupdir="C:\AlteryxBackup"
$backupcompressed="C:\AlteryxCompressedBackup"
$azureconnstring="DefaultEndpointsProtocol=https;AccountName=XXXXXXXXXXX;AccountKey=XXXXXXXXXXXXXX;EndpointSuffix=core.windows.net"
$alteryx="C:\Program Files\Alteryx\bin\AlteryxService.exe" 

write-host "Cleaning Backup Directories"
Remove-Item "C:\AlteryxBackup\*" -Force -Confirm:$false -Recurse
Remove-Item "C:\AlteryxCompressedBackup\*" -Force -Confirm:$false -Recurse

write-host "Stopping Alteryx"
& $alteryx stop
write-host "Taking Mongodb Dump"
& "C:\Program Files\Alteryx\bin\AlteryxService.exe" emongodump=$backupdir

$date = Get-Date -format "yyyy-MM-dd"

$compress = @{
   Path = "$backupdir\*"
   DestinationPath = "$backupcompressed\alteryx-backup-$date.zip"
   CompressionLevel = "Fastest"
}
write-host "Zipping the backup directory"
Compress-Archive @compress
write-host "Upload to Azure Blob"
az storage blob upload --container-name AzureBackupContainerName --file $backupcompressed\alteryx-backup-$date.zip --name alteryx\alteryx-backup-$date.zip --connection-string $azureconnstring

write-host "Starting Alteryx"
& $alteryx start
write-host "Backup completed!!"
Remove-Item "C:\AlteryxBackup\*" -Force -Confirm:$false -Recurse

$backupdate = Get-Date -format "s"
$backupsuccessmsg=[string]::Concat($backupdate,"|BACKUPSUCCESS|alteryx")
write-host $backupsuccessmsg

Add-Content -Path 'C:\alteryxbackuplog.txt' -Value $backupsuccessmsg

}

catch {
$backupdate = Get-Date -format "s"
$backupfailmsg=[string]::Concat($backupdate,"|BACKUPFAIL|alteryx")
write-host $backupfailmsg

Add-Content -Path 'C:\alteryxbackuplog.txt' -Value $backupfailmsg

}
