#!/usr/bin/env -S pwsh -NoProfile

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------ 
# Purposes:
# - sets up the Oh My Posh prompt
# - installs the Az modules
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------ 

# Oh-My-Posh -----
$InitLine = 'oh-my-posh init pwsh --config ~/.jandedobbeleer.omp.json | Invoke-Expression'
# Create profile if it doesn't exist (Force also creates the directory)
if (!(Test-Path $PROFILE)) { 
    New-Item -ItemType File -Path $PROFILE -Force 
}
# Append only if the line isn't present
if (!(Select-String -Pattern "oh-my-posh init pwsh" -Path $PROFILE -Quiet)) {
    Add-Content -Path $PROFILE -Value "`n$InitLine"
    Write-Host "Persisted Oh My Posh init in $PROFILE" -ForegroundColor Green
} else {
    # Write-Host "Oh My Posh is configured in PowerShell" -ForegroundColor Yellow
}

# Az installation -----
if (-not (Get-Module -ListAvailable -Name Az)) {
    Write-Host "Azure module missing. Installing now..." -ForegroundColor Yellow
    Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
}
Write-Host (Get-Module -ListAvailable Az).ModuleBase, "is installed."
