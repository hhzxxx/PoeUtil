
#NoTrayIcon

SetWinDelay,0
CoordMode,mouse,Screen

$F11::   

StartTime := A_TickCount

MouseGetPos,mx1,my1,win
WinGetPos,winx,winy,winw,winh,ahk_id %win%

loop{

GetKeyState,varp,F11,p   

if varp=U
break

MouseGetPos,mx2,my2
xx=% winw + mx2 - mx1
yy=% winh + my2 - my1 
winmove,ahk_id %win%,,%winx%,%winy%,%xx%,%yy%

sleep,30
}



ElapsedTime := A_TickCount - StartTime

intInterval := 200 

if (ElapsedTime > intInterval)
{
    return
}

send {F11}

return








