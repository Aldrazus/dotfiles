Import-Module Catppuccin

$Flavor = $Catppuccin['Mocha']

function prompt {
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

    $debugPrefix = if(Test-Path variable:/PSDebugContext) { "$($Flavor.Red.Foreground())[DBG]: " }
      else { '' }

    $($debugPrefix + "$($Flavor.Blue.Foreground())PS $($Flavor.Yellow.Foreground())" + $($path) + $(if ($git_branch_text) { "$($Flavor.Sapphire.Foreground())$git_branch_text" }) +
        $(if ($lastCommandSucceeded) {"$($Flavor.Green.Foreground())"} else {"$($Flavor.Red.Foreground())"}) + $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> ' + $($PSStyle.Reset))
}

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
