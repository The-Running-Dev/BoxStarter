$global:mustDismountIso = $false
$global:supportedFileTypes = '.exe, .zip, .msi'

function CleanUp([string] $isoPath) {
    if ($global:mustDismountIso) {
        Dismount-DiskImage -ImagePath $global:isoPath
    }
}

function Get-Executable([string] $baseDir, [string] $fileName, [string] $regEx) {
    if (!$fileName -and !$regEx) {
        Write-Debug 'No filename or regular expression provided...aborting'
        return
    }

    # If the base directory does not exist, try to find it
    if (!(Test-DirectoryExists $baseDir)) {
        # Set the base directory to the script grand parent
        $baseDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.PSCommandPath)

        # Overwrite the base directory with ChocolateyPackageFolder, if ChocolateyPackageFolder exists
        if ($env:ChocolateyPackageFolder) {
            $baseDir = $env:ChocolateyPackageFolder
        }

        # Overwrite the base directory with packagesInstallers, if packagesInstallers exists
        if ($env:packagesInstallers) {
            $baseDir = $env:packagesInstallers
        }
    }

    # Set the regular expression, or use the file name as the default
    $regEx = @{ $true = $fileName; $false = $regEx }['' -ne $fileName]

    $files = Get-ChildItem -Path $baseDir -Recurse | Where-Object { $_.Name -match $regEx }

    if ($files.Count -eq 1) {
        return $files[0].FullName
    }
    elseif (!$files -or $files.Count -gt 1) {
        Write-Debug "No files matching ""$regEx"" found under ""$baseDir"""
        return
    }
}

function Get-FileName([string] $file) {
    return [System.IO.Path]::GetFileName($file)
}

function Get-Parameters([string] $parameters) {
    $arguments = @{}

    if ($parameters) {
        $match_pattern = "\/(?<option>([a-zA-Z0-9]+))(:|=|-)([`"'])?(?<value>([a-zA-Z0-9- _\\:\.\!\@\#\$\%\^\&\*\(\)\+\,]+))([`"'])?|\/(?<option>([a-zA-Z0-9]+))"
        $option_name = 'option'
        $value_name = 'value'

        if ($parameters -match $match_pattern) {
            $results = $parameters | Select-String $match_pattern -AllMatches

            $results.matches | % {
                $arguments.Add(
                    $_.Groups[$option_name].Value.Trim(),
                    $_.Groups[$value_name].Value.Trim())
            }
        }
        else {
            Throw "Package Parameters Were Found but Were Invalid."
        }
    }

    return $arguments
}

function Get-FileExtension([string] $file) {
    return [System.IO.Path]::GetExtension($file).ToLower()
}

function Get-Installer {
    param(
        [Hashtable] $arguments
    )

    $url = @{$true = $arguments['url']; $false = ''}[$null -ne $arguments['url']]
    $file = @{$true = $arguments['file']; $false = (Get-FileName $url)}[(Test-FileExists $arguments['file'])]
    $executable = @{$true = $arguments['executable']; $false = $file}[$null -ne $arguments['executable']]
    $executableRegEx = @{$true = $arguments['executableRegEx']; $false = ''}[$null -ne $arguments['executableRegEx']]
    $unzipLocation = @{$true = $arguments['unzipLocation']; $false = ''}[$null -ne $arguments['unzipLocation']]

    $fileExtension = Get-FileExtension $file

    if ($fileExtension -eq '.zip') {
        return Get-InstallerFromZip $arguments
    }
    elseif ($fileExtension -eq '.iso') {
        return Get-InstallerFromIso $arguments
    }

    $foundInstaller = Get-Executable $unzipLocation $executable $executableRegEx

    if (Test-FileExists $foundInstaller) {
        return $foundInstaller
    }

    return Get-InstallerFromWeb $arguments
}

function Get-InstallerFromIso([Hashtable] $arguments) {
    $file = @{$true = $arguments['file']; $false = ''}[$null -ne $arguments['file']]
    $executable = @{$true = $arguments['executable']; $false = ''}[$null -ne $arguments['executable']]
    $executableRegEx = @{$true = $arguments['executableRegEx']; $false = ''}[$null -ne $arguments['executableRegEx']]

    $global:mustDismountIso = $true
    $global:isoPath = $path

    #$mountedIso = Mount-DiskImage -PassThru $path
    $diskImage = Get-DiskImage -ImagePath $file
    $driveLetter = $diskImage | Get-Volume | Select-Object -expand DriveLetter

    return Get-Executable "^$driveLetter`:\" $executable $exeRegEx
}

function Get-InstallerFromWeb([Hashtable] $arguments) {
    if ($arguments['url']) {
        return Get-ChocolateyWebFile `
            -PackageName $arguments['packageName'] `
            -Url $arguments['url'] `
            -FileFullPath $arguments['file']
    }
}

function Get-InstallerFromZip([Hashtable] $arguments) {
    $file = @{$true = $arguments['file']; $false = ''}['' -ne $arguments['file']]
    $executable = @{$true = $arguments['executable']; $false = ''}['' -ne $arguments['executable']]
    $executableRegEx = @{$true = $arguments['executableRegEx']; $false = ''}['' -ne $arguments['executableRegEx']]
    $unzipLocation = @{$true = $arguments['unzipLocation']; $false = ''}['' -ne $arguments['unzipLocation']]
    $extractLocation = @{$true = $unzipLocation; $false = Join-Path $env:Temp $(new-guid)}[(Test-DirectoryExists $extractLocation)]

    if (Test-FileExists $file) {
        # We don't care abuot the return of the unzip
        $t = Get-ChocolateyUnzip -FileFullPath $file -Destination $extractLocation -Force
    }
    elseif ($arguments['url']) {
        Write-Debug "Downloading Installer From: $($arguments['url'])"

        # Update the extract locat]ion in case it's the temporary directory
        $arguments['unzipLocation'] = $extractLocation

        Install-ChocolateyZipPackage @arguments
    }

    return Get-Executable $extractLocation $executable $executableRegEx
}

function Install-CustomPackage() {
    param(
        [Hashtable] $arguments
    )

    $arguments['file'] = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
        Install-ChocolateyInstallPackage @arguments

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function Install-WithProcess() {
    param(
        [Hashtable] $arguments
    )

    $arguments['file'] = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
        Write-Debug "Installing from: $($arguments['file'])"

        Start-Process $arguments['file'] $arguments['silentArgs'] -Wait -NoNewWindow

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function Install-WithScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $arguments['file'] = Get-Installer $arguments
    Write-Host "FROM: $($arguments['file'])"

    if (Test-FileExists $arguments['file']) {
        Write-Debug "Installing from: $($arguments['file'])"

        Invoke-ScheduledTask $arguments['packageName'] $arguments['file'] $arguments['silentArgs']

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function Test-DirectoryExists([string] $path) {
    return [System.IO.Directory]::Exists($path)
}

function Test-FileExists([string] $file) {
    return [System.IO.File]::Exists($file)
}

Export-ModuleMember *