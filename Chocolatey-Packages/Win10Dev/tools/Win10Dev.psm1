$applicationsFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Config\Applications.txt')
$enableWindowsFeaturesFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Config\WindowsFeatures-Enable.txt')
$disableWindowsFeaturesFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Config\WindowsFeatures-Disable.txt')

function Install-Applications {
    Write-Debug "Installing Applications"

    RunChocoCommands $applicationsFile "cinst ##application## -y"
}

function Uninstall-Applications {
    Write-Debug "Uninstalling Applications"

    RunChocoCommands $applicationsFile "cuninst ##application## -y"
}

function Enable-WindowsFeatures {
    Write-Debug "Enabling Windows Features"

    RunChocoCommands $enableWindowsFeaturesFile "cinst ##application## -source WindowsFeatures -y"
}

function Disable-WindowsFeatures {
    Write-Debug "Disabling Windows Features"

    RunChocoCommands $disableWindowsFeaturesFile "cuninst ##application## -source WindowsFeatures -y"
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

Export-ModuleMember Install-Applications, Uninstall-Applications, Enable-WindowsFeatures, Disable-WindowsFeatures