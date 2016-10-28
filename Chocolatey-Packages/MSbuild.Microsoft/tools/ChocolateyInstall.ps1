$MSBuildTargets = 'MSBuild.Microsoft.zip'

$script:MSBuildTargets = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) $MSBuildTargets)
$script:MSBuildTargetsDestination = 'C:\Program Files (x86)\MSBuild'

function Unzip()
{
    param([string]$file, [string]$destination)

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}

# Copy the MSBuild targets to the right place
Unzip –File $script:MSBuildTargets –Destination $script:MSBuildTargetsDestination