param (
    [Parameter(Position = 0)][switch] $download
)

$downloadsFile = 'Downloads.txt'
$updateScript = 'update.ps1'
$installers = '..\..\..\BoxStarter\Installers'
$baseDir = '..\'
$downloadsFlePath = Join-Path $PSScriptRoot $downloadsFile -Resolve
$installersPath = Join-Path $PSScriptRoot $installers -Resolve
$baseDirPath = Join-Path $PSScriptRoot $baseDir -Resolve
$updateScriptPath = Join-Path $baseDirPath $updateScript -Resolve

function Get-ChecksumReplace {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)][string] $chocolateyInstallPath,
        [Parameter(Position = 1)][string] $installerFile
    )

    if (-not (Test-Path $installerFile)) {
        return @{}
    }

    $checksum = (Get-Item $chocolateyInstallPath | Select-String "(?i)checksum\s*=\s*'.*'") -Split "=|'" | Select-Object -First 1

    if ($checksum) {
        $fileHash = Get-FileHash $installerFile

        return @{ "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($fileHash.Hash)'"}
    }

    return @{}
}

$downloadFileContents = Get-Content $downloadsFlePath -Raw
$downloadFileContents -Split '[\r\n]' | ForEach-Object {
    if (-not $_) {
        return
    }

    $encodedFile = [System.IO.Path]::GetFileName($_)
    $file = $encodedFile -replace '%20', ' '
    $installerFile = Join-Path $installersPath $file

    write-host "Finding 'ChocolateyInstall.ps1' Containing '$_'..."
    $chocolateyInstall = Get-ChildItem -Recurse "$baseDirPath\ChocolateyInstall.ps1" | Select-String "(?i)url\s*=\s.*$_" | Select-Object -Unique Path

    if (-not $chocolateyInstall) {
        # Remove the non existant file from list of downloads
        (Get-Content $downloadsFlePath) -replace $_, '' | Out-File $downloadsFlePath
        return
    }

    if ($download -and (-not(Test-Path $installerFile))) {
        Write-Host "Downloading Installer '$_'..."
        Invoke-WebRequest -Uri $_ -OutFile $installerFile
    }

    if (-not(Test-Path $installerFile)) {
        Write-Host "Installer '$installerFile' Does Not Exist..."
        return
    }

    $packageName = (Get-Item(Get-ParentDirectory $chocolateyInstall.Path)).BaseName
    $sr = Get-ChecksumReplace $chocolateyInstall.Path $installerFile
    $fileContent = Get-Content $chocolateyInstall.Path
    $sr.GetEnumerator() | % {
        if (!($fileContent -match $_.name)) { throw "Search Pattern not Found: '$($_.name)'..." }
        $fileContent = $fileContent -replace $_.name, $_.value
    }
    $fileContent | Out-File $chocolateyInstall.Path

    # Remove the downloaded file the list of downloads
    ($downloadFileContents -replace "$_[\r\n]", '').Trim() | Out-File $downloadsFlePath

    & $updateScriptPath $packageName -f
}