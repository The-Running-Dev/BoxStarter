$applicationsFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Chocolatey-Applications.txt')

function Install-Applications {
<#
.SYNOPSIS
Installs applications

.DESCRIPTION
Installs all applications

.EXAMPLE
Install-Applications

.OUTPUTS
None
#>
param(
)
    Write-Debug "Installing APplications"

    try {
        foreach ($line in Get-Content -Path $applicationsFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            Write-Debug "Running: choco install $line -y"

            choco install $line -y
        }

        ##if (Test-PendingReboot) { Invoke-Reboot }
    }
    catch {
        Write-ChocolateyFailure 'Installation Failed: ' $($_.Exception.ToString())
        throw
    }
}

function Uninstall-Applications {
<#
.SYNOPSIS
Installs applications

.DESCRIPTION
Installs all applications

.EXAMPLE
Install-Applications

.OUTPUTS
None
#>
param(
)
    Write-Debug "Installing APplications"

    try {
        foreach ($line in Get-Content -Path $applicationsFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            Write-Debug "Running: choco uninstall $line -y"

            choco uninstall $line -y
        }

        ##if (Test-PendingReboot) { Invoke-Reboot }
    }
    catch {
        Write-ChocolateyFailure 'Installation Failed: ' $($_.Exception.ToString())
        throw
    }
}

Export-ModuleMember Install-Applications, Uninstall-Applications