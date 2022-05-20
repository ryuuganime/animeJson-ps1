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

  CheckInternet_General_echo          = Checking if internet connected
  CheckInternet_General_success       = Internet is available
  CheckInternet_General_e6            = Internet is not available

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
