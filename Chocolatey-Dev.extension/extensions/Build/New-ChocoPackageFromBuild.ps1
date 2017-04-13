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