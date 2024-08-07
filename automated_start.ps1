# SCRIPT VERSION: 2.2
# SCRIPT UPDATED DATE: 2024.02.26
# SCRIPT CREATED DATE: 2023.10.19
# SCRIPT CREATED BY: Majed Charafeddine -- charawex
#
# SCRIPT GOAL: 
#   To automate the process of activating the virtual development environment
#
# HOW IT WORKS: 
#   1. Prompts users for information
#   2. Checks the path provided within the local environment
#   3. Changes directory to the path provided
#   4. Activates the virtual environment <venvrdm>
#   5. That's it!
#
# HOW TO USE:
#   1. Save script locally
#   2. Double click on the file
#   3. Follow prompts
#   4. That's it, enjoy!
#
# INPUTS:
#   1. project name
#
# OUTPUTS:
#   None
#
# EXECUTION EXAMPLE:
#   PS C:\> .\Untitled-1.ps1
#   Starting script...
#   What is the repo's name? (Press Enter for default :: <ps-ds-lakefront-us>): my-repo
#   Changed directory to D:\Users\username\Documents\GitHub\my-repo
#   <venvrdm> activated
#   Done
    
# Define the function that contains the embedded script
function EmbeddedScript {
    # Start of the embedded script
    Write-Host "Starting script..." -ForegroundColor Gray

    # Load the required assembly
    [void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') 
    
    # Prompt the user for the desired project name
    $desiredProject = [Microsoft.VisualBasic.Interaction]::InputBox("What is the repo's name?","Repository name","ps-ds-lakefront-us")

    # Set the desired path
    $desiredPath = "D:\Users\$env:UserName\Documents\GitHub\$desiredProject"

    # Check if the desired path exists
    if (Test-Path $desiredPath) {
        Set-Location -Path $desiredPath
        Write-Host "Changed directory to $desiredPath" -ForegroundColor DarkGreen
    } else {
        Write-Host "The path $desiredPath does not exist!" -ForegroundColor White -BackgroundColor Red
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

    # Tells the user that the script is done
    Write-Host "Done" -ForegroundColor Black -BackgroundColor Green

    # End of the embedded script
}
# End of the function

# Executes the function in a new PowerShell process (window)
Start-Process powershell -args "-noprofile", "-noexit", "-EncodedCommand",
  ([Convert]::ToBase64String(
     [Text.Encoding]::Unicode.GetBytes(
       (Get-Command -Type Function EmbeddedScript).Definition
     )
  ))

# End of file