#!/usr/bin/env pwsh

# ===================
# Import Localization
# ===================

# Write a warning for non-Windows system
if ($IsWindows -or $ENV:OS) {
  $localeName = Get-WinSystemLocale | ForEach-Object { $_.Name }
} else {
  Write-Host "Uhm, this is kinda awkward..." -ForegroundColor Red
  Write-Host "Since you are currently using non-Windows OS, we automatically set the locale to English US as the cmdlet (Get-WinSystemLocale) to autoselect locale is can not be installed on another system. Create an issue on PowerShell Official GitHub repo to implement the module natively, we guess." -ForegroundColor Red
  Write-Host ""
  $localeName = "en-US"
}

# Write a warning when user used locale that doesn't translated yet.
if (-not(Test-Path -Path ./i18n/$localeName)) {
  Write-Host "Uh-oh. We can not find the localization file for $($localeName), so we temporarily replace it to English (US)" -ForegroundColor Red
  Write-Host "You can change the locale in next prompt"
  $localeName = "en-US"
  Write-Host ""
}

Import-LocalizedData -BindingVariable i18n -UICulture $localeName -BaseDirectory ./i18n

Write-Host $i18n.InitLocale_General_echo," ", $localeName, ". ", $i18n.InitLocale_General_prompt -ForegroundColor Yellow -Separator ""
Write-Host ""
Write-Host $i18n.InitLocale_List_echo
(Get-ChildItem ./i18n/ -Directory | ForEach-Object { $_.Name }) -Join ", "
$changeLocale = Read-Host -Prompt $i18n.InitLocale_Replace_Prompt

if (-not($changeLocale)) {
  Import-LocalizedData -BindingVariable i18n -BaseDirectory ./i18n
  $changeLocale = $localeName
} else {
  Import-LocalizedData -BindingVariable i18n -UICulture $changeLocale -BaseDirectory ./i18n
}

Write-Host $i18n.InitLocale_Replace_success, $changeLocale -ForegroundColor Green


# ============
# Core Modules
# ============

# Get-NotRoot

Import-Module "./Modules/Get-NotRoot.psm1"

# Get-WinAdmin

Import-Module "./Modules/Get-WinAdmin.psm1"

# ===========
# Start Logic
# ===========

# Check system

if ($IsWindows -or $ENV:OS) {
  Write-Host $i18n.GetOS_IsWindows_echo
  Get-WinAdmin
} elseif ($IsLinux -or $ENV:OS) {
  Write-Host $i18n.GetOS_IsLinux_echo
  Get-NotRoot
} elseif ($IsMacOS -or $ENV:OS) {
  Write-Host $i18n.GetOS_IsMac_echo
  Get-NotRoot
} else {
  $i18n.GetOS_Unknown_e2
  exit 2 # User runs the script on unsupported OS
}