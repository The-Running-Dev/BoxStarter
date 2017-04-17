function Install-CustomPackage {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if ($packageArgs.fileType -eq 'zip') {
        Install-FromZip $packageArgs
    }
    elseif ($packageArgs.fileType -eq 'iso') {
        Install-FromIso $packageArgs
        Dismount-DiskImage -ImagePath $global:isoPath
    }
    elseif (!(Test-FileExists $packageArgs.file)) {
        Install-FromWeb $packageArgs
    }
    else {
        #$installer = Get-Executable $packageArgs.destination $packageArgs.executable $packageArgs.executableRegEx
        Install-ChocolateyInstallPackage @args
    }

    #Write-Verbose 'Install-CustomPackage: No installer or url provided. Aborting...'
    #throw 'No installer or url provided. Aborting...'
}