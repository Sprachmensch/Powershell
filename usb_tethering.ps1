<#
    Waits for the device to connect and afterwards starts the USB Tethering

    -> Submit the PIN via the cli !

#>
#@todo create a deamon!

Param(
    [Parameter(Mandatory=$True)]
    [string]$SmartphonePIN
)

Set-Location C:\Users\AnalogPresent\Desktop\TempADB\
$waitTime=10    # wait for the "charge screen" to fade out

for ($i=0;$i -lt $waitTime;$i++)
{
    Write-Host "Waiting..."
    Start-Sleep -Seconds 1
}

Write-Host "Check for Device:"
$checkDevice=(./adb.exe devices)

# check
$checkDevice
if($checkDevice -match "AQH7N18105004832")
{
    Write-Host "Found Device"
}else{
    Write-Host "Waiting for Device.."
    Start-Sleep -Seconds 2
}

<#
    Turns the screen and and enters the PIN
#>
Write-Host "Connected via ADB -> send commands!"
./adb.exe shell input keyevent 26
./adb.exe shell input text $SmartphonePIN
./adb.exe shell am start -n com.android.settings/.TetherSettings
./adb.exe shell input keyevent 20
./adb.exe shell input keyevent 20
./adb.exe shell input keyevent 20
./adb.exe shell input keyevent 66

Start-Sleep -Seconds 2
./adb.exe shell input keyevent 4
./adb.exe shell input keyevent 26
Write-Host "USB Tethering is now enabled"

./adb.exe kill-server
Write-Host "Done"