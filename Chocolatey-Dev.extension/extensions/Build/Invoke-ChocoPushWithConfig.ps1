function Invoke-ChocoPushWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
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
            if (!$pushTo.StartsWith('http') -and !(Test-Path $pushTo)) {
                break
            }

            $packageAritifactRegEx = $p.Name -replace '(.*?).nuspec', '$1([0-9\.]+)\.nupkg'

            # Delete any previous versions of the same package
            Get-ChildItem $pushTo -Recurse -File `
                | Where-Object { $_.Name -match $packageAritifactRegEx } | Remove-Item

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