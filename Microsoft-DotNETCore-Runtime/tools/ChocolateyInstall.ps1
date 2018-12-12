$arguments          = @{
    url             = 'https://download.visualstudio.microsoft.com/download/pr/48adfc75-bce7-4621-ae7a-5f3c4cf4fc1f/9a8e07173697581a6ada4bf04c845a05/dotnet-hosting-2.2.0-win.exe'
    checksum        = '425D727E7FF2DFC130DA3ED060A020A8DE4590258D4D81303E5876713C4C39E4'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
