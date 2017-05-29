function Invoke-ChocoPush {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $baseDir,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][String] $searchTerm,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][String] $sourceType = 'local'
    )

    $searchTerm = Get-SearchTerm $searchTerm
    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName

        $directoryConfig = Get-DirectoryConfig $currentDir $baseConfig
        $config = Get-SourceConfig $directoryConfig $sourceType

        foreach ($source in $config.sources) {
            $pushTo = $source.pushTo
            $apiKey = $source.apiKey

            # Make sure we can access the source directory
            if (-not ($pushTo -match '^http') -and -not (Test-Path $pushTo)) {
                break
            }

            $packageAritifactRegEx = $p.Name -replace '(.*?).nuspec', '$1([0-9\.]+)\.nupkg'

            # If the path is a local path
            if (Test-Path $pushTo) {
                # Delete any previous versions of the same package
                Get-ChildItem $pushTo -Recurse -File `
                    | Where-Object { $_.Name -match $packageAritifactRegEx } | Remove-Item
            }

            Get-ChildItem -Path $baseDir -Recurse -File `
                | Where-Object { $_.Name -match $packageAritifactRegEx } `
                | Select-Object FullName `
                | ForEach-Object {
                choco push $_.FullName -s $pushTo -k="$apiKey"
                Remove-Item $_.FullName
            }
        }
    }
}