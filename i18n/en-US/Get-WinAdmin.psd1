#culture=en-US
ConvertFrom-StringData @'
  IsAdmin_success    = Script is running as administrator
  IsAdmin_e1         = Script is not running as administrator, please to make sure to run as administrator

  IsNotAdmin_e1      = Script is running as administrator, please to make sure to not run as administrator
  IsNotAdmin_success = Script is not running as administrator
'@