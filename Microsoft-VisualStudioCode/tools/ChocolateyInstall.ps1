$createDesktopIcon      = $false
$createQuickLaunchIcon  = $true
$addContextMenuFiles    = $true
$addContextMenuFolders  = $true
$addToPath              = $true

$parameters = Get-Parameters $env:chocolateyPackageParameters

if ($parameters.ContainsKey("nodesktopicon")) {
    $createDesktopIcon = $false
}

if ($parameters.ContainsKey("noquicklaunchicon")) {
    $createQuickLaunchIcon = $false
}

if ($parameters.ContainsKey("nocontextmenufiles")) {
    $addContextMenuFiles = $false
}

if ($parameters.ContainsKey("nocontextmenufolders")) {
    $addContextMenuFolders = $false
}

if ($parameters.ContainsKey("dontaddtopath")) {
    $addToPath = $false
}

$mergeTasks = "!runCode"

if ($createDesktopIcon) {
    $mergeTasks = $mergeTasks + ",desktopicon"
}

if ($createQuickLaunchIcon) {
    $mergeTasks = $mergeTasks + ",quicklaunchicon"
}

if ($addContextMenuFiles) {
    $mergeTasks = $mergeTasks + ",addcontextmenufiles"
}

if ($addContextMenuFolders) {
    $mergeTasks = $mergeTasks + ",addcontextmenufolders"
}

if ($addToPath) {
    $mergeTasks = $mergeTasks + ",addtopath"
}

$arguments  = @{
    url         = 'https://az764295.vo.msecnd.net/stable/787b31c0474e6165390b5a5989c9619e3e16f953/VSCodeSetup-ia32-1.16.0.exe'
    checksum    = '7E409350F4045A630A7616601C28B95523AF8D6CCFC7EB4A31D5DCFC26498716'
    silentArgs  = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
}

Install-Package $arguments
