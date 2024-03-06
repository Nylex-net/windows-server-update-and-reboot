# Check for updates
$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$Result = $Searcher.Search("IsInstalled=0")

# Download updates
$Downloader = $Session.CreateUpdateDownloader()
$Downloader.Updates = $Result.Updates
$Downloader.Download()

# Install updates
$Installer = New-Object -ComObject Microsoft.Update.Installer
$Installer.Updates = $Result.Updates
$InstallationResult = $Installer.Install()

# Check installation result
if ($InstallationResult.ResultCode -eq 2) {
    Write-Host "Updates installed successfully. Reboot required."
    Restart-Computer -Force
} elseif ($InstallationResult.ResultCode -eq 3) {
    Write-Host "Some updates were installed, but a reboot is required."
    Restart-Computer -Force
} else {
    Write-Host "Failed to install updates. Error code: $($InstallationResult.ResultCode)"
}