function Invoke-Commands {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $configFile,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $commandTemplate
    )

    try {
        foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
            $commmand = $commandTemplate.replace("##token##", $line)

            Write-Message "Running: $commmand"

            Invoke-Expression $commmand
        }
    }
    catch {
        Write-Message "Invoke-Commands Failed: $($_.Exception.Message)"
    }
}