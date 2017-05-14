function Initialize-Package() {
    param(
        [parameter(Position = 0, Mandatory = $true)][string] $spec,
        [parameter(Position = 1, Mandatory = $true)][string] $packageId,
        [parameter(Position = 2, Mandatory = $false)][string] $outputDirectory = '',
        [parameter(Position = 3, Mandatory = $false)][string] $version = '',
        [Parameter(Position = 4, Mandatory = $false)][string] $releaseNotes = ''
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