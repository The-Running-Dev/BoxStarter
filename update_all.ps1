param([string] $name, [string] $forcedPackages, [string] $root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$options = [ordered]@{
    WhatIf           = $au_WhatIf
    Force            = $false
    Timeout          = 100
    UpdateTimeout    = 1200
    Threads          = 10
    Push             = $env:au_Push -eq 'true'
    PluginPath       = ''
    IgnoreOn         = @(
        'Could not create SSL/TLS secure channel'
        'Could not establish trust relationship'
        'The operation has timed out'
        'Internal Server Error'
    )
    RepeatOn         = @(
        'Could not create SSL/TLS secure channel'
        'Could not establish trust relationship'
        'Unable to connect'
        'The remote name could not be resolved'
        'Choco pack failed with exit code 1'
        'The operation has timed out'
        'Internal Server Error'
        'An exception occurred during a WebClient request'
    )
    # How much to sleep between repeats in seconds, by default 0
    #RepeatSleep   = 250
    # How many times to repeat on errors, by default 1
    #RepeatCount   = 2

    Report           = @{
        Type   = 'markdown'                                   # Report type: markdown or text
        Path   = "$PSScriptRoot\Update-AUPackages.md"         # Path where to save the report
        Params = @{                                           # Report parameters:
            Github_UserRepo = $env:github_user_repo           #  Markdown: shows user info in upper right corner
            NoAppVeyor      = $false                          #  Markdown: do not show AppVeyor build shield
            UserMessage     = "[Ignored](#ignored) | [History](#update-history) | [Force Test](https://gist.github.com/$env:gist_id_test) | **USING AU NEXT VERSION**"       #  Markdown, Text: Custom user message to show
            NoIcons         = $false                          #  Markdown: don't show icon
            IconSize        = 32                              #  Markdown: icon size
            Title           = ''                              #  Markdown, Text: TItle of the report, by default 'Update-AUPackages'
        }
    }

    History          = @{
        # Number of lines to show
        Lines           = 90
        # User repo to be link to commits
        Github_UserRepo = $env:github_user_repo
        # Path where to save history
        Path            = "$PSScriptRoot\Update-History.md"
    }

    Gist             = @{
        # Your gist id; leave empty for new private or anonymous gist
        Id     = $env:gist_id
        # Your github api key - if empty anoymous gist is created
        ApiKey = $env:github_api_key
        # List of files to add to the gist
        Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"
    }

    Git              = @{
        # Git username, leave empty if github api key is used
        User     = ''
        # Password if username is not empty, otherwise api key
        Password = $env:github_api_key
    }

    RunInfo          = @{
        # Option keys which contain those words will be removed
        Exclude = 'password', 'apikey'
        # Path where to save the run info
        Path    = "$PSScriptRoot\update_info.xml"
    }

    Mail             = if ($env:mail_user) {
        @{
            To          = $env:mail_user
            Server      = $env:mail_server
            UserName    = $env:mail_user
            Password    = $env:mail_pass
            Port        = $env:mail_port
            EnableSsl   = $env:mail_enablessl -eq 'true'
            Attachment  = "$PSScriptRoot\update_info.xml"
            UserMessage = 'Update status: http://gep13.me/choco-au'
            SendAlways  = $false
        }
    }
    else {}

    ForcedPackages   = $forcedPackages -split ' '
    UpdateIconScript = "$PSScriptRoot\scripts\Update-IconUrl.ps1"
    BeforeEach       = {
        param($packageName, $Options )
        . $Options.UpdateIconScript $PackageName.ToLowerInvariant() -Quiet -ThrowErrorOnIconNotFound

        $p = $Options.ForcedPackages | ? { $_ -match "^${PackageName}(?:\:(.+))*$" }
        if (!$p) { return }

        $global:au_Force = $true
        $global:au_Version = ($p -split ':')[1]
    }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }

# Path to the AU packages
$global:au_Root = $root
$global:info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($global:info.error_count.total) { throw 'Errors during update' }
