Write-Host "Building Chocolatey Pacakges"

$nuspecs = Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse

Foreach($nuspec in $nuspecs){
    choco pack $nuspec.FullName
}

$artifactsFolder = "../"

Move-Item *.nupkg $artifactsFolder -Force