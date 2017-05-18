$readme = Join-Path $PSScriptRoot '.\README.md'
$readmeTemplate = Join-Path $PSScriptRoot '.\README.template.md'

$readmeContents = Get-Content $readmeTemplate -Encoding UTF8 -Raw
$packages = Get-ChildItem $PSScriptRoot *.nuspec -Recurse | ForEach-Object { " * $((Split-Path -Leaf $_) -replace '\.\w+$', '')`n" }

$readmeContents = $ExecutionContext.InvokeCommand.ExpandString($readmeContents)

Set-Content $readme $readmeContents