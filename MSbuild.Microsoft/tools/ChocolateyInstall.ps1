$MSBuildTargets = 'MSBuild.Microsoft.zip'

$script:MSBuildTargets = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) $MSBuildTargets)
$script:MSBuildTargetsDestination = 'C:\Program Files (x86)\MSBuild'

function Unzip()
{
    param([string]$file, [string]$destination)

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [System.IO.Compression.ZipFile]::OpenRead($file)
    foreach ($entry in $archive.Entries)
    {
        $entryTargetFilePath = [System.IO.Path]::Combine($destination, $entry.FullName)
        $entryDir = [System.IO.Path]::GetDirectoryName($entryTargetFilePath)

        #Ensure the directory of the archive entry exists
        if(!(Test-Path $entryDir)){
            New-Item -ItemType Directory -Path $entryDir | Out-Null
        }

        # If the entry is not a directory entry, then extract entry
        if(!$entryTargetFilePath.EndsWith("/")){
            try {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entryTargetFilePath, $true);
            }
            catch {
                echo $_.Exception.Message
            }
        }
    }
}

# Copy the MSBuild targets to the right place
Unzip $script:MSBuildTargets $script:MSBuildTargetsDestination