param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $fileName32 = 'Pscx-3.2.0.msi'
    $fileType = 'msi'
    $version = '3.2.0'
    $url = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pscx&DownloadId=923562&FileTime=130585918034470000&Build=21050'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = $url;
        Version = $version;
        FileName32 = $fileName32;
        FileType = $FileType
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')