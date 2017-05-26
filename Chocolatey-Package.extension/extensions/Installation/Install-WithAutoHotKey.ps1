function Install-WithAutoHotKey {
    param(
        [PSCustomObject] $arguments
    )

    # No executable script provided, find the Install.exe in the package directory
    if (![System.IO.File]::Exists($arguments.executable)) {
        $arguments.executable = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Filter 'Install.exe' | Select-Object -First 1 -ExpandProperty FullName)
    }

    # The executable parameter does not contain a full path
    if (![System.IO.Path]::IsPathRooted($arguments.executable)) {
        $arguments.executable = Join-Path $env:ChocolateyPackageFolder $packageArgs.executable
    }

    # Launch the AutoHotkey script that install the application
    Start-Process $arguments.executable

    # We need to reset $arguments.executable so install package doesn't run it
    $arguments.executable = ''

    Install-Package $arguments
}