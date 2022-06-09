<#

to do
- show multiple occurances
- alphabet -> show "used" letters
- refactoring

    Colors
    Black | DarkBlue | DarkGreen | DarkCyan | DarkRed | DarkMagenta | DarkYellow | Gray | DarkGray | Blue |     
    Green | Cyan | Red | Magenta | Yellow | White
    
#>

$goal = Get-Content -Path ./words.txt | Get-Random
$used=""
$alphabet="abcdefghijklmnopqrstvuwxyz".ToUpper()

$counter=4
$goal="hotel".ToUpper()

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
            if($goal.Contains($alphabet[$i]))
            {
                Write-Host $alphabet[$i] -NoNewline -ForegroundColor Yellow
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

    #Write-Host "               " -Backgroundcolor $color -ForegroundColor Black
    Write-Host $msg -Backgroundcolor $color -ForegroundColor Black
    #Write-Host "               " -Backgroundcolor $color -ForegroundColor Black
    
    if($won -ne $true){
        Write-Host " WORD WAS $goal    "
    }
}

Clear-Host
Draw-Header

Write-Host " X  X  X  X  X " -Backgroundcolor Green -ForegroundColor Black
Write-Host ""
Draw-Alphabet
Write-Host ""
Write-Host ""


while($true)
{
    Write-Host "Your guess ($counter/5):"
    $guess=Read-Host
    Clear-Host
    Draw-Header
    
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

    Write-Host ""
    Write-Host ""

    Draw-Alphabet
  
    Write-Host ""
    Write-Host ""

    # check win
    if($goal -eq $guess)
    {
        Draw-Goal -won $true
        break
    }
    # check win
    if($counter -ge 5)
    {
        Draw-Goal -won $false
        break
    }
    $counter++
}

