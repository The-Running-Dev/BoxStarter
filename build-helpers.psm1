$global:ahkCompiler = Join-Path $PSScriptRoot "AutoHotKey\Ahk2Exe.exe"

function Get-Configuration {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir
    )

    $ecludeDirectoriesRegEx = 'tools|extensions|.vscode|tests|plugins'
    $configuration = @{}
    $configuration[$baseDir] = Get-DirectoryConfiguration $baseDir

    # Get all the sub directories and set configuration default
    # to the base directory unless the sub directory has it's own configuration
    $subDirectories = Get-ChildItem -Recurse -Directory | Where-Object { $_.Name -notmatch $ecludeDirectoriesRegEx } | Select-Object Parent, Name, FullName
    foreach ($dir in $subDirectories) {
        $currentDir = $dir.FullName
        $configuration[$currentDir] = Get-DirectoryConfiguration $currentDir $configuration[$baseDir]
    }

    return $configuration
}

function Get-DirectoryConfiguration() {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $directoryPath,
        [Parameter(Mandatory = $false, Position = 1)][Hashtable] $baseConfiguration = @{}
    )

    $configFile = 'config.json'
    $config = @{
        artifacts = ''
        local = @{
            embed = $false
            source = ''
            apiKey = ''
        }
        remote = @{
            embed = $false
            source = ''
            apiKey = ''
        }
    }

    $configFilePath = Join-Path $directoryPath $configFile
    if (Test-Path $configFilePath) {
        $configJson = (Get-Content $configFilePath -Raw) | ConvertFrom-Json

        if ($configJson.artifacts) {
            $config.artifacts = Join-Path -Resolve $directoryPath $configJson.artifacts
        }

        if ($configJson.remote.embed) {
            $config.remote.embed = $false

            if ('1,true,yes' -Match $configJson.remote.embed) {
                $config.remote.embed = $true
            }
        }

        if ($configJson.remote.source) {
            $config.remote.source = $configJson.remote.source
        }

        if ($configJson.remote.apiKey) {
            $config.remote.apiKey = $configJson.remote.apiKey
        }

        if ($configJson.local.embed) {
            $config.local.embed = $false

            if ('1,true,yes' -Match $configJson.local.embed) {
                $config.local.embed = $true
            }
        }

        if ($configJson.local.source) {
            $config.local.source = Join-Path -Resolve $directoryPath $configJson.local.source
        }

        if ($configJson.local.apiKey) {
            $config.local.apiKey = $configJson.local.apiKey
        }

        return $config
    }

    return $baseConfiguration
}

function Get-GitHubVersion {
    Param (
        [Parameter(Mandatory = $true)][string] $repository,
        [Parameter(Mandatory = $true)][string] $downloadUrlRegEx
    )
    $release = @{
        Version = ''
        DownloadUrl = ''
    }

    $releaseParams = @{
        Uri = "https://api.github.com/repos/$repository/releases/latest";
        Method = 'GET';
        ContentType = 'application/json';
        Body = (ConvertTo-Json $releaseData -Compress)
    }
    $servicePoint = [System.Net.ServicePointManager]::FindServicePoint($($releaseParams.Uri))

    $results = Invoke-RestMethod @releaseParams
    $assets = $result.assets

    ForEach ($result in $results) {
        $release.Version = $result.tag_name -replace '^v', ''

        foreach ($url in $result.assets.browser_download_url) {
            if ($url -match  $downloadUrlRegEx) {
                $release.DownloadUrl = $url
            }
        }
    }

    $servicePoint.CloseConnectionGroup('') | Out-Null

    return $release
}

function Get-LatestVersion([string] $url, [string] $versionRegEx) {
    return $(Get-Version (Get-RedirectUrl $url) $versionRegEx)
}

function Get-RedirectUrl([string] $url) {
    return ((Get-WebURL -Url $url).ResponseUri).AbsoluteUri
}

function Get-SourceConfiguration() {
    param (
        [Parameter(Mandatory = $true, Position = 0)][Hashtable] $configuration,
        [Parameter(Mandatory = $false, Position = 1)][String] $sourceType = 'local'
    )

    if ($sourceType -match 'remote') {
        return $configuration.remote
    }

    return $configuration.local
}

function Get-Version([string] $url, [string] $versionRegEx) {
    return $($url -replace $versionRegEx, '$1')
}

function CompileAutoHotKey {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $directoryPath,
        [Parameter(Mandatory = $true, Position = 2)][object] $files = @{}
    )

    if (!$files) {
        $files = Get-ChildItem -Path $directoryPath -Filter *.ahk -Recurse
    }

    foreach ($f in $files) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}

