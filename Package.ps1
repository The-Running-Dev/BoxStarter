Write-Host "-=Build all chocolatey packs=-"

$nuspecs = Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse

Foreach($nuspec in $nuspecs){
    choco pack $nuspec.FullName
}

$artifactsFolder = "./Artifacts"

remove-item -path $artifactsFolder -Force -Recurse -ErrorAction SilentlyContinue
New-Item $artifactsFolder -Force -Type Directory | Out-Null
Move-Item *.nupkg $artifactsFolder