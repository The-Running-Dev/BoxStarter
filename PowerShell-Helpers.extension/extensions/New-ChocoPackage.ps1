function New-ChocoPackage {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $spec,
        [parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateScript( {Test-Path $_ -PathType Container})][string] $outputPath,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][array] $includeFilter,
        [Parameter(Position = 3)][switch] $force
    )

    $packageId = (Split-Path -Leaf $spec) -replace '.nuspec', ''
    $packageDir = Split-Path -Parent $spec
    $updateScript = Join-Path $packageDir 'update.ps1'
    $tempDir = Join-Path $env:Temp $packageId
    $packageBuiltFromUpdate = $false

    # If update script exists for the package
    # run it instead of packing it yourself
    if (Test-Path $updateScript) {
        Write-Host "Updating Package with '$updateScript'..."

        # Compile all .ahk files
        Invoke-AutoHotKey $packageDir

        if ($force) {
            & $updateScript -Force
        }
        else {
            & $updateScript
        }

        $package = Get-ChildItem *.nupkg | Select-Object -First 1 -ExpandProperty FullName

        # Delete the package from the output path if it exists
        Remove-Item $outputPath -Include "$packageId**" -Force

        if ([System.IO.File]::Exists($package)) {
            Move-Item $package $outputPath -Force
        }
    }
    else {
        # Compile all .ahk files
        Invoke-AutoHotKey $packageDir

        # Delete the package from the output path if it exists
        Remove-Item $outputPath -Include "$packageId**" -Force

        choco pack $spec --outputdirectory $outputPath
    }
}