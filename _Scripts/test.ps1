$baseDir = Join-Path $PSScriptRoot .. -Resolve

. E:\Dropbox\Projects\BoxStarter\Chocolatey-Dev.extension\extensions\Config\Get-DirectoryConfig.ps1

$baseConfig = Get-DirectoryConfig $baseDir

Write-Host $($baseConfig.remote.sources | out-string)