Write-BoxstarterMessage "Creating Pinned Taskbar Items"

#Install-ChocolateyPinnedTaskBarItem "$env:programfiles\console\console.exe"
#copy-item (Join-Path (Get-PackageRoot($MyInvocation)) 'console.xml') -Force $env:appdata\console\console.xml

Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Microsoft VS Code\Code.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\GitExtensions\GitExtensions.exe"
Install-ChocolateyPinnedTaskBarItem "$env:APPDATA\Spotify\Spotify.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\ConEmu\ConEmu64.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com"