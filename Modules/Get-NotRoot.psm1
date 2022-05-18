
function Get-NotRoot() {
  if ($whoAmI -ne "root") {
    Write-Host $i18n.GetNotRoot_General_success -ForegroundColor Green
  } else {
    Write-Host $i18n.GetNotRoot_General_e1 -ForegroundColor Red
    exit 1 # User did not run the script as administrator/root
  }
}