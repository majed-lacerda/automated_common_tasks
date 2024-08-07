# SCRIPT CREATE DATE: 2024.01.04
# SCRIPT CREATED BY: Majed Charafeddine -- charawex
# SCRIPT VERSION: 1
#
# SCRIPT GOAL: 
#   To antecipate the impacts of the development on CICD pipelines.
#
# HOW SCRIPT WORKS: 
#   1. Prompts users for information
#   2. Checks the provided information within the local environment
#   3. Changes directory to the path provided
#   4. Activates the virtual environment <venvrdm>
#   5. Executes the script 
#   6. That's it!
#
# HOW TO USE:
#   1. Save the main script locally
#   2. Save this script locally
#   3. Double click on this file script
#   4. Follow prompts
#   5. That's it, enjoy!
#
# INPUTS
#   1. Script path
#   2. Script file name
#   3. Project name
#
# OUTPUTS
#   None
#
# EXECUTION EXAMPLE
#   PS C:\> EmbeddedScript3
#   Starting script...
#   What is the path where the script is stored? (Press Enter for default :: 'D:\Users\'$'User\Documents\')
#   What is the script file name? (Press Enter for default :: <venvsetup.ps1>)
#   What is the project name? (Press Enter for default :: <ps-ds-lakefront-us>)
#   Changed directory to D:\Users\username\Documents\GitHub\ps-ds-lakefront-us
#   The script has been found.
#   <venvrdm> activated
#   ** runs the script with its prompts, inputs and outputs **
#   Completed


function EmbeddedScript3 {
    # Start of the embedded script
    Write-Host "Starting script..." -ForegroundColor Gray
    
    # Prompt the user for the script path
    $choosenScriptPath = Read-Host "What is the path where the script is stored? (Press Enter for default :: 'D:\Users\'$'User\Documents\Scripts\')"
    if ([string]::IsNullOrWhiteSpace($choosenScriptPath)) {
        $ChoosenScriptPath = "D:\Users\$env:UserName\Documents\Scripts\"  # Default script path
    }
    
    # Prompt the user for the script file name
    $choosenScriptFileName = Read-Host "What is the script file name? (Press Enter for default :: <cicd_impact.ps1>)"
    if ([string]::IsNullOrWhiteSpace($choosenScriptFileName)) {
        $ChoosenScriptFileName = "cicd_impact.ps1"  # Default script filename
    }
    
    # Prompt the user for the project name
    $choosenProject = Read-Host "What is the project name? (Press Enter for default :: <ps-ds-lakefront-us>)"
    if ([string]::IsNullOrWhiteSpace($choosenProject)) {
        $choosenProject = "ps-ds-lakefront-us"  # Default project name
    }
    
    # Set the script path
    $choosenProjectPath = "D:\Users\$env:UserName\Documents\GitHub\$choosenProject"
    
    # Check if the project path exists
    if (Test-Path $choosenProjectPath) {
        Set-Location -Path $choosenProjectPath
        Write-Host "Changed directory to $choosenProjectPath" -ForegroundColor DarkGreen
    } else {
        Write-Host "The project directory $choosenProjectPath does not exist!" -ForegroundColor White -BackgroundColor Red
        return
    }
    
    $scriptPath = $ChoosenScriptPath + $ChoosenScriptFileName
    
    # Check if the script path exists
    if (Test-Path $scriptPath -PathType Leaf) {
        Write-Host "The script has been found." -ForegroundColor DarkGreen
    } else {
        Write-Host "The script $ScriptPath does not exist!" -ForegroundColor White -BackgroundColor Red
        return
    }
    
    # Activate the virtual environment
    $venvPath = "D:\.venvrdm\scripts\activate.ps1"
    if (Test-Path $venvPath) {
        & $venvPath
        Write-Host "<venvrdm> activated" -ForegroundColor Green
    } else {
        Write-Host "The virtual environment script $venvPath does not exist!" -ForegroundColor White -BackgroundColor Red
        return
    }
    
    & $scriptPath
    
    # Tells the user that the script is done
    Write-Host "Completed" -ForegroundColor Black -BackgroundColor Green
    
    # End of the embedded script
    }
    # End of the function
    
    # Executes the function in a new PowerShell process (window)
    Start-Process powershell -args "-noprofile", "-noexit", "-EncodedCommand",
    ([Convert]::ToBase64String(
        [Text.Encoding]::Unicode.GetBytes(
        (Get-Command -Type Function EmbeddedScript3).Definition
        )
    ))
    
    # End of file