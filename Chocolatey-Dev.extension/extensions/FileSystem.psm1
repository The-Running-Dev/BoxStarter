function Add-Directory
{
    param(
        [string] $path
    )

    New-Item -ItemType Directory -Force -Path $path
}

function Clear-Directory
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [Parameter(ValueFromPipeline = $true)][string[]] $exclude
    )

    Remove-Item -Path $path\** -exclude $exclude -recurse -force
}

function Remove-ItemSafe {
    [Alias("rms")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}

function Remove-Directory
{
    param(
        [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}

function Resolve-PathSafe
{
    param(
        [string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
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

Export-ModuleMember -Function *

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

function UnZip {
    [Alias("uz")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $file
    )

    if ([System.IO.Path]::IsPathRooted($file)) {
        $filePath = $file
    }
    else {
        $filePath = Join-Path -Resolve . $file
    }

    $parentDirectory = Split-Path -Parent $filePath
    $destinationPath = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension($filePath))

    Get-ChocolateyUnzip -FileFullPath $filePath -Destination $destinationPath
}

function Zip {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $fileOrDirectory
    )

    if ([System.IO.Path]::IsPathRooted($fileOrDirectory)) {
        $fileSystemEntry = $fileOrDirectory
    }
    else {
        $fileSystemEntry = Join-Path -Resolve . $fileOrDirectory
    }

    $parentDirectory = Split-Path -Parent $fileSystemEntry

    if ([System.IO.File]::Exists($fileSystemEntry)) {
        $destinationPath = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension(($fileSystemEntry)))
    }
    else {
        $destinationPath = Split-Path -Leaf $fileSystemEntry
    }

    Write-Zip -level 9 -Quiet $fileSystemEntry "$($destinationPath).zip"
}

function Get-FromJson
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [string] $file
    )

    try {
    	$fileAsJson = Get-Content $file `
            -Raw -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue | ConvertFrom-JsonNewtonsoft `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
    	Write-Error -Message "The File $file Cannot Be Read!"
    }

    # Check the file
    if (!($fileAsJson)) {
    	Write-Error -Message "The File $file Cannot Be Read!"
    }

    return $fileAsJson
}

function Save-ToJson
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][object] $json,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $file
    )

    try {
    	$json | ConvertTo-JsonNewtonsoft > $file `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
    	Write-Error -Message "The File $file Cannot Be Saved!"
    }
}

function Expand-ToDirectory()
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $file,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}

function Copy-Files
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $source,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    Write-Host "Starting to Copy $source to $destination"

    $timer = [System.Diagnostics.Stopwatch]::StartNew()
    $success = $false
    do
    {
        try
        {
            Copy-Item -Recurse -Force $source $destination
            $success = $true
        }
        catch { }

        if(!$success)
        {
            Write-Host "Trying Again in 5 Seconds..."
            Start-Sleep -s 5
        }
    }
    while(!$success -and $timer.Elapsed -le (New-TimeSpan -Seconds $timeoutSeconds))

    $timer.Stop()

    if(!$success)
    {
        throw "Copy Failed - Giving Up."
    }

    Write-Host "Copy Sucesss!"
}

Export-ModuleMember -Function *