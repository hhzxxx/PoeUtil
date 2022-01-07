#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

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

showActGuide(number){
  FileRead, OutputVar, %A_ScriptDir%\txt\act%number%.txt
  Try Gui ActGuide: Destroy
  Try Gui ActGuide: +AlwaysOnTop -caption +Border +ToolWindow +LastFound +DPIScale ;provided from rommmcek 10/23/16
  ; WinSet, Transparent, 50
  Gui ActGuide: Color, Black
  Gui ActGuide: Font, s13 cWhite
;   WinSet, TransColor, Black 200,

;   Gui ActGuide:Add, StatusBar,, 
  Gui ActGuide:Add, Text, w500, %OutputVar%
  Gui ActGuide: Show, x2000 y50 AutoSize NA

}

DestroyActGuide(){
  Try Gui ActGuide: Destroy
}
