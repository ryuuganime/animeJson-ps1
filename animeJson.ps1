#!/usr/bin/env pwsh

# ===============
# Script Metadata
# ===============

$version = "v.0.0.2"

# =====
# Intro
# =====

Clear-Host
Write-Host "Ryuuganime Anime Metadata JSON Generator", $version -ForegroundColor Blue
Write-Host ""

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

# Invoke-Init
Import-Module "./Modules/Invoke-Init.psm1"

# Invoke-RESTQuery
Import-Module "./Modules/Invoke-RESTQuery.psm1"

# ==============
# Core Variables
# ==============

$switchNsfwBoolean = switch ($env:SHOW_NSFW) { "true" {"false"}; "false" {"true"}; default {"true"} }

# ==============================
# Check if connected to internet 
# ==============================

# Clear-Host
Write-Host $i18n.CheckInternet_General_echo

$handshakeNetwork = Test-Connection "www.example.org" -ErrorAction "SilentlyContinue";

if ($null -eq $handshakeNetwork) {
  Write-Host $i18n.CheckInternet_General_e6 -ForegroundColor Red
  exit 6 # Connection handshake failed
} else {
  Write-Host $i18n.CheckInternet_General_success -ForegroundColor Green
}

# =====================
# Request on first init
# =====================

$checkInitFile = Test-Path -Path "init_success@script"

if ($false -eq $checkInitFile) {

  Write-Host ""
  Write-Host $i18n.InitScript_echo -ForegroundColor Yellow
  $initScriptResponse = Read-Host -Prompt $i18n.General_Answer

  if ($initScriptResponse -eq "y") {

    # Clear-Host

    # ================================================
    # Check if script is running as root/administrator
    # ================================================

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

    # Request an initialization
    Invoke-Init

    # Installing npm packages
    Write-Host ""
    Write-Host $i18n.GetModule_Npm_Packages_echo
    npm install
    if (Test-Path -Path "./node_modules/") {
      Write-Host $i18n.GetModule_Npm_Packages_success -ForegroundColor Green
    } else {
      Write-Host $i18n.GetModule_Npm_Packages_e3 -ForegroundColor Red
      exit 3 # Dependencies/modules/packages are not installed
    }

    Write-Host ""
    Write-Host $i18n.OutFile_General_echo
    Out-File -FilePath "init_success" -Encoding utf8 -Append -NoNewline
    Write-Host $i18n.OutFile_General_success -ForegroundColor Green

    Write-Host ""
    Write-Host $i18n.InitScript_success -ForegroundColor Green
    Write-Host ""
    exit 0
  }
}

# =======================
# Negate admin/root check
# =======================

if ($IsWindows -or $ENV:OS) {
  Write-Host $i18n.GetOS_IsWindows_echo
  Get-NotWinAdmin
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

# =========
# Check env
# =========
Write-Host $i18n.GetEnv_Check_echo
if (Test-Path -Path ".env") {
  Write-Host $i18n.GetEnv_Check_Exist_success -ForegroundColor Green
} else {
  Write-Host $i18n.GetEnv_Check_Exist_e1 -ForegroundColor Red
  Copy-Item -Path ".env.example" -Destination ".env"
  Write-Host ""
  Write-Host $i18n.GetEnv_Prompt_e4 -ForegroundColor Red
  exit 4 # User requires to manually configure the file
}

# =================================
# Importing .env file to Powershell
# =================================

Set-PsEnv

# ============================
# Check complete, start script
# ============================

# Clear-Host

npx figlet "RYUUGANIME"
Write-Host ""
Write-Host "       Ryuuganime Anime Metadata JSON Generator", $version
Write-Host ""

Write-Host $i18n.Greetings_General_echo, " ", $env:CONTRIBUTOR_NAME, ". GitHub: ", $env:CONTRIBUTOR_GITHUB -ForegroundColor Green -Separator ""


Write-Host ""
Write-Host $i18n.Greetings_Init_echo -ForegroundColor Yellow
$searchQueryRaw = Read-Host -Prompt $i18n.General_Query
# Do not show error when user pressed Ctrl+C

if (-not($searchQueryRaw)) {
  Write-Host "Exiting..."
  exit 0
} else {
  $searchQueryEncoded = [uri]::EscapeDataString($searchQueryRaw)
}

# Search on MyAnimeList and get the anime metadata
Write-Host $i18n.Greetings_Search_echo, "MyAnimeList:", `"$searchQueryRaw`" -ForegroundColor Yellow
Invoke-RESTQuery -Uri "https://api.jikan.moe/v4/anime?q=$($searchQueryEncoded)&limit=25&sfw=$($switchNsfwBoolean)" -JSONProperty "data" -Objects mal_id,title,type,year,status

Write-Host $i18n.Query_GrabID_prompt -ForegroundColor Yellow
$entry_id_MAL = Read-Host -Prompt $i18n.General_Query
$entry_id_Shikimori = $entry_id_MAL

# Confirming if Shikimori metadata matches with MyAnimeList
# Write-Host $i18n.Greetings_Search_echo, "MyAnimeList:", `"$searchQueryRaw`", "(MAL ID:$($entry_id_MAL)" -ForegroundColor Yellow
# Invoke-RESTQuery -Uri "https://shikimori.one/api/animes/$($entry_id_Shikimori)" 

# Write-Host $i18n.Greetings_Search_echo, "AniList:", `"$searchQueryRaw`" -ForegroundColor Yellow
# $anilistGQLSearchMALID = '
#   query Media($idMal: Int) {
#     Media(idMal: $idMal) {
#       id
#     }
#   }
# '
# $anilistGQLSearchVars = '
#   idMal: $($entry_id_MAL)
# '
