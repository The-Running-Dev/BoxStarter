$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'TeamViewer'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'TeamViewer_Setup_en.exe'
  url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
  softwareName    = 'TeamViewer*'
  checksum        = '2110BFE2FC879D7C2ACB0205B0992BBE152B531505CF02025B72D7977C8FA8DA'
  checksumType    = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments