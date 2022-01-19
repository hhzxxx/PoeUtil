#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

global ACTNUM := 1

Act1:
  showActGuide(1)
return

Act2:
  showActGuide(2)
return

Act3:
  showActGuide(3)
return

Act4:
  showActGuide(4)
return

Act5:
  showActGuide(5)
return

Act6:
  showActGuide(6)
return

Act7:
  showActGuide(7)
return

Act8:
  showActGuide(8)
return

Act9:
  showActGuide(9)
return

Act10:
  showActGuide(10)
return

ShopTextEdit:
   GuiControlGet, ShopText
   ConfigSet("ShopText",ShopText)
return

DestoryAct:
  DestroyActGuide()
return

CloseGuide:
  DestroyActGuide()
return

showActGuide(number){
  global ACTNUM := number
  FileRead, OutputVar, %A_ScriptDir%\txt\act%number%.txt
  Try Gui ActGuide: Destroy
  Try Gui ActGuide: +AlwaysOnTop -caption +Border +ToolWindow +LastFound +DPIScale ;provided from rommmcek 10/23/16
  ; WinSet, Transparent, 50
  Gui ActGuide: Color, Black
  Gui ActGuide: Font, s13 cWhite
;   WinSet, TransColor, Black 200,

;   Gui ActGuide:Add, StatusBar,, 
  Gui ActGuide:Add, Text, w500, %OutputVar%
  Gui, ActGuide:Add, Button, Default w80 xs+10 y+10 gGuide1, 前一章
  Gui, ActGuide:Add, Button, Default w80 x+110 gCloseGuide, ACT %number%
  Gui, ActGuide:Add, Button, Default w80 x+110 gGuide2, 后一章
  
  Gui ActGuide: Show, x0 y500 AutoSize NA

}


Guide1:
  if(ACTNUM > 1){
    showActGuide(ACTNUM - 1)
  }
return


Guide2:
  if(ACTNUM < 10){
    showActGuide(ACTNUM + 1)
  }
return

DestroyActGuide(){
  Try Gui ActGuide: Destroy
}
