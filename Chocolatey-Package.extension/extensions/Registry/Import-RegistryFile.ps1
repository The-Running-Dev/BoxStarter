function Import-RegistryFile {
    param (
        [parameter(Position = 0, ValueFromPipeline)][Hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    try {
        # If settings are provided and the file exists
        if ([System.IO.File]::Exists($packageArgs.file)) {
            Write-Message "Import-RegistryFile: '$($packageArgs.file)' exists."

            if ([System.IO.File]::Exists($packageArgs.executable)) {
                Write-Message "Import-RegistryFile: Starting '$($packageArgs.executable).'"
                & $($packageArgs.executable)
            }

            Write-Message "Import-RegistryFile: Finding process '$($packageArgs.processName).'"

            if ($packageArgs.processName) {
                if (Get-Process -Name $($packageArgs.processName) -ErrorAction SilentlyContinue) {
                    Write-Message "Import-RegistryFile: Trying to kill '$($packageArgs.processName).'"

                    # Kill the started application
                    Stop-Process -Name $packageArgs.processName
                }
            }

            # Import the provided settings
            Write-Message "Import-RegistryFile: Importing '$($packageArgs.file).'"
            & regedit /s $($packageArgs.file)
        }
    }
    catch {
        Write-Message "Import-RegistryFile: Import failed with '$($_.Exception.Message).'"
    }
}