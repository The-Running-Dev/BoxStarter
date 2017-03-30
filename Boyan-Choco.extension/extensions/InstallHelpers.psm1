$global:mustDismountIso = $false

function CleanUp([string] $isoPath) {
    if ($global:mustDismountIso) {
		Write-Verbose "CleanUp: Dismoutning $($global:isoPath)"
        Dismount-DiskImage -ImagePath $global:isoPath
    }
}

function Get-BaseDirectory([string] $baseDir) {
    $originalBase = $baseDir

    # Overwrite the base directory with ChocolateyPackageFolder,
    # if ChocolateyPackageFolder exists
    if (Test-Path $env:ChocolateyPackageFolder) {
		Write-Verbose 'Get-BaseDirectory: $env:ChocolateyPackageFolder exists'
        $baseDir = $env:ChocolateyPackageFolder
    }

    # Overwrite the base directory with packagesInstallers,
    # if packagesInstallers exists
    if (Test-Path $env:packagesInstallers) {
		Write-Verbose 'Get-BaseDirectory: $env:packagesInstallers exists'
        $baseDir = $env:packagesInstallers
    }
	
	Write-Verbose "Get-BaseDirectory: Returning base dir at $baseDir"
    return $baseDir
}

function Get-Executable([string] $baseDir, [string] $fileName, [string] $regEx) {
    if (!$fileName -and !$regEx) {
        Write-Verbose 'Get-Executable: No file name or regular expression provided. Aborting...'
        return
    }

    $baseDir = Get-BaseDirectory $baseDir

    # Set the regular expression, or use the file name as the default
    $regEx = @{ $true = (Split-Path -Leaf $fileName); $false = $regEx }['' -ne $fileName]
	Write-Verbose "Get-Executable: RegEx is $regEx"
	
    $files = Get-ChildItem -Path $baseDir -Recurse | Where-Object { $_.Name -match $regEx }
	Write-Verbose "Get-Executable: Found $($files.Count) files matching ""$regEx"" in $baseDir"
	
    # Always use the first file found
    if ($files.Count -gt 0) {
		Write-Verbose "Get-Executable: Returning file $($files[0].FullName)"

        return $files[0].FullName
    }
    elseif (!$files) {
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
            Throw "Package parameters were found but were invalid."
        }
    }

    return $arguments
}

function Get-FileExtension([string] $file) {
    return [System.IO.Path]::GetExtension($file).ToLower()
}

function Get-Argument([Hashtable] $arguments, [string] $key, [string] $defaultValue = $null) {
	Write-Verbose "Get-Argument: Looking for Key $key"
	Write-Verbose "Get-Argument: Default value for key is $defaultValue"

	if ($arguments.ContainsKey($key)) {
		$value = @{$true = $arguments[$key]; $false = $defaultValue}[$arguments[$key] -ne '']
		Write-Verbose "Get-Argument: Returning $value"
		return $value
	}

	Write-Verbose "Get-Argument: Returning default value for $key of $defaultValue"
	return $defaultValue
}

function Get-Installer {
    param(
        [Hashtable] $arguments
    )

    $url = Get-Argument $arguments 'url'
	Write-Verbose "Get-Installer: Url is $url"

	$arguments['unzipLocation'] = Get-Argument $arguments 'unzipLocation' $env:ChocolateyPackageFolder
	Write-Verbose "Get-Installer: Unzip Location is $($arguments['unzipLocation'])"

    $arguments['file'] = Get-Argument $arguments 'file' (Join-Path $arguments['unzipLocation'] ([System.IO.Path]::GetFileName($url)))
	Write-Verbose "Get-Installer: File is $($arguments['file'])"
	
    $arguments['executable'] = Get-Argument $arguments 'executable' ([System.IO.Path]::GetFileName($arguments['file']))
	Write-Verbose "Get-Installer: Executable is $($arguments['executable'])"

    $arguments['executableRegEx'] = Get-Argument $arguments 'executableRegEx'
	Write-Verbose "Get-Installer: Executable Reg Ex is $($arguments['executableRegEx'])"

    $extension = Get-FileExtension $arguments['file']
	Write-Verbose "Get-Installer: Extension is $extension"

    if ($extension -eq '.zip') {
        return Get-InstallerFromZip $arguments
    }
    elseif ($extension -eq '.iso') {
        return Get-InstallerFromIso $arguments
    }

    $installer = Get-Executable $arguments['unzipLocation'] $arguments['executable'] $arguments['executableRegEx']

    if (Test-FileExists $installer) {
		Write-Verbose "Get-Installer: Found installer at $installer"
        return $foundInstaller
    }

    return Get-InstallerFromWeb $arguments
}

