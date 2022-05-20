function Invoke-RESTQuery {
  param (
    [Parameter(Mandatory=$true)]
    [string]$Uri,
    [Parameter(Mandatory=$true)]
    [string]$JSONProperty,
    [Parameter(Mandatory=$true)]
    [string[]]$Objects,
    [string]$Method = 'Get',
    [string]$ContentType = 'application/json'
  )
  $iwr = Invoke-WebRequest -Uri $Uri -Method $Method -ContentType $ContentType
  (ConvertFrom-Json ($iwr).content | Select-Object -Expand $JSONProperty) | Select-Object $Objects | Format-Table
}

Export-ModuleMember -Function Invoke-RESTQuery