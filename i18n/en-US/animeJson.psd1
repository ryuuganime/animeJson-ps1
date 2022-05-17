#culture="en-US"
ConvertFrom-StringData @'
  General_Answer                      = Answer
  General_Query                       = Query

  InitLocale_General_echo             = System automatically set the language for the script to
  InitLocale_General_prompt           = Do you want to change the language to else?
  InitLocale_List_echo                = Currently available languages:
  InitLocale_Replace_prompt           = Write language code. Press enter/return key to keep the language
  InitLocale_Replace_success          = Successfuly changed the script language to

  InitScript_echo                     = Do you want to initialize script (Windows requires to run as admin)? (y/n)
  InitScript_success                  = Script initialized successfully. Please rerun the script normally (without running as admin)

  GetOS_IsWindows_echo                = You are using Windows
  GetOS_IsLinux_echo                  = You are using Linux
  GetOS_IsMac_echo                    = You are using macOS
  GetOS_Unknown_e2                    = You are using an unknown OS, please use a supported OS: Windows, Linux, or macOS

  GetAdmin_IsWindows_success          = Script is running as administrator
  GetAdmin_IsWindows_e1               = Script is not running as administrator, please to make sure to run as administrator

  GetNotRoot_General_success          = Script is not running as root
  GetNotRoot_General_e1               = Script is running as root, please to make sure to run as non-root

  GetAdminNegate_IsWindows_e1         = Script is running as administrator, please to make sure to not run as administrator
  GetAdminNegate_IsWindows_success    = Script is not running as administrator

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
  GetModule_Npm_Packages_echo         = Installing npm dependencies...
  GetModule_Npm_Packages_success      = npm dependencies installed successfully
  GetModule_Npm_Packages_e3           = npm dependencies failed to install

  OutFile_General_echo                = Creating init_success file
  OutFile_General_success             = init_success file created

  GetEnv_Check_echo                   = Checking if .env file is present...
  GetEnv_Check_Exist_success          = .env file exists
  GetEnv_Check_Exist_e5               = .env file does not exist, creating...
  GetEnv_Prompt_e4                    = Please to edit .env from your preferred text editor first and rerun the script.

  Greetings_General_echo              = Welcome back,
  Greetings_Init_echo                 = Start typing the title of the metadata you want to create. Press enter to continue or press Ctrl+C to exit.
  Greetings_Search_echo               = Searching on

  Query_GrabID_prompt                 = Type the entry ID to proceed to another step
'@