function Get-InstallerFromIso([Hashtable] $arguments) {
    $file = $arguments['file']
    $baseDir = $arguments['unzipLocation']
    $executable = $arguments['executable']
    $executableRegEx = $arguments['executableRegEx']
    $isoPath = $file

    if (![System.IO.Path]::IsPathRooted($file)) {
        $isoPath = Join-Path (Get-BaseDirectory) $file

        # No ISO found in the package
        if (!(Test-Path $isoPath)) {
            # Reset the base directory
            $isoPath = Join-Path (Get-BaseDirectory '') $file

            if (!(Test-Path $isoPath)) {
                return
            }
        }
    }

    $global:mustDismountIso = $true
    $global:isoPath = $isoPath

    $iso = Mount-DiskImage $isoPath -PassThru
    $driveLetter = ($iso | Get-Volume).DriveLetter
    Get-PSDrive | Out-Null

    return Get-Executable "$driveLetter`:\" $executable $exeRegEx
}

function Get-InstallerFromWeb([Hashtable] $arguments) {
    if ($arguments['url']) {
		Write-Verbose "Get-InstallerFromWeb: Getting installer from url $($arguments['url'])"

        return Get-ChocolateyWebFile `
            -PackageName $arguments['packageName'] `
            -Url $arguments['url'] `
            -FileFullPath $arguments['file']
    }
}

function Get-InstallerFromZip([Hashtable] $arguments) {
    $file = $arguments['file']
    $executable = $arguments['executable']
    $executableRegEx = $arguments['executableRegEx']
    $unzipLocation = $arguments['unzipLocation']
 
    if (Test-FileExists $file) {
        # We don't care abuot the return of the unzip
        Get-ChocolateyUnzip -FileFullPath $file -Destination $unzipLocation -Force
    }
    elseif ($arguments['url']) {
		Write-Verbose 'Get-InstallerFromZip: Calling Install-ChocolateyZipPackage'
        Install-ChocolateyZipPackage @arguments
    }

	$installer = Get-Executable $extractLocation $executable $executableRegEx
	Write-Verbose "Get-InstallerFromZip: Found installer at $installer"
    
	return $installer
}

function Install-CustomPackage() {
    param(
        [Hashtable] $arguments
    )

    try {
        $arguments['file'] = Get-Installer $arguments
    }
    catch {
		Write-Host $_.Exception.ToString()
	}

    if (Test-FileExists $arguments['file']) {
        Install-ChocolateyInstallPackage @arguments

        CleanUp
    }
    else {
        CleanUp
		
		Write-Verbose 'Install-CustomPackage: No installer or url provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}

function Install-WithProcess() {
    param(
        [Hashtable] $arguments
    )

	$url = Get-Argument $arguments 'url'
	if ($url -eq $null) {
		#throw 'No Installer or url provided. Aborting...'
	}
	
    $arguments['file'] = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
        Write-Verbose "Install-WithProcess: Installing from $($arguments['file'])"

        Start-Process $arguments['file'] $arguments['silentArgs'] -Wait -NoNewWindow

        CleanUp
    }
    else {
		Write-Verbose 'Install-WithProcess: No installer or url provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}

function Install-WithScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $arguments['file'] = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
		Write-Verbose "Install-WithScheduledTask: Installing from $($arguments['file'])"

        Invoke-ScheduledTask $arguments['packageName'] $arguments['file'] $arguments['silentArgs']

        CleanUp
    }
    else {
		Write-Verbose 'Install-WithProcess: No Installer or Url Provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}

function Test-DirectoryExists([string] $path) {
    return [System.IO.Directory]::Exists($path)
}

function Test-FileExists([string] $file) {
    return [System.IO.File]::Exists($file)
}

Export-ModuleMember *