function Copy-FileContents {
    param(
        [string] $filePrefix,
        [string] $sourceFile,
        [string] $destinationDir = (Join-Path $env:UserProfile "Desktop\Settings"),
        [switch] $openFile = $true
    )

    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory $destinationDir | Out-Null
    }

    $fileName = (Get-Item $sourceFile).Name

    # Create the settings file in the the specififed directory
    $userFile = Join-Path $destinationDir "$filePrefix$fileName"
    if (-not (Test-Path $userFile)) {
        Set-Content $userFile (Get-Content $sourceFile)
    }

    if ($openFile) {
        # Open the created file
        & $userFile
    }
}