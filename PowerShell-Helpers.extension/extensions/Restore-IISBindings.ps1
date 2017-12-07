function Restore-IISBindings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $backupDir
    )

    Write-Host "Restoring bindings for $name..."

    try {
        $bindingsBackupFile = Get-BackupFileName $backupDir $name
        $currentBindings = Import-CliXML $bindingsBackupFile

        if ($currentBindings -ne $null) {
            foreach($binding in $currentBindings) {
                $bindingArray = $binding.bindingInformation.Split(":")
                $existing = Get-WebBinding -Name $name -Protocol $binding.protocol -IPAddress $bindingArray[0] -Port $bindingArray[1] -HostHeader $bindingArray[2]

                if($existing -eq $null) {
                    Write-Host "Adding binding '$($binding.protocol)' '$($binding.bindingInformation)'"
                    New-WebBinding -Name $name -Protocol $binding.protocol -IPAddress $bindingArray[0] -Port $bindingArray[1] -HostHeader $bindingArray[2]
                }
            }
        }
    } catch {
        Write-Host "There was a problem restoring the bindings..."
        Write-Host $_.Exception|format-list -force
    }
}

function Get-Param($name, [switch] $required, $default) {
    $result = $null

    if ($OctopusParameters -ne $null) {
        $result = $OctopusParameters[$name]
    }

    if ($result -eq $null) {
        $variable = Get-Variable $name -EA SilentlyContinue

        if ($variable -ne $null) {
            $result = $variable.Value
        }
    }

    if ($result -eq $null -or $result -eq '') {
        if ($required) {
            throw "Missing parameter value $name"
        } else {
            $result = $Default
        }
    }

    return $result
}

function Get-BackupFileName($backupDir, $name) {
    $folder = Join-Path -Path $backupDir -ChildPath $name

    if((Test-Path $folder) -eq $false) {
        New-Item -ItemType Directory -Force $folder | Out-Null
    }

    $fullPath = $null;

    if($OctopusParameters -eq $null) {
         $fullPath = Join-Path -Path $folder -ChildPath 'site_backup.xml'
    } else {
         $fileName = $OctopusParameters["Octopus.Release.Number"] + "_" + $OctopusParameters["Octopus.Environment.Name"] + ".xml"
         $fullPath = Join-Path -Path $folder -ChildPath $fileName
    }

    return $fullPath
}