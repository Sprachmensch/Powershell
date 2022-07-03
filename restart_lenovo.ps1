<#
    restarts the lenovo Hotkey Service, sadly needed 'cus the keys stop working sometimes on win 10
#>
Write-Host "Restarting the "Lenovo Hotkey Client Loader" Service"

$ServiceName="TPHKLOAD"
$LenovoService = Get-Service -Name $ServiceName
$LenovoService.Status
try {
    Restart-Service -Name $ServiceName -Force -ErrorAction Stop
}
catch {
    Write-Host "Do you have Admin rights? i guess you've not"
    Write-Host "An error occurred:"
    Write-Host $_
    Exit
}

$LenovoService.Status

Write-Host "Done - Hotkeys should work again!"