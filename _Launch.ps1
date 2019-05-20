# Description: Windows 10 Post Install Clean/Prep Script
# Author: Jon Childers & Chase Jones
# Last Updated: 5/17/19 1:50 pm
#
# !!!!! Set "Set-ExecutionPolicy RemoteSigned" in an elevated shell before launchiing this script: 
# 
#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

write-host "Launching Main Script"

# Tells the script to find other scripts in the working directory
$PSScriptRoot 

# Define the scripts that do things
# $One= $PSScriptRoot+"\One.ps1"
# $Two= $PSScriptRoot+"\Two.ps1"
# $Three= $PSScriptRoot+"\Three.ps1"

#################################################################################

# Call the various things
& "$PSScriptRoot\Chocolatey.ps1"
& "$PSScriptRoot\RemoveApps.ps1"
& "$PSScriptRoot\DisableTasks.ps1"
& "$PSScriptRoot\UnPinApps.ps1"
& "$PSScriptRoot\ProtectPrivacy.ps1"
& "$PSScriptRoot\Annoyances.ps1"
& "$PSScriptRoot\UnpinStart.ps1"
& "$PSScriptRoot\InstallJavaRTE.ps1"
& "$PSScriptRoot\FileExtensions.ps1"
& "$PSScriptRoot\PowerPlan.ps1"
#& "$PSScriptRoot\Wallpaper.ps1"

write-host "Finished"

Start-Sleep 20

#################################################################################

#Start Cleanup
dism /online /Cleanup-Image /StartComponentCleanup

# Restart-Computer
