function Install-Applications([string] $file)
{
    Write-Host "Installing Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    } 

    Invoke-Commands $file "choco install ##token## -r --execution-timeout 14400 -y $packagesSource"
}

function UnInstall-Applications([string] $file)
{
    Write-Host "Uninstalling Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    } 

    Invoke-Commands $file "choco uninstall ##token## -r --execution-timeout 14400 -y $packagesSource"
}

function Invoke-Commands([string] $file, [string] $commandTemplate) {
    try {
        foreach ($line in Get-Content -Path $file | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $commmand = $commandTemplate.replace("##token##", $line)

            Write-Host "Running: $commmand"

            Invoke-Expression $commmand
        }
    }
    catch {
         Write-Host "Invoke-Commands Failed: $($_.Exception.Message)"
    }
}

function Invoke-Executables([string] $path) {
    $exes = Get-ChildItem -Path $path -Filter *.exe -Recurse

    foreach ($e in $exes) {
        try {
            Write-Host "Running $e"

            & $e
        }
        catch {
            Write-Host "Invoke-Executables Failed: $e, Message: $($_.Exception.Message)"
        }
    }
}

function Invoke-PinApplications([string] $pinTool, [string] $configFile) {
    try {
        foreach ($line in Get-Content -Path $file | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $applicationPath = Invoke-Expression $line

            if ([System.IO.File]::Exists($applicationPath)) {
                & $pinTool $applicationPath c:"Pin to taskbar"
            }
        }
    }
    catch {
         Write-Host "Invoke-PinApplications Failed: $($_.Exception.Message)"
    }
}

Export-ModuleMember *