$excludeFiles = $('update.ps1', 'chocolateyInstall.ps1', '*.nupkg')

# packageDir is defined in the individual update script
Set-Location $packageDir

$toolsPath = Join-Path $packageDir 'tools'

function global:au_BeforeUpdate {
    if ((Test-DirectoryExists $settingsDir) -and $settingsZip) {
        Compress-Archive -Path $settingsDir -DestinationPath $settingsZip -Force
    }
}

function global:au_GetLatest {
    $version = [version]'0.0.0'
    $oldChecksum = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)^[$]packageChecksum\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1

    # $settingsDir is defined in the individual update script
    $currentChecksum = Get-ChildItem -Exclude $excludeFiles $settingsDir -Recurse `
        | ForEach-Object { Get-FileHash $_.FullName } `
        | ForEach-Object { $_.Hash } | Join-String

    if (($currentChecksum -ne $oldChecksum) -or $force) {
        $version = [version][DateTime]::Now.ToString('yyyy.MM.dd')
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