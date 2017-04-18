choco outdated -r | ForEach-Object {
    choco upgrade $($_.Split('|')[0])
}