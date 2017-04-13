function CleanUp([string] $isoPath) {
    if ($global:mustDismountIso) {
		Write-Verbose "CleanUp: Dismoutning '$($global:isoPath)'"
        Dismount-DiskImage -ImagePath $global:isoPath
    }
}