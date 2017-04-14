if ($MyInvocation.InvocationName -eq '.') {
    $publishDir = Resolve-Path ..\..\..\BoxStarter
}

$global:au_Force = $false

$toolsPath = Resolve-Path 'tools'
$packageDir = Resolve-Path .

function global:au_BeforeUpdate {
    # Use the AU function to get the installer
    Get-RemoteFiles

    # Find the downloaded file
    $downloadedFile = (Get-ChildItem -Recurse *.exe, *.msi, *.zip | Select-Object -First 1)

    # Remove the _32 and any HTML encoded space
    $installerFile = Join-Path $packageDir (((Split-Path -Leaf $downloadedFile) -replace '_x32', '') -replace '%20', ' ')

    # Move the installer to the package directory
    # because I don't like it under the tools directory
    Move-Item $downloadedFile $installerFile -Force

    # Create a .ignore file for each found executable
    Get-ChildItem *.exe, *.msi | ForEach-Object { New-Item "$($_.FullName).ignore" -ErrorAction SilentlyContinue }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.Url32) -replace '%20', ' ')'"
            "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}