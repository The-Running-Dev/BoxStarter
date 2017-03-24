$global:mustDismountIso = $false
$global:supportedFileTypes = '.exe, .zip, .msi'

function CleanUp([string] $isoPath) {
    if ($global:mustDismountIso) {
        Dismount-DiskImage -ImagePath $global:isoPath
    }
}

function Find-Executable([string] $fileName, [string] $regEx) {
    if (!$fileName -and !$regEx) {
        throw 'No filename or regular expression provided...aborting'
    }

    $baseDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.PSCommandPath)
    $baseDir = @{ $true = $env:ChocolateyPackageFolder; $false = $baseDir }['' -ne $env:ChocolateyPackageFolder]
    $regEx = @{ $true = $fileName; $false = $regEx }['' -ne $fileName]

    write-host $baseDir

    $files = Get-ChildItem -Path $baseDir -Recurse | Where-Object { $_.Name -match $regEx }

    if ($files.Count -eq 1) {
        return $files[0].FullName
    }
    elseif (!$files) {
        throw 'No files found...I am not a mind reader...aborting'
    }
    elseif ($files.Count -gt 1) {
        throw 'Multiple files found...I am not a mind reader...aborting'
    }
    else {
        throw "No files matching ""$fileNameRegEx"" found under ""$baseDir"""
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

    $url = @{$true = $arguments['url']; $false = ''}[$arguments['url'] -ne $null]
    $file = @{$true = $arguments['file']; $false = (Get-FileName $url)}[(Test-FileExists $arguments['file'])]
    $unzipLocation = @{$true = $arguments['unzipLocation']; $false = ''}[$arguments['unzipLocation'] -ne $null]

    $fileExtension = Get-FileExtension $file

    if ($fileExtension -eq '.zip') {
        return Get-InstallerFromZip $arguments
    }
    elseif ($fileExtension -eq '.iso') {
        return Get-InstallerFromIso $arguments
    }

    return $file
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

    $foundInstaller = Find-Executable $executable $executableRegEx
    $installer = "$driveLetter`:\$($foundInstaller.Replace($driveLetter, ''))"

    return $installer
}

function Get-InstallerFromZip([Hashtable] $arguments) {
    $file = @{$true = $arguments['file']; $false = ''}['' -ne $arguments['file']]
    $executable = @{$true = $arguments['executable']; $false = ''}['' -ne $arguments['executable']]
    $executableRegEx = @{$true = $arguments['executableRegEx']; $false = ''}['' -ne $arguments['executableRegEx']]
    $unzipLocation = @{$true = $arguments['unzipLocation']; $false = ''}['' -ne $arguments['unzipLocation']]
    $tempLocation = @{$true = $unzipLocation; $false = Join-Path $env:Temp $(new-guid)}[(Test-DirectoryExists $unzipLocation)]

    if (Test-FileExists $file) {
        # We don't care abuot the return of the unzip
        $t = Get-ChocolateyUnzip -FileFullPath $file -Destination $tempLocation -Force
    }
    elseif ($arguments['url']) {
        Write-Debug "Downloading Installer From: $($arguments['url'])"

        Install-ChocolateyZipPackage @arguments
    }

    $foundInstaller = Find-Executable $executable $executableRegEx
    $installer = Join-Path $tempLocation $foundInstaller.Replace($tempLocation, '')

    return $installer
}

function Install-LocalOrRemote() {
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

    if ([System.IO.File]::Exists($arguments['file'])) {
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

    if ([System.IO.File]::Exists($arguments['file'])) {
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