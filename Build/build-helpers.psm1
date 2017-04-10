$global:configFile = 'config.json'
$global:ahkCompiler = Join-Path $PSScriptRoot "AutoHotKey\Ahk2Exe.exe"
$global:defaultFilter = 'tools,extensions,*.ignore,*.nuspec,*.reg,*.xml"'
$global:excludeDirectoriesFromConfigurationRegEx = '\.git|\.vscode|artifacts|extensions|plugins|tools|tests'
$global:gitHubApiUrl = 'https://api.github.com/repos/$repository/releases/latest'
$global:config = @{
    artifacts = ''
    local = @{
        source = ''
        apiKey = ''
        include = $global:defaultFilter | Split-String ','
    }
    remote = @{
        source = ''
        apiKey = ''
        include = $global:defaultFilter | Split-String ','
    }
}

function Get-ConfigSetting {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $true)][PSCustomObject] $config,
        [parameter(Mandatory = $true)][string] $key,
        [parameter(Mandatory = $false)][string] $defaultValue = $null
    )

    if ($config.$key) {
        return @{$true = $config.$key; $false = $defaultValue}[$config.$key -ne '']
    }

    return $defaultValue
}

function Convert-ToFullPath {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $basePath
    )

    if ([System.IO.Path]::IsPathRooted($path) -or $path.StartsWith('http')) {
        return $path
    }

    return Join-Path -Resolve $basePath $path
}

function ConvertTo-Boolean {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $value
    )

    if ('1,true,yes' -Match $value) {
        return $true
    }

    return $false;
}

function Get-DirectoryConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $path,
        [Parameter(Mandatory = $false, Position = 1)][Hashtable] $baseConfig = $global:config
    )

    $configFile = Join-Path $path $global:configFile

    if (!(Test-Path $configFile)) {
        $configFile = Join-Path (Split-Path -Parent $path) $global:configFile
    }

    if (Test-Path $configFile) {
        $dir = Split-Path -Parent $configFile
        $configJson = (Get-Content $configFile -Raw) | ConvertFrom-Json

        $config = $global:config
        $config.artifacts = Get-ConfigSetting $configJson 'artifacts' | Convert-ToFullPath -BasePath $dir

        if ($configJson.remote) {
            $config.remote.source = Get-ConfigSetting $configJson.remote 'source' | Convert-ToFullPath -BasePath $dir
            $config.remote.apiKey = Get-ConfigSetting $configJson.remote 'apiKey'
            $config.remote.include = $global:config.remote.include + ((Get-ConfigSetting $configJson.remote 'include') -replace ' ', '' | Split-String ',')
        }

        if ($configJson.local) {
            $config.local.source = Get-ConfigSetting $configJson.local 'source' | Convert-ToFullPath -BasePath $dir
            $config.local.apiKey = Get-ConfigSetting $configJson.local 'apiKey'
            $config.local.include = $global:config.local.include + ((Get-ConfigSetting $configJson.local 'include') -replace ' ', '' | Split-String ',')
        }

        return $config
    }

    return $baseConfig
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
        Uri = $ExecutionContext.InvokeCommand.ExpandString($global:gitHubApiUrl)
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
            if ($url -match $downloadUrlRegEx) {
                $release.DownloadUrl = $url
            }
        }
    }

    $servicePoint.CloseConnectionGroup('') | Out-Null

    return $release
}

function Get-Packages {
    param (
        [parameter(Mandatory = $true)][string] $baseDir,
        [parameter(Mandatory = $false)][string] $searchTerm = '',
        [parameter(Mandatory = $false)][string] $filter = ''
    )

    if (!$searchTerm) {
        # Get all packages in the base directory and sub directories
        $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
    }
    else {
        $packages = @()

        foreach ($p in $searchTerm.split(' ')) {
            $packages += Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$p.*"}
        }
    }

    return $packages
}

function Get-LatestVersion([string] $url, [string] $versionRegEx) {
    return $(Get-Version (Get-RedirectUrl $url) $versionRegEx)
}

function Get-RedirectUrl([string] $url) {
    return ((Get-WebURL -Url $url).ResponseUri).AbsoluteUri
}

function Get-SourceConfig() {
    param (
        [Parameter(Mandatory = $true, Position = 0)][Hashtable] $config,
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    if ($sourceType -match 'remote') {
        return $config.remote
    }

    return $config.local
}

function Get-Version([string] $url, [string] $versionRegEx) {
    return $($url -replace $versionRegEx, '$1')
}

function Invoke-AutoHotKey {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $true, Position = 2)][object] $files = @{}
    )

    if (!$files) {
        $files = Get-ChildItem -Path $baseDir -Filter *.ahk -Recurse
    }

    foreach ($f in $files) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}

function Invoke-Pack {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = Get-SourceConfig $config $sourceType

        Invoke-ChocoPack $p.FullName $sourceConfig $config.artifacts
    }
}

function Invoke-ChocoPack {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $nuSpec,
        [Parameter(Mandatory = $true, Position = 1)][ValidateNotNullOrEmpty()][Hashtable] $config,
        [Parameter(Mandatory = $true, Position = 2)][ValidateNotNullOrEmpty()][string] $outputPath
    )

    $packageId = (Split-Path -Leaf $nuSpec) -replace '.nuspec', ''
    $packageDir = Split-Path -Parent $nuSpec
    $tempDir = Join-Path $env:Temp $packageId

    if (![System.IO.Directory]::Exists($outputPath)) {
        New-Item -Path $outputPath -ItemType Directory
    }

    if (Test-Path $tempDir) {
        Remove-Item $tempDir -Force -Recurse
    }

    # Create a temporaty directory for the package
    # and move all the extra files from the package directory
    # so they don't become part of the package
    New-Item -ItemType Directory $tempDir -Force | Out-Null
    $extraFiles = Get-ChildItem -Path $packageDir -Exclude $config['include']
    foreach ($f in $extraFiles) {
        Move-Item $f.FullName $tempDir
    }

    # Find and compile all .ahk files
    $ahkFiles = Get-ChildItem -Path $packageDir -Filter *.ahk -Recurse
    if ($ahkFiles) {
        Invoke-AutoHotKey $packageDir $ahkFiles
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

function Invoke-Push {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName

        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = Get-SourceConfig $config $sourceType

        $source = $sourceConfig['source']
        $apiKey = $sourceConfig['apiKey']

        $packageAritifactRegEx = $($p.Name -replace '(.*?).nuspec', '$1.[0-9\.]+\.nupkg')
        Get-ChildItem -Path $baseDir -Recurse -File `
            | Where-Object { $_.Name -match $packageAritifactRegEx } `
            | Select-Object FullName `
            | ForEach-Object { choco push $_.FullName -s $source -k="$apiKey" }
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

Export-ModuleMember *