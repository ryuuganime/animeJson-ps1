#culture="en-US"
ConvertFrom-StringData @'
  General_Answer                      = Answer

  InitLocale_General_echo             = System automatically set the language for the script to
  InitLocale_General_prompt           = Do you want to change the language to else?
  InitLocale_List_echo                = Currently available languages:
  InitLocale_Replace_prompt           = Write language code. Press enter/return key to keep the language
  InitLocale_Replace_success          = Successfuly changed the script language to

  InitScript_echo                     = Do you want to initialize script (requires root/admin)? (y/n)
  InitScript_success                  = Script initialized successfully. Please rerun the script normally (without root/admin)

  GetRoot_General_e1                  = You must be root to run this script
  GetRoot_General_success             = Script is running as root
  GetRoot_IsWindows_echo              = You are using Windows
  GetRoot_IsWindows_success           = Script is running as administrator
  GetRoot_IsWindows_e1                = Script is not running as administrator, please to make sure to run as administrator
  GetRoot_IsLinux_echo                = You are using Linux
  GetRoot_IsMac_echo                  = You are using macOS
  GetRoot_Unknown_e2                  = You are using an unknown OS, please use a supported OS: Windows, Linux, or macOS

  GetRoot_Negate_General_success      = Script is not running as root
  GetRoot_Negate_General_e1           = Script is running as root, please to make sure to run as non-root
  GetRoot_Negate_IsWindows_e1         = Script is running as administrator, please to make sure to not run as administrator
  GetRoot_Negate_IsWindows_success    = Script is not running as administrator

  CheckInternet_General_echo          = Checking if internet connected
  CheckInternet_General_success       = Internet is available
  CheckInternet_General_e6            = Internet is not available

  GetModule_General_echo              = Checking if modules are installed...
  GetModule_Module_Installed_success  = is installed
  GetModule_Module_Installed_e3       = is not installed, installing...
  GetModule_Module_Choco_echo         = Checking if Chocolatey is installed...
  GetModule_Module_Choco_Installed_e3 = Do you want to install npm via Chocolatey? (y/n)
  GetModule_Module_Npm_Installed_e3   = npm is not installed, please install manually
  GetModule_Module_Npm_Installed_echo = Visit https://nodejs.org/en/download/ for more information
  GetModule_Module_Choco_Npm_echo     = Installing npm via Chocolatey...
  GetModule_Npm_Packages_echo         = Installing npm packages...
  GetModule_Npm_Packages_success      = npm packages installed successfully
  GetModule_Npm_Packages_e3           = npm packages failed to install

  OutFile_General_echo                = Creating init_success file
  OutFile_General_success             = init_success file created

  GetEnv_Check_echo                   = Checking if .env file is present...
  GetEnv_Check_Exist_success          = .env file exists
  GetEnv_Check_Exist_e5               = .env file does not exist, creating...
  GetEnv_Prompt_echo                  = Do you want to insert your data into .env file from terminal? (y/n)
  GetEnv_Prompt_success               = Inserting data into .env file
  GetEnv_Prompt_e4                    = Please to edit .env from your preferred text editor

  Greetings_General_echo              = Welcome back,
  Greetings_Init_echo                 = Start typing the title of the metadata you want to create. Press enter to continue or press Ctrl+C to exit.
'@
