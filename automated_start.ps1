# SCRIPT CREATE DATE: 2023.10.19
# SCRIPT UPDATE DATE: 2023.12.28
# SCRIPT CREATED BY: Majed Charafeddine -- charawex
# SCRIPT VERSION: 2.0
#
# SCRIPT GOAL: 
#  To standardize and automate the administrative process of activating the virtual development environment.
#
# HOW SCRIPT WORKS: 
#  1. Prompts users for information
#  2. Checks the path provided within the local environment
#  3. Changes directory to the path provided
#  4. Activates the virtual environment <venvrdm>
#  5. Prompts users if they want to run the <dbt deps> command
#  6. Runs the <dbt deps> command if the user chooses to do so
#  7. That's it!
#
# HOW TO USE:
#  1. Save script locally
#  2. Double click on the file
#  3. Follow prompts
#  4. That's it, enjoy!

# Define the function that contains the embedded script
function EmbeddedScript {
    # Start of the embedded script
    Write-Host "Starting script..." -ForegroundColor Gray
    
    # Prompt the user for the desired project name
    $desiredProject = Read-Host "What is the repo name? (Press Enter for default :: <ps-ds-lakefront-us>)"
    if ([string]::IsNullOrWhiteSpace($desiredProject)) {
        $desiredProject = "ps-ds-lakefront-us"  # Default project name
    }

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

    # Prompt the user to run the "dbt deps" command
    $userInput = Read-Host "Do you want to run the <dbt deps> command? (yes/no)"
    if ($userInput -eq "yes") {
        # Run the "dbt deps" command
        Write-Host "Running <dbt deps>..." -ForegroundColor Yellow
        dbt deps | Out-Null
    } else {
        Write-Host "<dbt deps> skipped" -ForegroundColor Gray
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