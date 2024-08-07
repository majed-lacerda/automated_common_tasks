# SCRIPT VERSION: 1.0
# SCRIPT UPDATED DATE: 2024.03.04
# SCRIPT CREATED DATE: 2024.03.04
# SCRIPT CREATED BY: Majed Charafeddine -- charawex
#
# SCRIPT GOAL: 
#   To automate and facilitate the development process by reducing the steps required for day-to-day tasks
#
# HOW IT WORKS: 
#   1. Prompts user for information
#   2. Checks the provided information within the local environment
#   3. Changes directory to the path provided
#   4. Activates the virtual environment <venvrdm>
#   5. ** If applicable / selected ** Executes the reference script
#   6. That's it!
#
# HOW TO USE:
#   1. Save the reference script locally (check documentation for more details)
#   2. Save this script locally
#   3. Double click on this file script to run it
#   4. Choose what you want to do
#   5. Follow prompts
#   6. ** wait for the script to finish **
#   7. That's it, enjoy!
#
# INPUTS:
#   This script has a few inputs, but the reference scripts (if applicable) have their own. For documentation purposes, the inputs for this script only are:
#   1. Task selection
#   2. Project name
#   3. Reference script path
#   4. Reference script filename
#   5. Domain name (if applicable)
#
# OUTPUTS:
#   This script doesn't have outputs by itself, but the reference ones can -- the CI/CD imitation one does have a few options, and, if selected, it can output:
#   1. Impact report
#   2. dbt execution logs
#
# EXECUTION EXAMPLE:
#    1. Double click on the script file to start
#    2. Starting script...
#    3. Choose what to do:
#        1. Activate the virtual environment;
#        2. Set up the virtual development environment;
#        3. Simulate the CI/CD process.
#        4. Run << dbt build >>;
#        5. Run << sqlfluff fix >> and << pytest >>.
#       Type 1, 2, 3, 4 or 5.
#        > 2
#    4. What is the project directory?
#        > ps-ds-lakefront-us
#    5. Changed directory to << D:\Users\username\Documents\GitHub\ps-ds-lakefront-us >>
#    6. Virtual environment << venvrdm >> has been activated
#    7. What is the path where the reference script is located?
#        > D:\Users\username\Documents\Scripts\
#    8. What is the reference script filename?
#        > venvsetup.ps1
#    9. The reference script has been found.
#    10. Starting reference script...
#    ** runs the reference script with the inputs provided and generates its outputs **
#    11. Reference script finished.
#    12. Done.

