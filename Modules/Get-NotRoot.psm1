$whoAmI = whoami

Import-LocalizedData -BindingVariable i18n -UICulture $changeLocale -BaseDirectory ./i18n

function Get-NotRoot() {
  if ($whoAmI -ne "root") {
    Write-Host $i18n.success -ForegroundColor Green
  } else {
    Write-Host $i18n.e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  }
}

Export-ModuleMember -Function Get-NotRoot