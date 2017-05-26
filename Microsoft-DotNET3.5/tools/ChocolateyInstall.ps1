$packageChecksum = '38FE3828609329BDFDF7839B01420BC8EE8AE2FB408B156584D6870EB01382C8A773AE214DACC747839FBEC900B4A1169E3D269A62E97CB799EF0A08D5C6656C'

if(-not (test-path "hklm:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5")) {
    if((wmic os get caption | Out-String).Contains("Server")) {
        $packageArgs = "/c DISM /Online /NoRestart /Enable-Feature /FeatureName:NetFx3ServerFeatures"
        $statements = "cmd.exe $packageArgs"

        Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0, 1)
    }

    $packageArgs = "/c DISM /Online /NoRestart /Enable-Feature /FeatureName:NetFx3"
    $statements = "cmd.exe $packageArgs"

    Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0)
}
else {
    Write-Host "Microsoft .Net 3.5 Framework is already installed on your machine."
}
