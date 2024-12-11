# Define the path to the file
$filePath = ""

# Check if the file exists
if (Test-Path $filePath) {
    # Get the file size in bytes
    $fileSize = (Get-Item $filePath).Length
    # Output the file size
    Write-Output $fileSize
} else {
    Write-Output 0
}