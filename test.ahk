#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
global LTopX:=58
global LTopY:=355
global RBottomX:=999
global RBottomY:=999
global failcount := 0
#RButton::
dianji()
return

dianji(){
  
  sleep 200
  if(failcount > 3){
    Reload
  }
  WinActivate, Path of Exile
  src := % A_ScriptDir "\pic\333.png"
  ImageSearch, FoundX, FoundY, % LTopX, % LTopY, % RBottomX, % RBottomY,*30 %src%
  if (ErrorLevel = 2)
  {
    failcount += 1
    dianji()
  }
  else if (ErrorLevel = 1)
  {
    failcount += 1
    dianji()
  }
  else{
    Click, %FoundX% %FoundY%,Right
    biaojia(5)
  }
}

biaojia(value){
  Sleep, 100
  src := % A_ScriptDir "\pic\111.png"
  ImageSearch, FoundX, FoundY, % LTopX, % LTopY, % RBottomX, % RBottomY,*20 %src%
  if (ErrorLevel = 2)
    MsgBox %src%
  else if (ErrorLevel = 1)
    MsgBox % LTopX LTopY RBottomX RBottomY src
  else
    Click, %FoundX% %FoundY%
    Send, %value%
    queding()
}

queding(){
  Sleep, 100
  src := % A_ScriptDir "\pic\222.png"
  ImageSearch, FoundX, FoundY, % LTopX, % LTopY, % RBottomX, % RBottomY,*20 %src%
  if (ErrorLevel = 2)
    MsgBox %src%
  else if (ErrorLevel = 1)
    MsgBox % LTopX LTopY RBottomX RBottomY src
  else
    Click, %FoundX% %FoundY%
    dianji()
}