$directory = ""
$processes = Get-Process | Where-Object { $_.Path -like "$directory\*" } | Select-Object -Property Name, Path
$uniqueProcesses = $processes | Group-Object -Property Name | Select-Object -Property Name, @{Name='Path';Expression={$_.Group[0].Path}}
$processList = @()
foreach ($process in $uniqueProcesses) {
    $processNameUpper = $process.Name.ToUpper()
    $processList += @{
        "{#PROCESS.NAME}" = $processNameUpper
        "{#PROCESS.PATH}" = $process.Path
    }
}
$output = @{
    data = $processList
}
$output | ConvertTo-Json -Compress