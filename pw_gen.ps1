<# quick'n'dirty passwort generator #>

$pwLength=Read-Host -Prompt "Password length (num)"
$alphaLower="a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","v","u","w","x","y","z"
$alphaUpper=$alphaLower.ToUpper()
$numeric="0","1","2","3","4","5","6","7","8","9","!","#","+","*","-","_"
$pwTemp=""
Write-Host "Password: " -NoNewline
for ($i=0;$i -lt $pwLength;$i++)
{
    $pwTemp =$pwTemp + (($alphaUpper +$alphaLower+ $numeric) | Get-Random)
}   
Write-Host $pwTemp
$pwTemp | Set-Clipboard
Write-Host "Password is copied to Clipboard"