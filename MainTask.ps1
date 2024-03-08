
# Requires that Lenovo's "System Update" application is installed.
function lenovo () {
    & "C:\Program Files (x86)\Lenovo\System Update\tvsu.exe" /CM -search A -action INSTALL -includerebootpackages 1,2,3,4 -nolicense -noicon -exporttowmi
}

function manufacturer () {
    $manufacturer = (Get-WmiObject Win32_ComputerSystem).Manufacturer
    if($manufacturer -eq "LENOVO") {
        lenovo
    }
    elseif($manufacturer -eq "HP") {

    }
}

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

# manufacturer

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