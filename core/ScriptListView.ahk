#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

global initFlag := false

ScriptListView:
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    if(A_EventInfo > 0){
        pid := ConfigGet(RowText,"scriptList")
        flag := false
        if(pid){
            Process, Close , %pid%
            Process, WaitClose, %pid% 
            if( ErrorLevel = 0){
                flag = true
            }
        }else{
            flag = true
        }
        if(flag){
            Run, %A_ScriptDir%\scripts\%RowText% ,,,outPid
            if(outPid){
                ConfigSet(RowText,outPid,"scriptList")
                LV_Modify(A_EventInfo , , RowText, outPid)
            }
        }
    }
  }
  if (A_GuiEvent = "R")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    if(A_EventInfo > 0){
        pid := ConfigGet(RowText,"scriptList")
        flag := false
        if(pid){
            Process, Close , %pid%
        }
        ConfigSet(RowText,0,"scriptList") 
        LV_Modify(A_EventInfo , , RowText, 0)
    }
  }
  if (A_GuiEvent = "I" and initFlag = false)
  {
      if(InStr(ErrorLevel, "C", true) or InStr(ErrorLevel, "c", true)){
        LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
        if(A_EventInfo > 0){
            checkStatus := ConfigGet(RowText,"checkStatus")
            if(checkStatus){
                ConfigSet(RowText,0,"checkStatus") 
            }Else{
                ConfigSet(RowText,1,"checkStatus") 
            }
        }
      }
  }
return

initScriptList(){
    global initFlag:= true
    LV_Delete()

    LV_ModifyCol(1,180) 
    LV_ModifyCol(2,60) 

    Loop, %A_ScriptDir%\scripts\*.*
    {
        pid := ConfigGet(A_LoopFileName,"scriptList")
        checkStatus := ConfigGet(A_LoopFileName,"checkStatus")
        Process, Exist , %pid%
        if(ErrorLevel = 0){
            ConfigSet(A_LoopFileName,0,"scriptList")
            pid := 0
        }
        if(checkStatus){
            global initFlag:= true
            LV_Add("Check", A_LoopFileName, pid)
        }Else{
            LV_Add("", A_LoopFileName, pid)
        }
    }
    Sleep, 100
    global initFlag:= false
}

closeScripts(){
    Loop, %A_ScriptDir%\scripts\*.*
    {
        pid := ConfigGet(A_LoopFileName,"scriptList")
        if(pid){
            Process, Close , %pid%
            ConfigSet(A_LoopFileName,0,"scriptList")
        }
    }
}
