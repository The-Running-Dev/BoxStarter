function Install()
{
    param(
        [Hashtable] $packageArgs
    )
    
    $packageArgs['file'] = PrepareInstaller $packageArgs

    if ([System.IO.File]::Exists($packageArgs['file']))
    {
        Write-Host "Installing from: $($packageArgs['file'])"
        
        Install-ChocolateyInstallPackage @packageArgs
        
        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function InstallWithScheduledTaks()
{
    param(
        [Hashtable] $packageArgs
    )
    
    $packageArgs['file'] = PrepareInstaller $packageArgs
    
    if ([System.IO.File]::Exists($packageArgs['file']))
    {
        Write-Host "Installing from: $($packageArgs['file'])"

        StartAsScheduledTask $packageArgs['packageName'] $packageArgs['file'] $packageArgs['silentArgs']

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function PrepareInstaller()
{
     param(
        [Hashtable] $packageArgs
    )

    $packageParameters = ParseParameters $env:chocolateyPackageParameters
    $isoPath = $packageParameters["iso"]
    $setupPath = $packageParameters["setup"]
    $installerPath = $packageParameters['installer']
    $installerExe = $packageParameters["exe"]
    $packageInstaller = [System.IO.Path]::Combine($env:packagesInstallers, [System.IO.Path]::GetFileName($packageArgs['file']))

    if ([System.IO.File]::Exists($setupPath)) {
        # If the provided setup executable or ISO exist
        return $setupPath
    }
    elseif ([System.IO.File]::Exists($installerPath)) {
        return $installerPath
    }
    elseif ([System.IO.File]::Exists($packageInstaller)) {
        # If the installer exists the env:pacakgeInstallers
        return $packageInstaller
    }
    elseif ([System.IO.File]::Exists($isoPath)) {
        $global:mustDismountIso = $true
        $global:isoPath = $isoPath

        $mountedIso = Mount-DiskImage -PassThru $isoPath
        $isoDrive = Get-Volume -DiskImage $mountedIso | Select -expand DriveLetter

        $setupPath = "$isoDrive`:\$installerExe"

        if (![System.IO.File]::Exists($setupPath)) {
            return ''
        }

        return $setupPath
    }
    elseif ($packageArgs.ContainsKey('url')) {
        # Use The provided URL to get the installer
        Write-Host "Downloading Installer: $($packageArgs['url'])"

        $packageArgs['file'] = Get-ChocolateyWebFile @packageArgs
    }

    return $packageArgs['file']
}

function ParseParameters([string] $packageParameters)
{
    $arguments = @{}

    if ($packageParameters)
    {
        $match_pattern = "\/(?<option>([a-zA-Z0-9]+))(:|=|-)([`"'])?(?<value>([a-zA-Z0-9- _\\:\.\!\@\#\$\%\^\&\*\(\)+]+))([`"'])?|\/(?<option>([a-zA-Z0-9]+))"
        $option_name = 'option'
        $value_name = 'value'

        if ($packageParameters -match $match_pattern )
        {
            $results = $packageParameters | Select-String $match_pattern -AllMatches

            $results.matches | % {
                $arguments.Add(
                    $_.Groups[$option_name].Value.Trim(),
                    $_.Groups[$value_name].Value.Trim())
            }
        }
        else
        {
          Throw "Package Parameters Were Found but Were Invalid."
        }
    }

    return $arguments
}

function CleanUp([string] $isoPath)
{
    if ($global:mustDismountIso) {
        Dismount-DiskImage -ImagePath $global:isoPath
    }
}

Export-ModuleMember *