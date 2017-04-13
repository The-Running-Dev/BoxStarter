function Get-ProgramFilesDirectory() {
    $programFiles = @{$true = "$env:programFiles (x86)"; $false = $env:programFiles}[64 -Match (get-processorBits)]

    return $programFiles
}