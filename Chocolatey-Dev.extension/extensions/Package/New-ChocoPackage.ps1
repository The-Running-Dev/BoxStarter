function New-ChocoPackage {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $spec,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][array] $includeFilter,
        [parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateScript( {Test-Path $_ -PathType Container})][string] $outputPath,
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
        Write-Host "Updating Package with $updateScript"

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
        <#
        if (![System.IO.Directory]::Exists($outputPath)) {
            New-Item -Path $outputPath -ItemType Directory
        }

        if (Test-Path $tempDir) {
            Remove-Item $tempDir -Force -Recurse
        }

        # Create a temporaty directory for the package
        # and move all the extra files from the package directory
        # so they don't become part of the package
        New-Item -ItemType Directory $tempDir -Force | Out-Null
        $extraFiles = Get-ChildItem -Path $packageDir -Exclude $includeFilter
        foreach ($f in $extraFiles) {
            Move-Item $f.FullName $tempDir
        }
        #>

        # Compile all .ahk files
        Invoke-AutoHotKey $packageDir

        # Delete the package from the output path if it exists
        Remove-Item $outputPath -Include "$packageId**" -Force

        choco pack $spec --outputdirectory $outputPath

        <#
        # Move all the extra files from the temp directory
        # back to the package directory
        $extraFiles = Get-ChildItem -Path $tempDir
        foreach ($f in $extraFiles) {
            Move-Item $f.FullName $packageDir
        }

        Remove-Item $tempDir -Recurse -Force
        #>
    }
}