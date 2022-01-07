#IfWinActive Path of Exile
#NoTrayIcon
#Persistent
#SingleInstance

LButtondown=0


+~^LButton::
~^LButton::
WinGetTitle, name, A
If (name != "Path of Exile"){
return
}
LButtondown:=1
Loop{
WinGetTitle, name, A
If (name != "Path of Exile"){
return
}
if(LButtondown = 0){
return
}
Click
sleep 80
}
Return

+~^LButton Up::
~LButton Up::
~^LButton Up::
LButtondown:=0
move:=0
Return


~^e::
WinGetTitle, name, A
If (name != "Path of Exile"){
return
}
Send {Space}
Send {i}
click,2611 820 right
Send {Space}
Return

~^r::
WinGetTitle, name, A
If (name != "Path of Exile"){
return
}
	Send {Enter}
	Send,{ShiftDown}{Home}{ShiftUp}{BackSpace}
	SendActualText("/Exit")
	Send {Enter}
sleep 1800
Send {Enter}
Return


SendActualText(text) { ;粘贴指定文本，并且恢复剪贴板
	_temp := Clipboard
	Clipboard = %text%
	Send ^v
	Sleep 100
	Clipboard = %_temp%
}