function Write-Message {
    param([string] $message)

    if ($env:ChocoDebug) {
        Write-Host $message
    } else {
        Write-Verbose $message
    }
}