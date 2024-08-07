# SCRIPT VERSION: 1.1
# SCRIPT UPDATED DATE: 2024.02.26
# SCRIPT CREATED DATE: 2024.01.04
# SCRIPT CREATED BY: Majed Charafeddine -- charawex
#
# SCRIPT GOAL: 
#   To automate the process of simulating the impacts of the development on CICD pipelines
#
# HOW IT WORKS: 
#   1. Prompts user for information
#   2. Checks the provided information within the local environment
#   3. Changes directory to the path provided
#   4. Activates the virtual environment <venvrdm>
#   5. Executes the script 
#   6. That's it!
#
# HOW TO USE:
#   1. Save the reference script locally
#   2. Save this script locally
#   3. Double click on this file script to run it
#   4. Follow prompts
#   5. That's it, enjoy!
#
# INPUTS:
#   1. Script path
#   2. Script filename
#   3. Project name
#
# OUTPUTS:
#   Depends on the selected options on the reference script; it can output:
#   1. Impact report
#   2. dbt execution logs
#
# EXECUTION EXAMPLE:
#   PS C:\> EmbeddedScript3
#   Starting script...
#   What is the path where the script is located?
#   What is the script filename?
#   What is the project name?
#   Changed directory to D:\Users\username\Documents\GitHub\ps-ds-lakefront-us
#   The script has been found.
#   <venvrdm> activated
#   ** runs the script with its prompts, inputs and outputs **
#   Completed


function EmbeddedScript3 {
    # Start of the embedded script
    Write-Host "Starting script..." -ForegroundColor Gray

    # Load the required assembly
    [void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
    
    # Prompt the user for the script path
    $choosenScriptPath = [Microsoft.VisualBasic.Interaction]::InputBox("What is the path where the script is located?","Script path","D:\Users\$env:UserName\Documents\Scripts\")
    
    # Prompt the user for the script filename
    $choosenScriptFileName = [Microsoft.VisualBasic.Interaction]::InputBox("What is the script filename?","Script filename","cicd_impact.ps1")
    
    # Prompt the user for the project name
    $choosenProject = [Microsoft.VisualBasic.Interaction]::InputBox("What is the project name?","Project name","ps-ds-lakefront-us")
    
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