$arguments          = @{
    url             = 'https://github.com/git-for-windows/git/releases/download/v2.13.3.windows.1/Git-2.13.3-64-bit.exe'
    checksum        = '015403BD098AB2876EC5F6392ED7A64C8D18D2DBBE23AFAE095424655653026A'
    silentArgs      = '/VERYSILENT /NORESTART /NOCANCEL /SP- /COMPONENTS="icons,icons\quicklaunch,ext,ext\shellhere,ext\guihere,assoc,assoc_sh" /LOG'
}

$parameters = Get-Parameters
$registryKeyName = 'Git_is1'
$useWindowsTerminal = $false
$gitCmdOnly = $false
$unixTools = $false
$noAutoCrlf = $false

if ($parameters.ContainsKey("gitonlyonpath")) {
    Write-Host "You want Git on the command line"
    $gitCmdOnly = $true
}

if ($parameters.ContainsKey("windowsterminal")) {
    Write-Host "You do not want to use MinTTY terminal"
    $useWindowsTerminal = $true
}

if ($parameters.ContainsKey("gitandunixtoolsonpath")) {
    Write-Host "You want Git and Unix Tools on the command line"
    $unixTools = $true
}

if ($parameters.ContainsKey("noautocrlf")) {
    Write-Host "Ensuring core.autocrlf is false on first time install only"
    Write-Host " This setting will not adjust an already existing .gitconfig setting."
    $noAutoCrlf = $true
}

$is64bit = (Get-ProcessorBits) -eq 64
$installKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
if ($is64bit -eq $true -and $env:chocolateyForceX86 -eq $true) {
    $installKey = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
}

$userInstallKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
if (Test-Path $userInstallKey) {
    $installKey = $userInstallKey
}

if (-not (Test-Path $installKey)) {
    New-Item -Path $installKey | Out-Null
}

if ($gitCmdOnly) {
    # update registry so installer picks it up automatically
    New-ItemProperty $installKey -Name "Inno Setup CodeFile: Path Option" -Value "Cmd" -PropertyType "String" -Force | Out-Null
}

if ($useWindowsTerminal) {
    # update registry so installer picks it up automatically
    New-ItemProperty $installKey -Name "Inno Setup CodeFile: Bash Terminal Option" -Value "ConHost" -PropertyType "String" -Force | Out-Null
}

if ($unixTools) {
    # update registry so installer picks it up automatically
    New-ItemProperty $installKey -Name "Inno Setup CodeFile: Path Option" -Value "CmdTools" -PropertyType "String" -Force | Out-Null
}

if ($noAutoCrlf) {
    # update registry so installer picks it up automatically
    New-ItemProperty $installKey -Name "Inno Setup CodeFile: CRLF Option" -Value "CRLFCommitAsIs" -PropertyType "String" -Force | Out-Null
}

# Make our install work properly when running under SYSTEM account (Chef Cliet Service, Puppet Service, etc)
# Add other items to this if block or use $IsRunningUnderSystemAccount to adjust existing logic that needs changing
$IsRunningUnderSystemAccount = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem
If ($IsRunningUnderSystemAccount) {
    #strip out quicklaunch parameter as it causes a hang under SYSTEM account
    $fileArgs = $fileArgs.replace('icons\quicklaunch,', '')

    If ($fileArgs -inotlike "*/SUPPRESSMSGBOXES*") {
        $fileArgs = $fileArgs + ' /SUPPRESSMSGBOXES'
    }
}

If ([bool](Get-Process ssh-agent -ErrorAction SilentlyContinue)) {
    Write-Output "Killing any git ssh-agent instances for install."

    (Get-Process ssh-agent | Where-Object {$_.Path -ilike "*\git\usr\bin\*"}) | Stop-Process
}

Install-Package $arguments

if (Test-Path $installKey) {
    $keyNames = Get-ItemProperty -Path $installKey

    if ($gitCmdOnly -eq $false -and $unixTools -eq $false) {
        $installLocation = $keyNames.InstallLocation

        if ($installLocation -ne '') {
            $gitPath = Join-Path $installLocation 'cmd'

            Install-ChocolateyPath $gitPath 'Machine'
        }
    }
}
