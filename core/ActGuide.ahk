#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Act1:
  showActGuide()
return

Act2:
  showActGuide()
return

Act3:
  showActGuide()
return

Act4:
  showActGuide()
return

Act5:
  showActGuide()
return

DestoryAct:
  DestroyActGuide()
return

showActGuide(){
  FileRead, OutputVar, %A_ScriptDir%\txt\act1.txt
  Try Gui ActGuide: Destroy
  Try Gui ActGuide: +AlwaysOnTop -caption +Border +ToolWindow +LastFound +DPIScale ;provided from rommmcek 10/23/16
  ; WinSet, Transparent, 50
  Gui ActGuide: Color, EFEFE4
  Gui ActGuide: Font, s13 
  ; WinSet, TransColor, EFEFE4 255,

  Gui ActGuide: Show, x2000 y50 w550 h500 NA

  Gui ActGuide:Add, Text, w500, %OutputVar%
  ; Gui ActGuide: Color, white
}

DestroyActGuide(){
  Try Gui ActGuide: Destroy
}
