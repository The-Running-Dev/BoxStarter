$global:ahkCompiler = Join-Path $PSScriptRoot 'AutoHotKey\Ahk2Exe.exe'

function Get-Packages {
    param (
        [parameter(Mandatory = $true)][string] $baseDir,
        [parameter(Mandatory = $false)][string] $searchTerm = '',
        [parameter(Mandatory = $false)][string] $filter = ''
    )

    if (!$searchTerm) {
        # Get all packages in the base directory and sub directories
        $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
    }
    else {
        $packages = @()

        foreach ($p in $searchTerm.split(' ')) {
            $packages += Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$p.*"}
        }
    }

    return $packages
}

function Invoke-AutoHotKey {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $true, Position = 2)][object] $files = @{}
    )

    if (!$files) {
        $files = Get-ChildItem -Path $baseDir -Filter *.ahk -Recurse
    }

    foreach ($f in $files) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}

function New-ChocoPackageFromBuild {
    param(
        [parameter(Mandatory = $true, Position = 0)][string] $spec,
        [parameter(Mandatory = $true, Position = 1)][string] $packageId,
        [parameter(Mandatory = $false)][string] $outputDirectory = '',
        [parameter(Mandatory = $false)][string] $version = '',
        [Parameter(Mandatory = $false)][string] $releaseNotes = ''
    )

    $args = Initialize-Package @PSBoundParameters

    Write-Progress 'Creating Chocolatey Package'
    choco pack $args.spec `
        --OutputDirectory $args.outputDirectory `
        --Version $args.version
}

function New-ChocoPackageWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $nuSpec,
        [Parameter(Mandatory = $true, Position = 1)][ValidateNotNullOrEmpty()][Hashtable] $config,
        [Parameter(Mandatory = $true, Position = 2)][ValidateNotNullOrEmpty()][string] $outputPath
    )

    $packageId = (Split-Path -Leaf $nuSpec) -replace '.nuspec', ''
    $packageDir = Split-Path -Parent $nuSpec
    $tempDir = Join-Path $env:Temp $packageId

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
    $extraFiles = Get-ChildItem -Path $packageDir -Exclude $config['include']
    foreach ($f in $extraFiles) {
        Move-Item $f.FullName $tempDir
    }

    # Find and compile all .ahk files
    $ahkFiles = Get-ChildItem -Path $packageDir -Filter *.ahk -Recurse
    if ($ahkFiles) {
        Invoke-AutoHotKey $packageDir $ahkFiles
    }

    # Delete the package from the output path if it exists
    Remove-Item $outputPath -Include "$packageId**" -Force

    choco pack $nuSpec --outputdirectory $outputPath

    # Move all the extra files from the temp directory
    # back to the package directory
    $extraFiles = Get-ChildItem -Path $tempDir
    foreach ($f in $extraFiles) {
        Move-Item $f.FullName $packageDir
    }
    Remove-Item $tempDir -Recurse -Force
}

function New-NuGetPackageFromBuild {
    param(
        [parameter(Mandatory = $true, Position = 0)][string] $spec,
        [parameter(Mandatory = $true, Position = 1)][string] $packageId,
        [parameter(Mandatory = $false)][string] $outputDirectory = '',
        [parameter(Mandatory = $false)][string] $version = '',
        [Parameter(Mandatory = $false)][string] $releaseNotes = ''
    )

    $args = Initialize-Package @PSBoundParameters

    Write-Progress 'Creating NuGet Package'
    & nuGet pack $args.spec `
        -OutputDirectory $args.outputDirectory `
        -Properties Configuration=Release `
        -Version $args.version `
        -NoPackageAnalysis
}

function Invoke-ChocoPackWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = Get-SourceConfig $config $sourceType

        New-ChocoPackageWithConfig $p.FullName $sourceConfig $config.artifacts
    }
}

function Invoke-ChocoPushWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName

        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = Get-SourceConfig $config $sourceType

        $source = $sourceConfig['source']
        $apiKey = $sourceConfig['apiKey']

        $packageAritifactRegEx = $($p.Name -replace '(.*?).nuspec', '$1.[0-9\.]+\.nupkg')
        Get-ChildItem -Path $baseDir -Recurse -File `
            | Where-Object { $_.Name -match $packageAritifactRegEx } `
            | Select-Object FullName `
            | ForEach-Object { choco push $_.FullName -s $source -k="$apiKey" }
    }
}

function Initialize-Package() {
    param(
        [parameter(Mandatory = $true, Position = 0)][string] $spec,
        [parameter(Mandatory = $true, Position = 1)][string] $packageId,
        [parameter(Mandatory = $false)][string] $outputDirectory = '',
        [parameter(Mandatory = $false)][string] $version = '',
        [Parameter(Mandatory = $false)][string] $releaseNotes = ''
    )

    if (-not(Test-Path $spec)) {
        throw "Could Not Find Spec at $spec"
    }

    if (-not($packageId)) {
        throw 'No PackageId Specified'
    }

    # Provide a default for the output path
    $o = @{$true = $outputDirectory; $false = [System.IO.Path]::GetDirectoryName($spec)}[[System.IO.Directory]::Exists($outputDirectory)]

    # Provide a default for the version
    $v = @{$true = [DateTime]::Now.ToString("yyyy.MM.dd"); $false = $version}['' -Match $version]

    if (Test-Path($releaseNotes) -ErrorAction SilentlyContinue) {
        $notes = Get-Content -Path $releaseNotes -ErrorAction SilentlyContinue
    }
    elseif ($releaseNotes) {
        $notes = $releaseNotes
    }

    # Save the release notes in the spec
    Set-XmlValue $spec '//ns:releaseNotes' "`n$notes"

    # Set the ID the spec
    Set-XmlValue $spec '//ns:id' $packageId

    return @{
        spec = $spec
        packageId = $packageId
        outputDirectory = $o
        version = $v
    }
}

Export-ModuleMember -Function *