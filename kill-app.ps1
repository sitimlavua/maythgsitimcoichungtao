# kill-app.ps1
param([string[]]$BlockedProcessNames = @())

if ($BlockedProcessNames.Count -eq 0) {
    Write-Host "Chua co app nao. Dung: -BlockedProcessNames 'app1','app2'" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    return
}

foreach ($raw in $BlockedProcessNames) {
    $name = $raw -replace '\.exe$', ''
    if ($name -match '[\*\?]') { Write-Host "Bo qua wildcard: $raw" -ForegroundColor Yellow; continue }

    $procs = Get-Process -Name $name -ErrorAction SilentlyContinue
    if (-not $procs) { Write-Host "Khong chay: $name" -ForegroundColor DarkGray; continue }

    foreach ($p in $procs) {
        try {
            Stop-Process -Id $p.Id -Force -ErrorAction Stop
            Write-Host "Da tat: $($p.ProcessName)" -ForegroundColor Green
        } catch {
            Write-Host "Khong tat duoc $($p.ProcessName): $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
}

Write-Host "Xong. Script chi tat app dang chay, khong chan mo lai." -ForegroundColor Cyan
