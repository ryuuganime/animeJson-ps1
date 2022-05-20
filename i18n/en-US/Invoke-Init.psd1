#culture=en-US
ConvertFrom-StringData @'
  General_echo              = Checking if modules are installed...
  Module_Installed_success  = is installed
  Module_Installed_e3       = is not installed, installing...
  Module_Choco_echo         = Checking if Chocolatey is installed...
  Module_Choco_Installed_e3 = Do you want to install npm via Chocolatey? (y/n)
  Module_Npm_Installed_e3   = npm is not installed, please install manually
  Module_Npm_Installed_echo = Visit https://nodejs.org/en/download/ for more information
  Module_Choco_Npm_echo     = Installing npm via Chocolatey...
  Npm_Packages_echo         = Installing npm dependencies...
  Npm_Packages_success      = npm dependencies installed successfully
  Npm_Packages_e3           = npm dependencies failed to install
'@