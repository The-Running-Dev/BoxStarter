$arguments      = @{
    url         = 'https://download.microsoft.com/download/A/6/3/A637DB94-8BA8-43BB-BA59-A7CF3420CD90/vs_BuildTools.exe'
    checksum    = 'F2644F383302FB1E79B8644982E18D3AEDA660927748795FBAFD53A3CC5D12DD'
    silentArgs  = '--quiet --norestart --add Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-Package $arguments
