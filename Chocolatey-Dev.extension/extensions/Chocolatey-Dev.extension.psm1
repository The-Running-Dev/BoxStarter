# Export functions that start with capital letter, others are private
# Include file names that start with capital letters, ignore others
$scriptRoot = Split-Path $MyInvocation.MyCommand.Definition

if ($env:TEAMCITY_VERSION) {
    # When PowerShell is started through TeamCity's Command Runner, the standard
    # output will be wrapped at column 80 (a default). This has a negative impact
    # on service messages, as TeamCity quite naturally fails parsing a wrapped
    # message. The solution is to set a new, much wider output width. It will
    # only be set if TEAMCITY_VERSION exists, i.e., if started by TeamCity.
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(8192, 50)
}

$global:ahkCompiler = Join-Path $PSScriptRoot 'Bin\AutoHotKey\Ahk2Exe.exe'
$global:defaultFilter = 'config.json,extensions,tools,*.ini,*.png,*.svg,*.ignore,*.nuspec,*.reg,*.xml"'
$global:config = @{
    artifacts = ''
    local     = @{
        include = $global:defaultFilter -split ','
        sources = @(@{
                source = ''
                apiKey = ''
            })
    }
    remote    = @{
        include = $global:defaultFilter -split ','
        sources = @(@{
                source = ''
                apiKey = ''
            })
    }
}
$global:configFile = 'config.json'
$global:excludeDirectoriesFromConfigurationRegEx = '\.git|\.vscode|artifacts|extensions|plugins|tools|tests'
$global:gitHubApiUrl = 'https://api.github.com/repos/$repository/releases/latest'

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo')
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SmoExtended')
Add-Type -Path (Join-Path -Resolve $PSScriptRoot 'Bin\Newtonsoft.Json.dll')

$pre = Get-ChildItem Function:\*

Get-ChildItem -Recurse "$scriptRoot\*.ps1" | Where-Object { $_.Name -cmatch '^[A-Z]+' } | ForEach-Object { . $_  }

$post = Get-ChildItem Function:\*

$funcs = Compare-Object $pre $post | Select-Object -Expand InputObject | Select-Object -Expand Name
$funcs | Where-Object { $_ -cmatch '^[A-Z]+'} | ForEach-Object { Export-ModuleMember -Function $_ }