function Initialize-Package {
    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $spec,
        [parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $packageId,
        [parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $outputDirectory,
        [parameter(Position = 3, ValueFromPipelineByPropertyName)][string] $version,
        [Parameter(Position = 4, ValueFromPipelineByPropertyName)][string] $releaseNotes
    )

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
        spec            = $spec
        packageId       = $packageId
        outputDirectory = $o
        version         = $v
    }
}