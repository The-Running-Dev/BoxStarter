function Invoke-GitPush {
    $branchName = git rev-parse --abbrev-ref HEAD

    git push --set-upstream origin $branchName
}