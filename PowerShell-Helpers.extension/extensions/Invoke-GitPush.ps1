function Invoke-GitPush {
    $branch = git rev-parse --abbrev-ref HEAD

    git push --set-upstream origin $branch
}