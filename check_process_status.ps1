param (
    [string]$processName
)

$process = Get-Process -Name $processName -ErrorAction SilentlyContinue
if ($process) {
    Write-Output 1
} else {
    Write-Output 0
}