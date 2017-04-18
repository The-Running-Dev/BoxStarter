$excludeFiles = $('update.ps1', 'chocolateyInstall.ps1', '*.nupkg')

# packageDir is defined in the individual update script
Set-Location $packageDir

$toolsPath = Join-Path $packageDir 'tools'

function global:au_BeforeUpdate {
    if ([System.IO.Directory]::Exists($settingsDir) -and $settingsZip) {
        Compress-Archive -Path $settingsDir -DestinationPath $settingsZip -Force
    }
}

function global:au_GetLatest {
    # Get the version from the nuspec as we want it to always be the same
    # unless we manually update it
    $version = (Get-Item "$($Latest.PackageName).nuspec" `
        | Select-String "(?i)<version>([0-9\.]+)</version>") `
        | ForEach-Object { $_.Matches[0].Groups[1].Value }
    $oldChecksum = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)^[$]packageChecksum\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1

    # $settingsDir is defined in the individual update script
    $currentChecksum = Get-ChildItem -Exclude $excludeFiles $settingsDir -Recurse `
        | ForEach-Object { Get-FileHash $_.FullName } `
        | ForEach-Object { $_.Hash } | Join-String

    if (($currentChecksum -ne $oldChecksum) -or $force) {
        $global:au_Version = $version
    }

    return @{ Version = $version; Checksum32 = $currentChecksum }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]packageChecksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}