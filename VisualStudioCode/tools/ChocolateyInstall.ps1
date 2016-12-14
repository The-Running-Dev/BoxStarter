$ErrorActionPreference = 'Stop';

# Default values
$createDesktopIcon = $false
$createQuickLaunchIcon = $true
$addContextMenuFiles = $true
$addContextMenuFolders = $true
$addToPath = $true

$parameters = ParseParameters $env:chocolateyPackageParameters

if ($parameters.ContainsKey("nodesktopicon"))
{
    $createDesktopIcon = $false
}

if ($parameters.ContainsKey("noquicklaunchicon"))
{
    $createQuickLaunchIcon = $false
}

if ($parameters.ContainsKey("nocontextmenufiles"))
{
    $addContextMenuFiles = $false
}

if ($parameters.ContainsKey("nocontextmenufolders"))
{
    $addContextMenuFolders = $false
}

if ($parameters.ContainsKey("dontaddtopath"))
{
    $addToPath = $false
}

$mergeTasks = "!runCode"

if ($createDesktopIcon)
{
    $mergeTasks = $mergeTasks + ",desktopicon"
}

if ($createQuickLaunchIcon)
{
    $mergeTasks = $mergeTasks + ",quicklaunchicon"
}

if ($addContextMenuFiles)
{
    $mergeTasks = $mergeTasks + ",addcontextmenufiles"
}

if ($addContextMenuFolders)
{
    $mergeTasks = $mergeTasks + ",addcontextmenufolders"
}

if ($addToPath)
{
    $mergeTasks = $mergeTasks + ",addtopath"
}

$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'VSCodeSetup-1.8.0.exe'
  url             = 'https://go.microsoft.com/fwlink/?LinkID=623230'
  softwareName    = 'VisualStudioCode*'
  checksum        = 'F39F5506301552662A705D141D5FF0BE33A9499BE3A17FAD73884555CEB6EDCD'
  checksumType    = 'sha256'
  silentArgs      = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs