# Export functions that start with capital letter, others are private
# Include file names that start with capital letters, ignore others
$scriptRoot = Split-Path $MyInvocation.MyCommand.Definition

Import-Module WebAdministration -Force

$global:newtonsoftJsonDll = Join-Path -resolve $PSScriptRoot 'Tools\DLLs\Newtonsoft.Json.dll'
$global:ahkCompiler = Join-Path $PSScriptRoot 'Tools\AutoHotKey\Ahk2Exe.exe'
$global:defaultFilter = 'config.json,extensions,tools,*.ini,*.png,*.svg,*.ignore,*.nuspec,*.reg,*.xml"'
$global:config = @{
    artifacts = ''
    local = @{
        include = $global:defaultFilter | Split-String ','
        sources = @(@{
            pushTo = ''
            apiKey = ''
        })
    }
    remote = @{
        include = $global:defaultFilter | Split-String ','
        sources = @(@{
            pushTo = ''
            apiKey = ''
        })
    }
}
$global:configFile = 'config.json'
$global:excludeDirectoriesFromConfigurationRegEx = '\.git|\.vscode|artifacts|extensions|plugins|tools|tests'
$global:gitHubApiUrl = 'https://api.github.com/repos/$repository/releases/latest'

$pre = Get-ChildItem Function:\*

Get-ChildItem -Recurse "$scriptRoot\*.ps1" | Where-Object { $_.Name -cmatch '^[A-Z]+' } | ForEach-Object { . $_  }

$post = Get-ChildItem Function:\*

$funcs = Compare-Object $pre $post | Select-Object -Expand InputObject | Select-Object -Expand Name
$funcs | Where-Object { $_ -cmatch '^[A-Z]+'} | ForEach-Object { Export-ModuleMember -Function $_ }