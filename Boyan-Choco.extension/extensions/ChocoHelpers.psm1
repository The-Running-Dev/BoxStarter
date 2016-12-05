function InstallApplications([string] $file)
{
    Write-Host "Installing Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;chocolatey"""
    } 

    RunCommand $file "choco install ##token## --execution-timeout=14400 -y $packagesSource"
}

function UninstallApplications([string] $file)
{
    Write-Host "Uninstalling Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;chocolatey"""
    } 

    RunCommand $file "choco uninstall ##token## --execution-timeout=14400 -y $packagesSource"
}

function RunCommand([string] $file, [string] $commandTemplate) {
    try {
        foreach ($line in Get-Content -Path $file | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $commmand = $commandTemplate.replace("##token##", $line)

            Write-Host "Running: $commmand"

            Invoke-Expression $commmand
        }
    }
    catch {
         Write-Host "Failed: $($_.Exception.ToString())"
    }
}