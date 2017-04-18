function Install-Package {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-Package: Downloading from '$($arguments.url)'"

        $arguments.file = Get-ChocolateyWebFile @packageArgs
    }

    Install-ChocolateyInstallPackage @packageArgs

    if ($packageArgs.executable) {
        $packageArgs.file = Join-Path $packageArgs.destination $packageArgs.executable

        Install-ChocolateyInstallPackage @packageArgs
    }
}