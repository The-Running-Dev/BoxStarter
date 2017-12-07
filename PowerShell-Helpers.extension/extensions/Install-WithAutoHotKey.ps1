function Install-WithAutoHotKey {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    # No executable script provided, find the Install.exe in the package directory
    if (![System.IO.File]::Exists($packageArgs.executable)) {
        $packageArgs.executable = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
                -Filter 'Install.exe' | Select-Object -First 1 -ExpandProperty FullName)
    }

    # The executable parameter does not contain a full path
    if (![System.IO.Path]::IsPathRooted($packageArgs.executable)) {
        $packageArgs.executable = Join-Path $env:ChocolateyPackageFolder $packageArgs.executable
    }

    # Launch the AutoHotkey script that install the application
    Start-Process $packageArgs.executable

    # Need to reset $arguments.executable so install package doesn't run it
    $packageArgs.executable = ''

    Install-Package $packageArgs
}