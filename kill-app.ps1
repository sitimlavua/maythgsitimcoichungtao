# kill-app.ps1
# Tournament helper: close ONLY explicitly listed applications.
# Review and customize $BlockedProcessNames before use.
# Does not disable Windows, networking, audio, or GPU driver services.

$ErrorActionPreference = "SilentlyContinue"

$BlockedProcessNames = @(
    # Add confirmed prohibited app process names here, without ".exe".
    # Example: "examplecheat"
)

if ($BlockedProcessNames.Count -eq 0) {
    Write-Host "No blocked process names configured." -ForegroundColor Yellow
    Write-Host "Edit `$BlockedProcessNames in this script and add verified process names."
    Read-Host "Press Enter to exit"
    exit
}

foreach ($name in $BlockedProcessNames) {
    Get-Process -Name $name -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Stop-Process -Id $_.Id -Force -ErrorAction Stop
            Write-Host ("Closed process: " + $_.ProcessName) -ForegroundColor Green
        } catch {
            Write-Host ("Could not close: " + $_.ProcessName) -ForegroundColor Yellow
        }
    }
}
Write-Host "Finished. This only closes listed processes; it does not prevent relaunch or prove cheating." -ForegroundColor Cyan
Read-Host "Press Enter to exit"
