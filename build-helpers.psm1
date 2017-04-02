$global:configFile = 'config.json'
$global:ahkCompiler = Join-Path $PSScriptRoot "AutoHotKey\Ahk2Exe.exe"
$global:defaultFilter = 'tools,extensions,*.ignore,*.nuspec,*.reg,*.xml"'
$global:excludeDirectoriesFromConfigurationRegEx = 'tools|\.git|\.vscode|^extensions|^tests|^plugins'
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

function Get-ConfigurationSetting {
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

function Get-Configuration {
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][String] $baseDir
    )

    $configuration = @{}
    $configuration[$baseDir] = Get-DirectoryConfiguration $baseDir

    # Get all the sub directories not matching the excluded directories filter
    $subDirectories = Get-ChildItem -Path $baseDir -Recurse -Directory `
        | Where-Object { $_.FullName -notmatch $global:excludeDirectoriesFromConfigurationRegEx } `
        | Select-Object Parent, Name, FullName

    foreach ($dir in $subDirectories) {
        # Get the configuration for each directory
        # but use the base directory as the default configuration,
        # if the current directory doesn't have it's own configuration
        $currentDir = $dir.FullName
        $configuration[$currentDir] = Get-DirectoryConfiguration $currentDir $configuration[$baseDir]
    }

    return $configuration
}

function Get-DirectoryConfiguration() {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][string] $directoryPath,
        [Parameter(Mandatory = $false, Position = 1)][hashtable] $baseConfiguration = @{}
    )

    $configFilePath = Join-Path $directoryPath $global:configFile

    if (Test-Path $configFilePath) {
        $configJson = (Get-Content $configFilePath -Raw) | ConvertFrom-Json

        $config.artifacts = Get-ConfigurationSetting $configJson 'artifacts' | Convert-ToFullPath -BasePath $directoryPath
        $config.remote.source = Get-ConfigurationSetting $configJson.remote 'source' | Convert-ToFullPath -BasePath $directoryPath
        $config.remote.apiKey = Get-ConfigurationSetting $configJson.remote 'apiKey'
        $config.remote.include = $global:config.remote.include + ((Get-ConfigurationSetting $configJson.remote 'include') -replace ' ', '' | Split-String ',')
        $config.local.source = Get-ConfigurationSetting $configJson.local 'source' | Convert-ToFullPath -BasePath $directoryPath
        $config.local.apiKey = Get-ConfigurationSetting $configJson.local 'apiKey'
        $config.local.include = $global:config.local.include + ((Get-ConfigurationSetting $configJson.local 'include') -replace ' ', '' | Split-String ',')

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
        Uri = $global:gitHubApiUrl
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

    $configuration = Get-Configuration $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $sourceConfiguration = Get-SourceConfiguration $configuration[$currentDir] $sourceType

        Invoke-ChocoPack $p.FullName $sourceConfiguration $configuration[$currentDir]['artifacts']
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

function Push-Packages {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local'
    )

    $configuration = Get-Configuration $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $packageDir = Split-Path -Parent $p.FullName
        $sourceConfiguration = Get-SourceConfiguration $configuration[$packageDir] $sourceType
        $source = $sourceConfiguration['source']
        $apiKey = $sourceConfiguration['apiKey']

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
