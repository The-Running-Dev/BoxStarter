$packagePath = join-path (Split-Path -parent $MyInvocation.MyCommand.Definition) .. -Resolve

$applicationsFile = join-path $packagePath 'Settings\Applications.txt'
$enableWindowsFeaturesFile = join-path $packagePath 'Settings\WindowsFeatures-Enable.txt'
$disableWindowsFeaturesFile = join-path $packagePath 'Settings\WindowsFeatures-Disable.txt'

function Install-Applications {
    Write-Debug "Installing Applications"

    RunChocoCommands $applicationsFile "choco install ##application## -y"
}

function Uninstall-Applications {
    Write-Debug "Uninstalling Applications"

    RunChocoCommands $applicationsFile "choco uninstall ##application## -y"
}

function Enable-WindowsFeatures {
    Write-Debug "Enabling Windows Features"

    RunChocoCommands $enableWindowsFeaturesFile "choco install ##application## -source WindowsFeatures -y"
}

function Disable-WindowsFeatures {
    Write-Debug "Disabling Windows Features"

    RunChocoCommands $disableWindowsFeaturesFile "choco uninstall ##application## -source WindowsFeatures -y"
}

function CopySettings {
    $env:APPDATA\Code\User
}

function RunChocoCommands([string] $filePath, [string] $commandTemplate) {
    try {
        foreach ($line in Get-Content -Path $filePath | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $commmand = $commandTemplate.replace("##application##", $line)

            Write-Debug "Running: $commmand"

            Invoke-Expression $commmand
        }
    }
    catch {
        Write-Host 'Failed: ' $($_.Exception.ToString())

        throw
    }
}

function InstallWindowsFeatures() {
    echo 'Installing IIS and Windows Features'

    # If chocolatey is not already installed
    if (!(Test-Path 'C:\ProgramData\chocolatey\choco.exe')) {
        # Chocolatey
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        choco feature enable -n allowGlobalConfirmation
        choco feature enable -n allowEmptyChecksums
    }

    # Microsoft Build Tools (Also installs .NET 4.5.2)
    choco install microsoft-build-tools -y

    # MSBuild Microsoft targets from Visual Studio
    $url = "http://bit.ly/2e68t2U"
    $packageName = "MSBuild.Microsoft"
    $version = "1.0.0"
    $tempDir = $(Get-Item $env:TEMP)
    $output = "$tempDir\$packageName.$version.nupkg"
    Invoke-WebRequest -Uri $url -OutFile $output
    choco install $packageName -y -source "'$tempDir;https://chocolatey.org/api/v2/'"

    # .NET
    choco install netfx-4.5.1-devpack -y
    choco install netfx-4.6.1-devpack -y

    # choco install netfx-4.5.2-devpack -y
    # choco install dotnet-4.6.2 -y

    # .NET Core SDK 1.0.1
    $url = "http://bit.ly/2fafz8x"
    $packageName = "DotNETCoreSDK"
    $version = "1.0.1"
    $tempDir = $(Get-Item $env:TEMP)
    $output = "$tempDir\$packageName.$version.nupkg"
    Invoke-WebRequest -Uri $url -OutFile $output
    choco install $packageName -y -source "'$tempDir;https://chocolatey.org/api/v2/'"

    if ([System.Environment]::OSVersion.Version.Major -eq 6){
        InstallWindows7Features
    }
    else {
        # .NET and extensibility
        InstallWindowsFeature NetFx3
        InstallWindowsFeature NetFx4Extended-ASPNET45

        # Web server
        InstallWindowsFeature IIS-WebServer

        # ASP.NET
        InstallWindowsFeature IIS-ASPNET
        InstallWindowsFeature IIS-ASPNET45
    }

    # IIS modules
    choco install UrlRewrite -y
    choco install IIS-ARR -y

    # Carbon module for host file editing
    choco install Carbon -y
}

function AddLocalHostEntry($hostEntry)
{
    Set-HostsEntry -IPAddress 127.0.0.1 -HostName $hostEntry
}

Export-ModuleMember *