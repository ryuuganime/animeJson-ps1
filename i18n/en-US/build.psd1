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

  

  GetAdminNegate_IsWindows_e1         = Script is running as administrator, please to make sure to not run as administrator
  GetAdminNegate_IsWindows_success    = Script is not running as administrator
'@