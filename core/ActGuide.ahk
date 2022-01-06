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
   Try Gui ActGuide: Destroy
   Try Gui ActGuide: +AlwaysOnTop -caption +Border +ToolWindow  +LastFound -DPIScale ;provided from rommmcek 10/23/16
   ; WinSet, Transparent, 50
   Gui ActGuide: Color, Blue
   WinSet, TransColor, Blue 150,

   Gui ActGuide: Show, x1500 y200 w300 h600 NA

   Gui ActGuide:Add, Text,, Please enter your name:

}

DestroyActGuide(){
   Try Gui ActGuide: Destroy
}
