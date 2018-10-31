$LogPath = "C:\inetpub\logs\LogFiles" 
$maxDaystoKeep = -32
$outputPath = "C:\inetpub\logs\LogFiles\Cleanup_Old_logs.log" 

if (Test-Path -Path $outputPath) {Remove-Item -Path $outputPath}
  
$itemsToDelete = Get-Childitem -Path $LogPath -Recurse -File -Filter *.log | Where-Object LastWriteTime -lt ((get-date).AddDays($maxDaystoKeep)) 
  
if ($itemsToDelete.Count -gt 0){ 
    ForEach ($item in $itemsToDelete){ 
        "$($item.BaseName) is older than $((get-date).AddDays($maxDaystoKeep)) and will be deleted" | Add-Content $outputPath 
        Get-item $item.PSPath | Remove-Item -Verbose 
    } 
} 
ELSE{ 
    "No items to be deleted today $($(Get-Date).DateTime)"  | Add-Content $outputPath 
    } 
   
"Cleanup of log files older than $((get-date).AddDays($maxDaystoKeep)) completed..."  | Add-Content $outputPath
# start-sleep -Seconds 10