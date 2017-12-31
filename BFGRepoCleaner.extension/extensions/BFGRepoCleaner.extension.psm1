function bfg {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)][string] $command,
        [Parameter(Position = 1)][string] $commandArgs
    )

    $file = Get-ChildItem $PSScriptRoot *.jar | Select-Object -First 1

    java -jar "$($file.FullName)" $command $commandArgs
}