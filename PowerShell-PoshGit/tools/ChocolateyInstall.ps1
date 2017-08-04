$arguments = @{
    url         = 'https://github.com/dahlbyk/posh-git/archive/v0.7.1.zip'
    checksum    = 'DB719056C3B6A2160940FAD42740F4DAD9CF6A684AD2D61BEB15599427CF734C'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}
$installPath = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Posh-Git'
if (Test-Path $installPath) {
    Remove-Item $installPath -Recurse -Force
}

Install-FromZip $arguments

# Move Posh-Git\src to Posh-Git
Get-ChildItem $arguments.destination Get-ChildItem posh-git*\src | Move-Item -Destination $installPath

if (Test-Path $profile) {
    $oldProfile = Get-Content $profile
    $profileEncoding = Get-FileEncoding $profile

    . $installPath\Utils.ps1

    $newProfile = @()

    foreach ($line in $oldProfile) {
        if ($line -like '*PoshGitPrompt*') { continue }

        if ($line -like '. *posh-git*profile.example.ps1*') {
            $line = ". '$currentVersionPath\profile.example.ps1' choco"
        }

        if ($line -like 'Import-Module *\src\posh-git.psd1*') {
            Import-Module $installDir\src\posh-git.psd1
            Add-PoshGitToProfile -WhatIf:$WhatIf -Force:$Force -Verbose:$Verbose

            $line = "Import-Module '$currentVersionPath\src\posh-git.psd1'"
        }

        $newProfile += $line
    }

    Set-Content -path $profile -value $newProfile -Force -Encoding $oldProfileEncoding
}

$installer = Join-Path $currentVersionPath 'install.ps1'
& $installer
