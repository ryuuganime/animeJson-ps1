Import-LocalizedData -BindingVariable i18n -UICulture $changeLocale -BaseDirectory ./i18n

function Get-WinAdmin {
  if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
    Write-Host $i18n.IsAdmin_success -ForegroundColor Green
  }
  else {
    Write-Host $i18n.IsAdmin_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  }
}

function Get-NotWinAdmin {
  if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
    Write-Host $i18n.IsNotAdmin_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  } else {
    Write-Host $i18n.IsNotAdmin_success -ForegroundColor Green
  }
}

Export-ModuleMember -Function Get-WinAdmin
Export-ModuleMember -Function Get-NotWinAdmin