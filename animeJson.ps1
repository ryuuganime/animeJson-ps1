#!/usr/bin/env pwsh

# ===============
# Script Metadata
# ===============

$version = "v.0.0.2"

# ===================
# Import Localization
# ===================

$localeName = Get-WinSystemLocale | foreach { $_.Name }

if (-not(Test-Path -Path ./l18n/$localeName)) {
  Write-Host "Uh-oh. We can not find the localization file for ", $localeName, ", so we temporarily replace it to English (US)" -ForegroundColor Red -Separator ""
  Write-Host "You can change the locale in next prompt"
  $localeName = "en-US"
  Write-Host ""
}

Import-LocalizedData -BindingVariable l18n -UICulture $localeName -BaseDirectory ./l18n

Write-Host $l18n.InitLocale_General_echo," ", $localeName, ". ", $l18n.InitLocale_General_prompt -ForegroundColor Yellow -Separator ""
Write-Host ""
Write-Host $l18n.InitLocale_List_echo
Get-ChildItem ./l18n/ -Directory | foreach { $_.Name }
$changeLocale = Read-Host -Prompt $l18n.InitLocale_Replace_Prompt

if (-not($changeLocale)) {
  Import-LocalizedData -BindingVariable l18n -BaseDirectory ./l18n
  $changeLocale = $localeName
} else {
  Import-LocalizedData -BindingVariable l18n -UICulture $changeLocale -BaseDirectory ./l18n
}

Write-Host $l18n.InitLocale_Replace_success, $changeLocale -ForegroundColor Green

# =========
# Core Functions
# =========

function Get-Root() {
  if ($UID -eq 0) {
    Write-Host $l18n.GetRoot_General_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  } else {
    Write-Host $l18n.GetRoot_General_success -ForegroundColor Green
  }
}

function Get-RootNegate() {
  if ($UID -eq 0) {
    Write-Host $l18n.GetRoot_Negate_General_success -ForegroundColor Green
  } else {
    Write-Host $l18n.GetRoot_Negate_General_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  }
}

# ==============================
# Check if connected to internet
# ==============================

Clear-Host
Write-Host $l18n.CheckInternet_General_echo

$handshakeNetwork = Test-Connection "www.example.org" -ErrorAction "SilentlyContinue";

if ($null -eq $handshakeNetwork) {
  Write-Host $l18n.CheckInternet_General_e6 -ForegroundColor Red
  exit 6 # Connection handshake failed
} else {
  Write-Host $l18n.CheckInternet_General_success -ForegroundColor Green
}

# =====================
# Request on first init
# =====================

$checkInitFile = Test-Path -Path "init_success"

