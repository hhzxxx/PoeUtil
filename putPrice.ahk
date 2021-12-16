#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
global failcount := 0
#RButton::
putPrice()
return

putPrice(price = 0){
  sleep 200
  if(failcount > 3){
    failcount = 0
    ToolTip, 完成
    SetTimer, RemoveToolTip, -3000
    return
  }
  WinActivate, Path of Exile
  src := % A_ScriptDir "\pic\333.png"
  ImageSearch, FoundX, FoundY, % LTopX, % LTopY, % RBottomX, % RBottomY,*30 %src%
  if (ErrorLevel = 2)
  {
    failcount += 1
    putPrice()
  }
  else if (ErrorLevel = 1)
  {
    failcount += 1
    putPrice()
  }
  else{
    Click, %FoundX% %FoundY%,Right
    biaojia(price)
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
    putPrice()
}