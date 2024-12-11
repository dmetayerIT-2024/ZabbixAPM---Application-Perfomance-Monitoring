# Predefined directory to monitor
$directory = ""  # Replace with the actual directory path

# Get the most recent file in the directory
$latestFile = Get-ChildItem -Path $directory -File | Sort-Object CreationTime -Descending | Select-Object -First 1

if ($latestFile) {
    # Output file name and creation time
    Write-Output "$($latestFile.Name) $($latestFile.CreationTime)"
} else {
    Write-Output "No files found"
}