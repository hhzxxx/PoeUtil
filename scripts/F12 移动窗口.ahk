
#NoTrayIcon

SetWindelay,0
CoordMode,Mouse,Screen


$F12::  

StartTime := A_TickCount

MouseGetPos,x,y,win
WinGetPos,x1,y1,,,ahk_id %win%
a=%x1%
b=%y1%

loop{

MouseGetPos,x2,y2
c=%x2%
d=%y2%
c-=%x%
d-=%y%
a+=%c%
b+=%d%
x=%x2%
y=%y2%
Winmove,ahk_id %win%,,%a%,%b%

getkeystate,var,F12,p   

if var=U
return

Sleep,20
continue
}



ElapsedTime := A_TickCount - StartTime

intInterval := 200 

if (ElapsedTime > intInterval)
{
    return
}

send {F12}

return









