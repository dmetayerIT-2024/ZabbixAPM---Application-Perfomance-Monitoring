$directory = ""

# Get processes running from the specified directory
$processes = Get-Process | Where-Object { $_.Path -like "$directory\*" } | Select-Object -Property Name, Path, CPU, WorkingSet

# Group by unique process names
$uniqueProcesses = $processes | Group-Object -Property Name | Select-Object -Property Name, @{Name='Path';Expression={$_.Group[0].Path}}

# Get the CPU frequency in GHz (assuming the first processor)
$cpuFrequencyGHz = (Get-WmiObject -Class Win32_Processor | Select-Object -First 1).MaxClockSpeed / 1000

$processCount = $processes.Count
$processList = @()

foreach ($process in $uniqueProcesses) {
    # Ensure the Group is not null or empty
    if ($process.Group -and $process.Group.Count -gt 0) {
        # Calculate CPU usage in GHz
        $cpuGHz = ($process.Group[0].CPU / 100) * $cpuFrequencyGHz
        $processNameUpper = $process.Name.ToUpper()

        # Add process details to the list
        $processList += @{
            "{#PROCESS.NAME}" = $processNameUpper
            "{#PROCESS.PATH}" = $process.Path
            "{#PROCESS.CPU_PERCENT}" = $process.Group[0].CPU
            "{#PROCESS.CPU_GHZ}" = [math]::Round($cpuGHz, 2)
            "{#PROCESS.MEMORY}" = $process.Group[0].WorkingSet
        }
    }
}

$output = @{
    data = $processList
    processCount = $processCount
}

# Output the JSON data
$output | ConvertTo-Json -Compress