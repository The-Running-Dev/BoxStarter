function New-NuGetPackageFromBuild {
    param(
        [parameter(Position = 0, Mandatory = $true)][string] $spec,
        [parameter(Position = 1, Mandatory = $true)][string] $packageId,
        [parameter(Position = 2, Mandatory = $false)][string] $outputDirectory = '',
        [parameter(Position = 3, Mandatory = $false)][string] $version = '',
        [Parameter(Position = 4, Mandatory = $false)][string] $releaseNotes = ''
    )

    $args = Initialize-Package @PSBoundParameters

    Write-BuildProgress 'Creating NuGet Package'

    & nuGet pack $args.spec `
        -OutputDirectory $args.outputDirectory `
        -Properties Configuration=Release `
        -Version $args.version `
        -NoPackageAnalysis
}