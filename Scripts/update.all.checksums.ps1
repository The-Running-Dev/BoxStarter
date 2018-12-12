param (
    [Parameter(Position = 0)][switch] $download
)

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

Get-ChildItem -Recurse "$baseDirPath\ChocolateyInstall.ps1" | ForEach-Object {
    $url = (Get-Item $_ | Select-String "(?i)url\s*=\s*('|`").*('|`")") -Split "=|'" | Select-Object -First 1 -Skip 2
    $packageName = (Get-Item(Get-ParentDirectory $_)).BaseName

    if (-not $url) {
        Write-Host "No URL Exists, Skipping $packageName..."
        return
    }

    $file = ([System.IO.Path]::GetFileName($url)) -replace '%20', ' '
    $installerFile = Join-Path $installersPath $file

    if ($download -and (-not(Test-Path $installerFile))) {
        Write-Host "Downloading Installer '$_'.."
        Invoke-WebRequest -Uri $_ -OutFile $installerFile
    }

    if (-not(Test-Path $installerFile)) {
        Write-Host "Installer '$installerFile' Does Not Exist..."
        return
    }

    $sr = Get-ChecksumReplace $_ $installerFile
    $fileContent = Get-Content $_
    $sr.GetEnumerator() | % {
        if (!($fileContent -match $_.name)) { throw "Search Pattern not Found: '$($_.name)'..." }
        $fileContent = $fileContent -replace $_.name, $_.value
    }
    Write-Host "Updating '$_'..."
    $fileContent | Out-File $_

    Write-Host "Rebuiding Package '$packageName'..."
    & $updateScriptPath $packageName -f
}