# Start of function
function AutomatedScript {
    #Tells user that script is starting
    Write-Host "Starting script..." -ForegroundColor Gray
    
    # Load required assembly
    [void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

    # Prompt user for what to do
    $choosenTask = [Microsoft.VisualBasic.Interaction]::InputBox("Choose what to do :: type '1' to activate the virtual environment; '2' to set up the virtual development environment; '3' to run << dbt build >>; '4' to run << sqlfluff fix >> and << pytest >>; '5' to simulate the CI/CD process.","Choose a task","1")

    # Subfunction that activates the virtual environment
    function venvactivate {
        # Prompt user for project name
        $choosenProject = [Microsoft.VisualBasic.Interaction]::InputBox("What is the project directory?","Project name","ps-ds-lakefront-us")

        # Set project path
        $choosenPath = "D:\Users\$env:UserName\Documents\GitHub\$choosenProject\"

        # Check if project path exists
        if (Test-Path $choosenPath) {
            Set-Location -Path $choosenPath
            Write-Host "Changed directory to << $choosenPath >>" -ForegroundColor DarkGreen
        } else {
            Write-Host "The project directory hasn't been found! Please check the provided path: << $choosenPath >>" -ForegroundColor White -BackgroundColor Red
            return
        }

        # Activate virtual environment
        $venvPath = "D:\.venvrdm\scripts\activate.ps1"
        if (Test-Path $venvPath) {
            & $venvPath
            Write-Host "Virtual environment << venvrdm >> has been activated" -ForegroundColor Green
        } else {
            Write-Host "The virtual environment script hasn't been found! Please check the provided path: << $venvPath >>" -ForegroundColor White -BackgroundColor Red
            return
        }
    }

    # Subfunction that prompts user for reference script path and filename
    function refscript($scriptFileNameSug) {
        # Prompt user for reference script path
        $choosenScriptPath = [Microsoft.VisualBasic.Interaction]::InputBox("What is the path where the reference script is located?","Reference script path","D:\Users\$env:UserName\Documents\Scripts\")
        
        # Prompt user for reference script filename
        $choosenScriptFileName = [Microsoft.VisualBasic.Interaction]::InputBox("What is the reference script filename?","Reference script filename",$scriptFileNameSug)
        
        # Set reference script full path
        $scriptPath = $choosenScriptPath + $choosenScriptFileName
    
        # Check if reference script exists
        if (Test-Path $scriptPath -PathType Leaf) {
            Write-Host "The reference script has been found." -ForegroundColor DarkGreen
        } else {
            Write-Host "The reference script hasn't been found! Please check the provided path: << $scriptPath >>" -ForegroundColor White -BackgroundColor Red
            return
        }

        # Tells user that reference script is starting
        Write-Host "Starting reference script..." -ForegroundColor Magenta
        
        # Starts reference script
        & $scriptPath

        # Tells user that reference script ended
        Write-Host "Reference script finished." -ForegroundColor Magenta
    }
    
    # Script number one, that activates the virtual environment
    if ($choosenTask -eq '1')
    {
        # Calls the subfunction to activate the virtual environment
        venvactivate
        
        # Tells user that script is done
        Write-Host "Done." -ForegroundColor Black -BackgroundColor Green
    }
    
    # Script number two, that sets up the virtual development environment
    elseif ($choosenTask -eq '2')
    {
        # Calls the subfunction to activate the virtual environment
        venvactivate

        # Suggests a filename for the reference script
        $scriptFileNameSug = "venvsetup.ps1"

        # Calls the subfunction to prompts user for reference script path and filename
        refscript $scriptFileNameSug

        # Tells user that script is done
        Write-Host "Done." -ForegroundColor Black -BackgroundColor Green
    }

    # Script number three, that runs << dbt build >>
    elseif ($choosenTask -eq '3')
    {
        # Calls the subfunction to activate the virtual environment
        venvactivate

        # Get the current branch name
        $currentBranchName = git rev-parse --abbrev-ref HEAD

        # Get the clone name; replace all non-word characters with an underscore
        $clone_name = 'clone_' + $currentBranchName.ToUpper() -replace '\W','_'

        # Prompt user for domain name
        $DomainName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the domain of the project. Found in the center of a file (somefile_stage__DOMAIN__project) (Example: risk). Use * for all domains.","DomainName","*")

        # Get all changed files, from the current branch to the main one, inside selected project
        $domain_project_files = git --no-pager diff --name-only --diff-filter=d origin/main..head  | where-object { $_ -ilike "*$DomainName*$choosenProject*" -and (($_ -like '*.sql') -or ($_ -ilike '*.yml')) -and ($_ -ne 'dbt_project.yml') } 

        # Get files to process using dbt; remove file extension and add << +1 >> at the end
        $files_to_process = $domain_project_files | ForEach-Object { ((($_  -split '/|\\')[-1] -replace '\.[^.]+$') + "+1") }   | Select-Object -Unique | Where-Object { $_ -ne $null }
        
        # Clean dbt cache
        dbt clean

        # Run dbt build for previously selected files only
        dbt --cache-selected-only build --threads 10 --target $clone_name --select $files_to_process --exclude tag:known_fail_or_warn

        # Tells user that script is done
        Write-Host "Done." -ForegroundColor Black -BackgroundColor Green
    }

    # Script number four, that runs << sqlfluff fix >> and << pytest >>
    elseif ($choosenTask -eq '4')
    {
        # Calls the subfunction to activate the virtual environment
        venvactivate

        # Prompt user for domain name
        $DomainName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the domain of the project. Found in the center of a file (somefile_stage__DOMAIN__project) (Example: risk). Use * for all domains.","DomainName","*")

        # Get all changed files, from the current branch to the main one, inside selected project
        $domain_project_files = git --no-pager diff --name-only --diff-filter=d origin/main..head  | where-object { $_ -ilike "*$DomainName*$choosenProject*" -and (($_ -like '*.sql') -or ($_ -ilike '*.yml')) -and ($_ -ne 'dbt_project.yml') } 

        # Get files to process through sqlfluff; remove file extension and add << +1 >> at the end
        $SQLFluffFiles = $domain_project_files | ForEach-Object { $_ -replace '\.[^.]+$' + '+1' } | Select-Object -Unique

        # Run << sqlfluff fix >> for previously selected files only
        sqlfluff fix $SQLFluffFiles --force --processes 25

        # Run << pytest >> for all tests
        pytest

        # Tells user that script is done
        Write-Host "Done." -ForegroundColor Black -BackgroundColor Green
    }
    
    # Script number five, that simulates the CI/CD process
    elseif ($choosenTask -eq '5')
    {
        # Calls the subfunction to activate the virtual environment
        venvactivate

        # Suggests a filename for the reference script
        $scriptFileNameSug = "cicd_imitation.ps1"

        # Calls the subfunction to prompts user for reference script path and filename
        refscript $scriptFileNameSug

        # Tells user that script is done
        Write-Host "Done." -ForegroundColor Black -BackgroundColor Green
    }

    # Condition activated if user press << Cancel >> on the prompt
    elseif ($choosenTask -eq '')
    {
        Write-Host "Cancelled." -ForegroundColor Yellow
    }

    # Condition activated if user press << Ok >> on the prompt without choosing an available option
    elseif ($null -ne $choosenTask)
    {
        Write-Host "<< $choosenTask >> is not an available option!" -ForegroundColor Red
    }

    # Condition activated if there is something not anticipated, like an error
    else
    {
        Write-Host "ERROR!" -ForegroundColor White -BackgroundColor Red
    }
}
# End of function

# Executes function in a new PowerShell process (new window)
Start-Process powershell -args "-noprofile", "-noexit", "-EncodedCommand",
([Convert]::ToBase64String(
    [Text.Encoding]::Unicode.GetBytes(
    (Get-Command -Type Function AutomatedScript).Definition
    )
))

# End of file