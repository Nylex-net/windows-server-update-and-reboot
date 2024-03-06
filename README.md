# Windows Server Update and Reboot

This repository is for all of the code involved with setting up a scheduled update and reboot for windows servers.

## Prerequisites

- Save a copy of `MainTask.ps1` into your File Explorer.
- Make sure your execution policy allows you to run PowerShell scripts from the PowerShell command line.
  - Check your policy by running `Get-ExecutionPolicy` in PowerShell.
  - I suggest the policy to be set to `RemoteSigned`.  To change your execution policy, run PowerShell in administrator mode and run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`. Then respond to the prompt with `Y` or `A`.

## Create the Schedule

1. Open Task Scheduler.
2. Right Click `Task Scheduler Library` and click `Create Basic Task`.
3. Give your task a meaningful name, such as "Update and Restart".  Add a description if you desire.
4. Click `Next` and select how often you want your script to run. In this example, I'm choosing `Monthly`.
5. Click `Next`. If you chose `Daily`, `Weekly`, `Monthly`, or `One time`, select the day and time you want your script to start.
    1. Since I chose to run my task monthly, I'll also need to select `<Select all months>` to run every month.
    2. Select a day(s) of the month to run the script. I'll just choose the first of the month.
6. Click `Next` and select `Start a program`.
7. Click `Next`.  For `Program/script`, select the powershell executables. This should be located in `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`. In this case, you can just copy and paste this directory into the input box.
8. On the same page, go to `Add arguments (optional)` and add the full path to your copy of the MainTask.ps1 script.
9. Click `Next`. Review your info and click `Finish`.
10. In the top box in the middle pane, scroll down and select your created task. Right click on it and select 'properties'.
11. Under `Security options`, check the box to `Run with highest privileges`. Click `OK` when done.
