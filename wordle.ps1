<#

to do
-show multiple occurances
-alphabet -> show "used" letters

#>
#Write-Host "HOT" -NoNewline -Backgroundcolor Green -ForegroundColor Black
#Write-Host "E" -NoNewline -Backgroundcolor Red -ForegroundColor Black 

Clear-Host

Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
Write-Host "  W O R D L E  " -Backgroundcolor Green -ForegroundColor Black
Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
Write-Host "" 
Write-Host " X X X X X " -Backgroundcolor Green -ForegroundColor Black

$goal = Get-Content -Path ./words.txt | Get-Random
$used=""
$alphabet="abcdefghijklmnopqrstvuwxyz".ToUpper()

$counter=1
#$goal="HOTEL"
while($true)
{
    $guess=Read-Host -Prompt "Your guess ($counter/5)"
    Clear-Host
    Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
    Write-Host "  W O R D L E  " -Backgroundcolor Green -ForegroundColor Black
    Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
    Write-Host "" 
    if($guess -eq "q")
    {
        break
    }
    $guess=$guess.ToUpper()
    $used+=$guess
    
    # compare the words
    for ($i=0;$i -lt 5;$i++)
    {
        if($goal[$i] -eq $guess[$i])
        {
            Write-Host (" {0} " -f $guess[$i]) -NoNewline -Backgroundcolor Green -ForegroundColor Black
        }else{
            if($goal.Contains($guess[$i]))
            {
                # ("Greetings from {0} to {1} " -f $users[0],$users[1])
                Write-Host (" {0} " -f $guess[$i]) -NoNewline -Backgroundcolor Yellow -ForegroundColor Black
            }else
            {
                Write-Host (" X ") -NoNewline -Backgroundcolor Gray -ForegroundColor Black
            }
        }
       # Write-Host " " -NoNewline
    }

    <#
    Colors
    Black | DarkBlue | DarkGreen | DarkCyan | DarkRed | DarkMagenta | DarkYellow | Gray | DarkGray | Blue |     
    Green | Cyan | Red | Magenta | Yellow | White
    #>

    Write-Host ""
    Write-Host ""
    for ($i=0;$i -le $alphabet.Length;$i++)
    {
        Write-Host " " -NoNewline
        if($used.Contains($alphabet[$i]))
        {
            if($goal.Contains($alphabet[$i]))
            {
                Write-Host $alphabet[$i] -NoNewline -ForegroundColor Yellow
            }else{
                Write-Host $alphabet[$i] -NoNewline -ForegroundColor DarkGray 
            }
        }else{
            Write-Host $alphabet[$i] -NoNewline -ForegroundColor Gray
        }

        if(($i -eq 8 ) -or( $i -eq 17))
        {
            Write-Host "" 
        }
        
    }
    Write-Host ""
    Write-Host ""

    # check win
    if($goal -eq $guess)
    {
        Write-Host "YOU WON!" -Backgroundcolor Green -ForegroundColor Black
        break
    }
    # check win
    if($counter -ge 5)
    {
        Write-Host "YOU LOSE" -Backgroundcolor Red -ForegroundColor Black
        Write-Host " "$goal" " -Backgroundcolor Red -ForegroundColor Black
        break
    }
    $counter++
}

