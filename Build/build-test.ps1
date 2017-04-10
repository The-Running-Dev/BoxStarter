$env:ModuleUnderTest = ''
$baseDir = $PSScriptRoot
$filter = "*.*"
$testsFilter = "*.Tests.ps1"
$watchScript = $MyInvocation.MyCommand.Name
$eventName = 'TestFilesChanged'
$excludeTests = @(
    'FileHelpers'
    'RegistryHelpers'
    'WindowsFeatures'
)

$testFiles = Get-ChildItem -Path $baseDir -Filter $testsFilter ` -Recurse | Select-Object FullName

foreach ($f in $testFiles) {
    $isExcluded = $(($excludeTests | Where-Object { (Split-Path $f.FullName -Leaf) -match $_  }))

    if (!$isExcluded) {
        Invoke-Pester $f.FullName
    }
}

$watcher = New-Object IO.FileSystemWatcher $baseDir, $filter -Property @{
    IncludeSubdirectories = $true
    NotifyFilter = [IO.NotifyFilters]'LastWrite'
}

$messageData = @{
    'watcher' = $watcher
    'fileHashes' = @{}
    'baseDir' = $baseDir
    'watchScript' = $watchScript
    'excludeTests' = $excludeTests
    'testsFilter' = $testsFilter
}

$onModified = Register-ObjectEvent $watcher Changed -SourceIdentifier $eventName -Verbose -MessageData $messageData -Action {
    write-host $($Event.SourceEventArgs | Out-String)

    $watcher = $Event.MessageData['watcher']
    $fileHashes = $Event.MessageData['fileHashes']
    $baseDir = $Event.MessageData['baseDir']
    $watchScript = $Event.MessageData['watchScript']
    $excludeTests = $Event.MessageData['excludeTests']
    $testsFilter = $Event.MessageData['testsFilter']

    $path = $Event.SourceEventArgs.FullPath
    $name = $Event.SourceEventArgs.Name
    $fileName = [System.IO.Path]::GetFileName($name)

    $extension = $([System.IO.Path]::GetExtension($path).ToLower())
    $testsFile = $Event.SourceEventArgs.FullPath
    $isSelf = $($fileName -eq $watchScript)
    $isDirectory = $([System.IO.Directory]::Exists($path))
    $isTestFile = $($fileName -match '.*\.tests.ps1$')
    $isModule = $($fileName -match '.*\.psm1$')

    if ($isDirectory -or (!$isSelf -and !$isTestFile -and !$isModule)) {
        return
    }

    if ($isModule) {
        $testsFile = Join-Path $baseDir ($name -replace ('\.\w+$', '.Tests.ps1'))
    }

    if ($isTestFile -or $isModule) {
        $hashExists = $fileHashes.ContainsKey($path)
        $hash = (Get-FileHash $path).Hash
        $existingHash = $($fileHashes[$path])

        if (!$hashExists -or $hash -ne $existingHash) {
            if ($isModule) {
                $fileOpened = $false

                while (!$fileOpened) {
                    try {
                        [IO.File]::OpenWrite($path).close();
                        $fileOpened = $true
                    }
                    catch {
                    }

                    Start-Sleep 2
                }

                Write-Host "Importing Module: $path"
                Remove-Module $path -Force
                Import-Module $path -Force
            }
            elseif ($env:ModuleUnderTest) {
                Write-Host "Importing Module: $($env:ModuleUnderTest)"
                Remove-Module $env:ModuleUnderTest -Force
                Import-Module $env:ModuleUnderTest -Force
            }

            try {
                $isExcluded = $(($excludeTests | Where-Object { $fileName -match $_ }).Length -gt 0)

                if (!$isExcluded) {
                    if ($isModule) {
                        $testsDependantOnModule = Get-ChildItem -Path $baseDir `
                            -Filter $testsFilter `
                            -Recurse `
                            | Select-String $fileName | Select-Object -Unique Path

                        foreach ($f in $testsDependantOnModule) {
                            $isExcluded = $(($excludeTests | Where-Object { (Split-Path $f.Path -Leaf) -match $_  }))

                            if (!$isExcluded) {
                                Write-Host "Running Tests: $($f.Path)"
                                Invoke-Pester $f.Path
                            }
                        }
                    }

                    if (Test-Path $testsFile) {
                        Write-Host "Running Tests: $testsFile"
                        Invoke-Pester $testsFile
                    }
                }
            }
            catch {
            }

            $fileHashes[$path] = (Get-FileHash $path).Hash
        }
    }
    elseif ($isSelf) {
        <#
        Start-Sleep 5
        Start-Process Powershell -ArgumentList '-NoExit ', "& $(Join-Path $baseDir $watchScript)"
        [Environment]::Exit(0)
        #>
    }
}

while ($true) {
    if ($Host.UI.RawUI.KeyAvailable -and (3 -eq [int]$Host.UI.RawUI.ReadKey("AllowCtrlC,IncludeKeyUp,NoEcho").Character)) {
        Unregister-Event $eventName

        break
    }
}