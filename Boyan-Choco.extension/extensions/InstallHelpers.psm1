function Install-LocalOrRemote()
{
    param(
        [Hashtable] $arguments
    )
    
    $arguments['file'] = Get-InstallerPath $arguments

    if ([System.IO.File]::Exists($arguments['file']))
    {
        Write-Debug "Installing from: $($arguments['file'])"
        
        Install-ChocolateyInstallPackage @arguments

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function Install-WithScheduledTask()
{
    param(
        [Hashtable] $arguments
    )

    $arguments['file'] = Get-InstallerPath $arguments

    if ([System.IO.File]::Exists($arguments['file']))
    {
        Write-Debug "Installing from: $($arguments['file'])"

        Invoke-ScheduledTask $arguments['packageName'] $arguments['file'] $arguments['silentArgs']

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

    $arguments['file'] = Get-InstallerPath $arguments
    
    if ([System.IO.File]::Exists($arguments['file']))
    {
        Write-Debug "Installing from: $($arguments['file'])"
 
        Start-Process $arguments['file'] $arguments['silentArgs'] -Wait -NoNewWindow

        CleanUp
    }
    else {
        throw 'No Installer or Url Provided. Aborting...'
    }
}

function Get-InstallerPath()
{
     param(
        [Hashtable] $arguments
    )

    $parameters = Get-Parameters $env:chocolateyPackageParameters
    $isoPath = $parameters['iso']
    $setupPath = $parameters['setup']
    $installerPath = $parameters['installer']
    $installerExe = $parameters['exe']
    $packageInstaller = [System.IO.Path]::Combine($env:packagesInstallers, [System.IO.Path]::GetFileName($arguments['file']))

    if ([System.IO.File]::Exists($setupPath)) {
        # If the provided setup executable exists
        return $setupPath
    }
    elseif ([System.IO.File]::Exists($installerPath)) {
        # If the provided installer exists
        return $installerPath
    }
    elseif ([System.IO.File]::Exists($packageInstaller)) {
        # If the installer exists under env:pacakgeInstallers
        return $packageInstaller
    }
    elseif ([System.IO.File]::Exists($isoPath)) {
        # If the ISO exists
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
    elseif ($arguments.ContainsKey('url')) {
        # Use The provided URL to get the installer
        Write-Debug "Downloading Installer: $($arguments['url'])"

        $arguments['file'] = Get-ChocolateyWebFile @arguments
    }

    return $arguments['file']
}

function Get-Parameters([string] $parameters)
{
    $arguments = @{}

    if ($parameters)
    {
        $match_pattern = "\/(?<option>([a-zA-Z0-9]+))(:|=|-)([`"'])?(?<value>([a-zA-Z0-9- _\\:\.\!\@\#\$\%\^\&\*\(\)\+\,]+))([`"'])?|\/(?<option>([a-zA-Z0-9]+))"
        $option_name = 'option'
        $value_name = 'value'

        if ($parameters -match $match_pattern)
        {
            $results = $parameters | Select-String $match_pattern -AllMatches

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