$phrase=Read-Host -Prompt "Phrase: "

$flipCase=$false
$newPhrase=""

for ($i=0;$i -lt $phrase.Length;$i++)
{
    
    if($phrase[$i] -cmatch "[A-Z]") { $flipCase=$true }
    elseif($phrase[$i] -cmatch " ") { $newPhrase+= " " }

    if($flipCase) { $newPhrase+= $phrase.substring($i,1).tolower() }
    else  { $newPhrase+= $phrase.substring($i,1).ToUpper() }
    
    $flipCase= -not $flipCase
   
}

Write-Host $newPhrase