if ($false -eq $checkInitFile) {

  Clear-Host

  # ================================================
  # Check if script is running as root/administrator
  # ================================================

  if ($IsWindows -or $ENV:OS) {
    Write-Host $l18n.GetRoot_IsWindows_echo
    if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
      Write-Host $l18n.GetRoot_IsWindows_success -ForegroundColor Green
    }
    else {
      Write-Host $l18n.GetRoot_IsWindows_e1 -ForegroundColor Red
      exit 1 # User did not run the script as administrator/root
    }
  } elseif ($IsLinux -or $ENV:OS) {
    Write-Host $l18n.GetRoot_IsLinux_echo
    Get-Root
  } elseif ($IsMac -or $ENV:OS) {
    Write-Host $l18n.GetRoot_IsMac_echo
    Get-Root
  } else {
    $l18n.GetRoot_Unknown_e2
    exit 2 # User runs the script on unsupported OS
  }

  # ==============================
  # Check if modules are installed
  # ==============================
  Write-Host ""
  Write-Host $l18n.GetModule_General_echo

  # HJSON Converter
  if (Get-Module -ListAvailable -Name HJSON) {
    Write-Host "github:TomasBouda/hjson-powershell", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
  } else {
    Write-Host "github:TomasBouda/hjson-powershell", $l18n.GetModule_Module_Installed_e3 -ForegroundColor Red
    Install-Module -Name HJSON
  }

  # dotenv File Support
  if (Get-Module -ListAvailable -Name Set-PsEnv) {
    Write-Host "github:rajivharris/Set-PsEnv", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
  } else {
    Write-Host "github:rajivharris/Set-PsEnv", $l18n.GetModule_Module_Installed_e3 -ForegroundColor Red
    Install-Module -Name Set-PsEnv
  }

  # WriteAscii generator
  if (Get-Module -ListAvailable -Name WriteAscii) {
    Write-Host "github:EliteLoser/WriteAscii", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
  } else {
    Write-Host "github:EliteLoser/WriteAscii", $l18n.GetModule_Module_Installed_e3 -ForegroundColor Red
    Install-Module -Name WriteAscii
  }

  # Node.JS and NPM
  if (Get-Command "npm" -ErrorAction SilentlyContinue) {
    Write-Host "npm", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
  } else {
    if ($IsWindows -or $ENV:OS) {
      Write-Host "npm", $l18n.GetModule_Module_Installed_e3 -ForegroundColor Red
      Write-Host $l18n.GetModule_Module_Choco_Installed_e3 -ForegroundColor Yellow
      $chocoInstall= Read-Host 
      if ($chocoInstall -eq "y") {
        Write-Host $l18n.GetModule_Module_Choco_echo
        if (Get-Command "choco" -ErrorAction SilentlyContinue) {
          Write-Host "Chocolatey", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
          Write-Host $l18n.GetModule_Module_Choco_Npm_echo
          choco install npm -y
          Write-Host "npm", $l18n.GetModule_Module_Installed_success -ForegroundColor Green
        } else {
          Write-Host "Chocolatey", $l18n.GetModule_Module_Installed_e3 -ForegroundColor Red
          Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        }
      } else {
        Write-Host $l18n.GetModule_Module_Npm_Installed_e3 -ForegroundColor Red
        exit 3 # Dependencies/modules/packages are not installed
      }
    } else {
      Write-Host $l18n.GetModule_Module_Npm_Installed_e3 -ForegroundColor Red
      Write-Host $l18n.GetModule_Module_Npm_Installed_echo -ForegroundColor Red
      exit 3 # Dependencies/modules/packages are not installed
    }
  }

  # Installing npm packages
  Write-Host $l18n.GetModule_Npm_Packages_echo
  $npmInstall = npm install
  if ($npmInstall -eq 0) {
    Write-Host $l18n.GetModule_Npm_Packages_success -ForegroundColor Green
  } else {
    Write-Host $l18n.GetModule_Npm_Packages_e3 -ForegroundColor Red
    exit 3 # Dependencies/modules/packages are not installed
  }

  Write-Host ""
  Write-Host $l18n.GetModule_General_echo
  Out-File -FilePath "init_success" -Encoding utf8 -Append -NoNewline
  Write-Host $l18n.GetModule_General_success -ForegroundColor Green

  Write-Host ""
  Write-Host $l18n.InitScript_success -ForegroundColor Green
  exit 0
} else {
}

# =======================
# Negate admin/root check
# =======================

if ($IsWindows -or $ENV:OS) {
  Write-Host $l18n.GetRoot_IsWindows_echo
  if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
    Write-Host $l18n.GetRoot_Negate_IsWindows_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  }
  else {
    Write-Host $l18n.GetRoot_Negate_IsWindows_success -ForegroundColor Green
  }
} elseif ($IsLinux -or $ENV:OS) {
  Write-Host $l18n.GetRoot_IsLinux_echo
  Get-RootNegate
} elseif ($IsMac -or $ENV:OS) {
  Write-Host $l18n.GetRoot_IsMac_echo
  Get-RootNegate
} else {
  $l18n.GetRoot_Unknown_e2
  exit 2 # User runs the script on unsupported OS
}

# =========
# Check env
# =========
Write-Host $l18n.GetEnv_Check_echo
if (Test-Path -Path ".env") {
  Write-Host $l18n.GetEnv_Check_Exist_success -ForegroundColor Green
} else {
  Write-Host $l18n.GetEnv_Check_Exist_e1 -ForegroundColor Red
  Copy-Item -Path ".env.example" -Destination ".env"
  Write-Host $l18n.GetEnv_Prompt_echo -ForegroundColor Yellow
  $insertData = Read-Host -Prompt $l18n.General_Answer
  if ($insertData -eq "y") {
    Write-Host "Inserting data into .env file..."

    # Contributor profile
  } else {
    Write-Host "Please to edit .env from your preferred text editor"
    exit 4 # User choosed to exit the script
  }
}

# =================================
# Importing .env file to Powershell
# =================================

Set-PsEnv

# ============================
# Check complete, start script
# ============================

Clear-Host

Write-Ascii "Ryuuganime"
Write-Host ""
Write-Host "           Ryuuganime Anime Metadata JSON Generator", $version
Write-Host ""

Write-Host $l18n.Greetings_General_echo, " ", $env:CONTRIBUTOR_NAME, ". GitHub: ", $env:CONTRIBUTOR_GITHUB -ForegroundColor Green -Separator ""

exit 0 # Force exit user as the script is not done

Write-Host $l18n.Greetings_Init_echo -ForegroundColor Yellow
$searchQuery = Read-Host -Prompt $l18n.General_Answer

# Search on MyAnimeList and get the anime metadata
Write-Host $l18n.Greetings_Search_echo -ForegroundColor Yellow
