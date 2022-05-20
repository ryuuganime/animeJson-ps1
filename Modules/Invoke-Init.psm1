Import-LocalizedData -BindingVariable i18n -UICulture $changeLocale -BaseDirectory ./i18n

function Install-Chocolatey {
  Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function Invoke-Init {
  # ==============================
  # Check if modules are installed
  # ==============================
  Write-Host ""
  Write-Host $i18n.General_echo

  # HJSON Converter
  if (Get-Module -ListAvailable -Name HJSON) {
    Write-Host "github:TomasBouda/hjson-powershell", $i18n.Module_Installed_success -ForegroundColor Green
  } else {
    Write-Host ""
    Write-Host "github:TomasBouda/hjson-powershell", $i18n.Module_Installed_e3 -ForegroundColor Red
    Install-Module -Name HJSON
  }

  # dotenv File Support
  if (Get-Module -ListAvailable -Name Set-PsEnv) {
    Write-Host "github:rajivharris/Set-PsEnv", $i18n.Module_Installed_success -ForegroundColor Green
  } else {
    Write-Host ""
    Write-Host "github:rajivharris/Set-PsEnv", $i18n.Module_Installed_e3 -ForegroundColor Red
    Install-Module -Name Set-PsEnv
  }

  # GraphQL Support
  # if (Get-Module -ListAvailable -Name PSGraphQL) {
  #   Write-Host "github:anthonyg-1/PSGraphQL", $i18n.Module_Installed_success -ForegroundColor Green
  # } else {
  #   Write-Host ""
  #   Write-Host "github:anthonyg-1/PSGraphQL", $i18n.Module_Installed_e3 -ForegroundColor Red
  #   Install-Module -Name PSGraphQL
  # }

  # WriteAscii generator
  # Module not supported on non-Windows system as core modules were missing
  # if (Get-Module -ListAvailable -Name WriteAscii) {
  #   Write-Host "github:EliteLoser/WriteAscii", $i18n.Module_Installed_success -ForegroundColor Green
  # } else {
  #   Write-Host ""
  #   Write-Host "github:EliteLoser/WriteAscii", $i18n.Module_Installed_e3 -ForegroundColor Red
  #   Install-Module -Name WriteAscii
  # }

  # Node.JS and NPM
  if (Get-Command "npm" -ErrorAction SilentlyContinue) {
    Write-Host "npm", $i18n.Module_Installed_success -ForegroundColor Green
  } else {
    if ($IsWindows -or $ENV:OS) {
      Write-Host "npm", $i18n.Module_Installed_e3 -ForegroundColor Red
      Write-Host $i18n.Module_Choco_Installed_e3 -ForegroundColor Yellow
      $chocoInstall= Read-Host 
      if ($chocoInstall -eq "y") {
        Write-Host $i18n.Module_Choco_echo
        if (Get-Command "choco" -ErrorAction SilentlyContinue) {
          Write-Host "Chocolatey", $i18n.Module_Installed_success -ForegroundColor Green
          Write-Host $i18n.Module_Choco_Npm_echo
          choco install npm -y
          Write-Host "npm", $i18n.Module_Installed_success -ForegroundColor Green
        } else {
          Write-Host "Chocolatey", $i18n.Module_Installed_e3 -ForegroundColor Red
          Install-Chocolatey
        }
      } else {
        Write-Host $i18n.Module_Npm_Installed_e3 -ForegroundColor Red
        exit 3 # Dependencies/modules/packages are not installed
      }
    } else {
      Write-Host $i18n.Module_Npm_Installed_e3 -ForegroundColor Red
      Write-Host $i18n.Module_Npm_Installed_echo -ForegroundColor Red
      exit 3 # Dependencies/modules/packages are not installed
    }
  }
}

Export-ModuleMember -Function Install-Chocolatey
Export-ModuleMember -Function Invoke-Init