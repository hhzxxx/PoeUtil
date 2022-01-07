#IfWinActive Path of Exile
#NoTrayIcon
#Persistent
#SingleInstance
v_Enable=0
Thread, Interrupt, 0

~RButton::
If (v_Enable=1)
{
	Heyao()
	Tick := 30
	SetTimer, TimerLan, 100
}
Return


~F::

If (v_Enable=1)
{
  ;send 5
	Heyao()
	Tick := 30
	SetTimer, TimerLan, 100
}
Return

~!w::
v_Enable:=!v_Enable
If (v_Enable=0)
{
Tooltip,, 506, 1277,1
	;MsgBox,,,结束,0.5
	SetTimer, Label0, Off
	    SetTimer, TimerLan, Off
    Tooltip,, 576, 1277,2
}
Else
{
Tooltip, start, 506, 1277,1
;MsgBox,,,开始,0.5
SetTimer, Label0, 1
}
Return


!q::
Send {8}
Send {9}
Send {-}
Send {]}
Send {0}
return


TimerLan:
if(inGame()){
if Tick--
{
	Heyao()
	Tooltip, % Format("{:02d}:{:02d}", Tick/60 , Mod(Tick,60)), 576, 1277,2
}
else
{
    SetTimer, TimerLan, Off
    Tooltip,, 576, 1277,2
}
}else{
    SetTimer, TimerLan, Off
    Tooltip,, 576, 1277,2
}
return

Label0:
if(inGame()){
PixelGetColor, yy,  127,1203,Slow
if(yy != 0x2C2182) 
{
	;send 0
}
;PixelGetColor, xue, 157,1305  ,Slow  
;145,1272
;if(xue != 0x291CB6 and xue != 0x281AB3 and xue != 0x1D2898 and xue != 0x1E2998 ) 
;{
;	send 1
	sleep 500
;}
}

return

inGame()
{
WinGetTitle, name, A
If (name != "Path of Exile"){
return false
}
PixelGetColor, ui,  352,1261,Slow
if(ui != 0x1C1919) 
{
return false
}
If (v_Enable=0)
{
return false
}
return true
}

Heyao()
{
	PixelGetColor, yao1, 420,1429,Slow 
	if( yao1 = 0x000000 ){
		send 1
	}else {

	}
  ;PixelGetColor, yao1, 433,1353,Slow 
	;if( yao1 = 0x314ED6 or yao1 = 0x2B42B2){
	;	send 1
	;}else {
;
	;}
  
	PixelGetColor, yao2, 488,1429,Slow
	if(yao2 = 0x060505  ){  
		send 2
	}else{
	}
	PixelGetColor, yao3, 545,1429,Slow
	if(yao3 = 0x070606  ){  
		send 3
	}else{
	}
	PixelGetColor, yao4, 605,1429,Slow
	if(yao4 = 0x050404  ){  
		send 4
	}else{
	}
	PixelGetColor, yao5, 665,1429,Slow
	if(yao5 = 0x000000  ){  
		send 5
	}else{
	}
}


!F::
PixelGetColor, OutputVar, 420,1429
clipboard := OutputVar
Reload
return