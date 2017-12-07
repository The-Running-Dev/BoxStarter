function Invoke-ChocoPush {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $baseDir,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][String] $searchTerm,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][switch] $remote,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][switch] $force
    )

    $searchTerm = Get-SearchTerm $searchTerm
    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName

        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = @{$true = $config.remote; $false = $config.local}[$remote -eq $true]

        foreach ($s in $sourceConfig.sources) {
            $source = $s.source
            $apiKey = $s.apiKey

            # Make sure we can access the source directory
            if (-not ($source -match '^http') -and -not (Test-Path $source)) {
                break
            }

            $packageAritifactRegEx = $p.Name -replace '(.*?).nuspec', '$1([0-9\.]+)\.nupkg'

            $packageToPush = Get-ChildItem -Path $baseDir -Recurse -File `
                | Where-Object { $_.Name -match $packageAritifactRegEx } `
                | Select-Object FullName

            # If the path is a local path
            # and the process created any new packages to be pushed
            if ((Test-Path $source) -and $packageToPush) {
                # Delete any previous versions of the same package
                $previousVersion = Get-ChildItem $source -Recurse -File `
                    | Where-Object { $_.Name -match $packageAritifactRegEx }

                if ($previousVersion) {
                    Write-Host "Deleting previous version '$($previousVersion.FullName)'..."
                    Remove-Item $previousVersion.FullName
                }
            }

            $packageToPush | ForEach-Object {
                choco push $_.FullName -s $source -k="$apiKey" -f
                Remove-Item $_.FullName
            }
        }
    }
}