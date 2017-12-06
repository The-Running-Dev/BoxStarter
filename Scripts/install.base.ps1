$baseDir = Join-Path $env:Temp 'Chocolatey-Base'
$baseFile = Join-Path $baseDir 'Base.zip'

Invoke-WebRequest -Uri 'https://github.com/The-Running-Dev/BoxStarter-Scripts/blob/master/Base/Base.zip?raw=true' -OutFile $baseFile

if (Test-Path $$baseFile) {
    Expand-Archive $baseFile $baseDir

    & "$baseDir\install.choco.ps1" -Force

    Remove-Item $baseDir -Recurse -Force
}