Function Prompt
{
    $lastCommandSucceeded = $?
    $git_cmd = "git rev-parse --abbrev-ref HEAD"
    Invoke-Expression $git_cmd 2> $null | Tee-Object -Variable git_branch | Out-Null
    $git_branch_text = $None
    if ($git_branch -And -Not $git_branch.StartsWith($git_cmd))
    {
        $git_branch_text = "($git_branch) "
    }

    $regex = [regex]::Escape($HOME) + "(\\.*)*$"
    $path = $executionContext.SessionState.Path.CurrentLocation.Path -replace $regex, '~$1'
    $path = $path + " "

    Write-Host "PS " -NoNewline -ForegroundColor DarkBlue

    Write-Host $path -NoNewline -ForegroundColor Yellow

    if ($git_branch_text) {
        Write-Host $git_branch_text -NoNewline -ForegroundColor Cyan
    }

    if ($lastCommandSucceeded)
    {
        Write-Host ('>' * ($nestedPromptLevel + 1)) -NoNewline -ForegroundColor Green
    }
    else
    {
        Write-Host ('>' * ($nestedPromptLevel + 1)) -NoNewline -ForegroundColor Red
    }

    return " "
}

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
