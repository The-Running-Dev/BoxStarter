function Backup-IISBindings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $backupDir
    )

    Write-Host "Backing up bindings for '$name'..."

    try {
         $currentBindings = Get-WebBinding -Name $name
         $bindingsBackupFile = Get-BackupFileName $backupDir $name
         $currentBindings | Export-CliXML $bindingsBackupFile | Out-Null
    } catch {
        Write-Host "There was a problem backing up the bindings..."
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
            $result = $default
        }
    }

    return $result
}

function Get-BackupFileName($backupDir, $webSiteName) {
    $folder = Join-Path -Path $backupDir -ChildPath $webSiteName

    if((Test-Path $folder) -eq $false) {
        New-Item -ItemType Directory -Force $folder | Out-Null
    }

    $fullPath = $null;

    if($OctopusParameters -eq $null) {
        $fullPath = Join-Path -Path $folder -ChildPath "site_backup.xml"
    } else {
        $fileName = $OctopusParameters["Octopus.Release.Number"] + "_" + $OctopusParameters["Octopus.Environment.Name"] + ".xml"
        $fullPath = Join-Path -Path $folder -ChildPath $fileName
    }

    return $fullPath
}