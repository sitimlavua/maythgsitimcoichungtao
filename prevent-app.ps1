# prevent-app.ps1
# Safe review helper: reports common startup entries; makes NO system changes.
# Use Windows Settings/Task Manager to disable only entries you recognize.
# This is not a cheat detector and does not block applications from launching.

Write-Host "Startup entries for review:" -ForegroundColor Cyan
try {
    Get-CimInstance Win32_StartupCommand |
        Select-Object Name, Command, Location, User |
        Format-Table -AutoSize -Wrap
} catch {
    Write-Host "Could not read startup entries." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "To manage startup apps:" -ForegroundColor Yellow
Write-Host "1. Press Ctrl+Shift+Esc."
Write-Host "2. Open the Startup tab."
Write-Host "3. Disable only apps you recognize and do not need."
Write-Host "Do not disable Windows security, LAN/Wi-Fi, audio, Steam, or NVIDIA components blindly."
Write-Host ""
Write-Host "This script does not lock the PC to Play Together and does not block apps from launching." -ForegroundColor Cyan
Read-Host "Press Enter to exit"