function Pack {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $nuSpec,
        [Parameter(Mandatory = $true, Position = 1)][ValidateNotNullOrEmpty()][Hashtable] $config,
        [Parameter(Mandatory = $true, Position = 2)][ValidateNotNullOrEmpty()][string] $outputPath
    )

    $excludeFilter = @('*.nuspec', 'tools', 'extensions')
    $excludeFilterForEmbeddedPackages = @('*.nuspec', 'tools', 'extensions', '*.zip', '*.msi', '*.exe')
    $packageId = (Split-Path -Leaf $nuSpec) -replace '.nuspec', ''
    $packageDir = Split-Path -Parent $nuSpec
    $tempDir = Join-Path $env:Temp $packageId
    $embedPackage = $config.embed

    if ($embedPackage) {
        $excludeFilter = $excludeFilterForEmbeddedPackages
    }

    if (![System.IO.Directory]::Exists($outputPath)) {
        New-Item -Path $outputPath -ItemType Directory
    }

    # Create a temporaty directory for the package
    # and move all the extra files from the package directory
    # so they don't become part of the package
    New-Item -ItemType Directory $tempDir -Force | Out-Null
    $extraFiles = Get-ChildItem -Path $packageDir -Exclude $excludeFilter
    foreach ($f in $extraFiles) {
        Move-Item $f.FullName $tempDir
    }

    # Find and compile all .ahk files
    $ahkFiles = Get-ChildItem -Path $packageDir -Filter *.ahk -Recurse
    if ($ahkFiles) {
        CompileAutoHotKey $packageDir $ahkFiles
    }

    # Delete the package from the output path if it exists
    Remove-Item $outputPath -Include "$packageId**" -Force

    choco pack $nuSpec --outputdirectory $outputPath

    # Move all the extra files from the temp directory
    # back to the package directory
    $extraFiles = Get-ChildItem -Path $tempDir
    foreach ($f in $extraFiles) {
        Move-Item $f.FullName $packageDir
    }
    Remove-Item $tempDir -Recurse -Force
}

function Package {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $package = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local',
        [Parameter(Mandatory = $false, Position = 3)][String] $embed = ''
    )

    $filter = '*.nuspec'
    $configuration = Get-Configuration $baseDir

    if ($package -eq '') {
        # Get all packages in the current directory and sub directories
        $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
    }
    else {
        # Find packages matching the package name provided
        $packages = Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$package.*"}
    }

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $sourceConfiguration = Get-SourceConfiguration $configuration[$currentDir] $sourceType

        # Allow the embed paramter to be overwritten
        if ($embed) {
            # If it's set to 1, true or yes, it's true, otherwise false
            $sourceConfiguration.embed = @{ $true = $true; $false = $false }['1,true,yes' -Match $embed]
        }

        Pack $p.FullName $sourceConfiguration $configuration[$currentDir]['artifacts']
    }
}

function Push {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $package = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $source = 'local'
    )

    $filter = '*.nupkg'
    $configuration = Get-Configuration $baseDir

    if ($package -eq '') {
        # Get all packages in the current directory and sub directories
        $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
    }
    else {
        # Find packages matching the package name provided
        $packages = Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$package.*"}
    }

    foreach ($p in $packages) {
        $packageDir = Find-Package $baseDir $p.FullName '(.*?)[0-9\.]+\.nupkg'

        $source = $configs[$packageDir]['source']
        $apiKey = $configs[$packageDir]['apiKey']

        choco push $p.FullName -s $source -k="$apiKey"
    }
}

function New-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()] [String] $path,
        [Parameter(Mandatory = $false, Position = 1)] [String] $filter = '*.*',
        [Parameter(Mandatory = $false)] [System.IO.NotifyFilters] $notifyFilter = ('FileName', 'LastWrite', 'LastAccess'),
        [Switch] $recurse
    )

    if ($PSCmdlet.ShouldProcess("$Path\$Filter", 'Initialize fileSystemWatcher')) {
        $fileSystemWatcher = New-Object System.IO.FileSystemWatcher
        $fileSystemWatcher.Path = $path
        $fileSystemWatcher.Filter = $filter
        $fileSystemWatcher.NotifyFilter = $notifyFilter

        if ($recurse) {
            $fileSystemWatcher.IncludeSubdirectories = $true
        }

        $fileSystemWatcher.EnableRaisingEvents = $true

        return $fileSystemWatcher
    }
}

function Start-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Mandatory = $false)]
        [ValidateSet('All', 'Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $type = 'All',
        [Parameter(Mandatory = $false)] [Int] $timeOut = 10000,
        [Switch] $infinite
    )

    if ($PSCmdlet.ShouldProcess("$($FileSystemWatcher.Path)", "WaitForChanged($type, $timeOut)")) {
        do {
            $fileSystemChange = $fileSystemWatcher.WaitforChanged($type, $timeOut)

            if (!$fileSystemChange.TimedOut) {
                #$fileSystemChange
            }
        }
        while ($Infinite)
    }
}

function Register-WatcherEventHandler {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0)] [Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Mandatory = $true, Position = 1)] [ValidateSet('Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $eventName,
        [Parameter(Mandatory = $true, Position = 2)] [Alias('Identifier')] [String] $eventIdentifier,
        [Parameter(Mandatory = $true, Position = 3)] [Alias('Action')] [Scriptblock] $eventAction,
        [Parameter(Mandatory = $false, Position = 4)] [Alias('MessageData')] [PSObject] $data
    )

    if ($PSCmdlet.ShouldProcess("$($FileSystemWatcher.Path)", "Register Event Handler (for File $EventName)")) {
        $writeOutput = {
            if ($EventArgs.Data -ne $null) {
                $line = $EventArgs.Data
                Write-Verbose "$line"
                if ($line.StartsWith("- ")) {
                    $global:zipFileList.AppendLine($global:zipDestinationFolder + "\" + $line.Substring(2))
                }
            }
        }

        $writeError = {
            write-Host $(EventArgs | Out-String)
        }

        Register-ObjectEvent `
            -InputObject $fileSystemWatcher `
            -EventName $eventName `
            -Action $eventAction `
            -SourceIdentifier $eventIdentifier `
            -MessageData $data `
            -Verbose

        Register-ObjectEvent -InputObject $fileSystemWatcher -SourceIdentifier "$($eventIdentifier)_Errors" -EventName Error -Action  $writeError | Out-Null
    }
}