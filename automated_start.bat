REM Automated start of the environment, MK I (2023-10-19)
start powershell -noexit "cd D:\Users\$env:UserName\Documents\GitHub\ps-ds-lakefront-us; D:\.venvrdm\scripts\activate.ps1; dbt deps"