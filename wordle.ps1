<#

to do
- show multiple occurances
- alphabet -> show "used" letters
- refactoring
- sanitize input -nums, umlau

- Bugs
-- "two letters"

    Colors
    Black | DarkBlue | DarkGreen | DarkCyan | DarkRed | DarkMagenta | DarkYellow | Gray | DarkGray | Blue |     
    Green | Cyan | Red | Magenta | Yellow | White
    
#>

$goal = @("hotel","essen","liebe","monat","biene") | Get-Random
$used=""
$alphabet="abcdefghijklmnopqrstvuwxyz".ToUpper()

$counter=1
$goal=$goal.ToUpper()
$guess=""
$goalUsed=$goal

function Draw-Header {    
    Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
    Write-Host "  W O R D L E  " -Backgroundcolor Green -ForegroundColor Black
    Write-Host "               " -Backgroundcolor Green -ForegroundColor Black
    Write-Host ""   
}

function Draw-Alphabet {
    for ($i=0;$i -le $alphabet.Length;$i++)
    {
        Write-Host " " -NoNewline
        if($used.Contains($alphabet[$i]))
        {
            if($goal.Contains($alphabet[$i]) )
            {
                if($goalUsed.Contains($alphabet[$i]))
                {
                    #Write-Host $goal.IndexOf($alphabet[$i]) $guess.IndexOf($alphabet[$i])
                   
                    if($goal.IndexOf($alphabet[$i]) -eq $guess.IndexOf($alphabet[$i]))
                    {
                        Write-Host $alphabet[$i] -NoNewline -ForegroundColor Green
                    }else{
                        Write-Host $alphabet[$i] -NoNewline -ForegroundColor Yellow
                    }

                    $goalUsed= $goalUsed.Replace($alphabet[$i]," ")
                }

            }else{
                Write-Host $alphabet[$i] -NoNewline -ForegroundColor DarkGray 
            }
        }else{
            Write-Host $alphabet[$i] -NoNewline -ForegroundColor Gray
        }

        if(($i -eq 6 ) -or( $i -eq 13)-or( $i -eq 20))
        { 
            Write-Host "" 
            if($i -eq 20 )
            {
                     Write-Host "  " -NoNewline
            }
        }
    }
    Write-Host ""
    Write-Host ""
}

function Draw-Goal {
    param (
        [Parameter(Mandatory=$true)][bool]$won
    )
    $msg=""
    $color="White"

    if($won)
    {
        $msg="    YOU WON!   "
        $color="Green"
    }else{
        $msg="    YOU LOSE   "
        $color="Red"
    }

    Write-Host $msg -Backgroundcolor $color -ForegroundColor Black
    
    if($won -ne $true){
        Write-Host " WORD WAS $goal    "
    }
}

Clear-Host
Draw-Header

Write-Host " X  X  X  X  X " -Backgroundcolor Green -ForegroundColor Black
Write-Host ""
Draw-Alphabet

$gameIsRunning=$true

while($gameIsRunning)
{
    Write-Host "Your guess ($counter/5):"
    while($true)
    {
        $guess=Read-Host
        if ($guess -eq "q")
        {
            $gameIsRunning=$false
            Write-Host "Quitting"
            break
        }
        elseif ($guess.Length -eq 5)
        {
            break
        }else{
            Write-Host "Bad Input!"
        }
    }
    Clear-Host
    Draw-Header    
    
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
                Write-Host (" {0} " -f $guess[$i]) -NoNewline -Backgroundcolor Yellow -ForegroundColor Black
            }else
            {
                Write-Host (" X ") -NoNewline -Backgroundcolor Gray -ForegroundColor Black
            }
        }
    }

    Write-Host ""
    Write-Host ""

    Draw-Alphabet

    if($goal -eq $guess)
    {
        Draw-Goal -won $true
        break
    }

    if($counter -ge 5)
    {
        Draw-Goal -won $false
        break
    }

    $counter++
}

