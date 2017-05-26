function Install-WithCopy {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments
    $destinationFile = $packageArgs.file

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-WithCopy: Downloading from '$($arguments.url)'"

        $arguments.file = Get-ChocolateyWebFile @packageArgs
    }

    $destinationFile = Join-Path $packageArgs.destination ([System.IO.Path]::GetFileName($packageArgs.file))

    if ($packageArgs.executable) {
        $destinationFile = Join-Path $packageArgs.destination $packageArgs.executable
    }

    Write-Message "Install-WithCopy: Copying $($packageArgs.file) to $($packageArgs.destination)"

    New-Item -ItemType Directory $packageArgs.destination -Force | Out-Null
    Copy-Item $packageArgs.file $destinationFile -Force | Out-Null
}