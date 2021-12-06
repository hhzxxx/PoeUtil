#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

global DefaultGui := ""
global NowSection := ""
global xpos:= 0
global ypos:= 0
global getPosType:= 0

#include %A_ScriptDir%\init.ahk
#include %A_ScriptDir%\work.ahk
#include %A_ScriptDir%\DoWork.ahk

Gui, Add, Tab3,, General|Settings

Gui, Tab, 1 
Gui, Add, CheckBox, vTuiBian, 蜕变
Gui, Add, CheckBox, vGaiZao, 改造
Gui, Add, CheckBox, vZengFu ys+30 x+10, 增幅
Gui, Add, CheckBox, vFuHao , 富豪
Gui, Add, CheckBox, vChongZhu ys+30 x+10, 重铸
Gui, Add, CheckBox, vDianJin, 点金
Gui, Add, CheckBox, vHunDun ys+30 x+10, 混沌
Gui, Add, CheckBox, vJiHui , 机会

Gui, Add, Text,xs+10 y+15 , 至少:
Gui, Add, Edit,x+20 ReadOnly w60
Gui, Add, UpDown, vMin Range1-4 , 1
Gui, Add, Button, Default w40 x+20 , Save
Gui, Add, Button, Default w40 x+20 , Load

Gui, Add, Edit, vName1 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName2 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName3 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName4 w240 Limit50 xs+10 y+10, 

Gui, Tab, 2 
Gui, Add, CheckBox, vTopCheckBox gTopCheck , 置顶
Gui, Add, Button, Default w50 gLeftTop, 左上 
Gui, Add, Button, Default w50 gRightBottom, 右下 
Gui, Add, Button, Default w50 gDianJinPos, 点金
Gui, Add, Button, Default w50 gTuiBianPos, 蜕变
Gui, Add, Button, Default w50 gGaiZaoPos, 改造
Gui, Add, Button, Default w50 gZengFuPos, 增幅
Gui, Add, Edit, ys+60 x+10 vLeftTopXY w60 +ReadOnly
Gui, Add, Edit, vRightBottomXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vDianJinXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vTuiBianXY w60 y+10 +ReadOnly
Gui, Add, Edit, vGaiZaoXY w60 y+10 +ReadOnly
Gui, Add, Edit, vZengFuXY w60 y+10 +ReadOnly

Gui, Add, Button, Default w50 gFuHaoPos ys+60 x+10, 富豪 
Gui, Add, Button, Default w50 gHunDunPos, 混沌 
Gui, Add, Button, Default w50 gChongZhuPos, 重铸
Gui, Add, Button, Default w50 gJiHuiPos, 机会
Gui, Add, Edit, ys+60 x+10 vFuHaoXY w60 +ReadOnly
Gui, Add, Edit, vHunDunXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vChongZhuXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vJiHuiXY w60 y+10 +ReadOnly 
Gui, Tab, 
Gui, Add, Button, Default w80 , OK 
Gui, Add, Button, Default w80 x+ , Reload

; Gui, Add, StatusBar,, Bar's starting text (omit to start off empty).
; SB_SetText("没有加载 " . RowCount . " rows selected.")

InitConfig()
Gui, Show,AutoSize
DefaultGui = %A_DefaultGui%
return

ButtonOK:
  Gui, Submit,NoHide
  StartWork()
  SetTimer, TimerWork, Off
  SetTimer, TimerWork, 20
  ; genMatchStr(Name1,Name2,Name3,Name4,Min)
return

ButtonSave:
  Gui, Submit,NoHide
  Gui +OwnDialogs
  InputBox, UserInput, 保存, 输入配置名, , 120, 120,,,,,%NowSection%
  if not ErrorLevel
  if(StrLen(Trim(UserInput))>0){
    sectionName := Trim(UserInput)
    if(sectionName = "Config"){
      MsgBox ,不允许使用Config
      return
    }
    if(StrLen(ConfigSectionGet(sectionName))>0){
      MsgBox, 4, , 是否覆盖 
      IfMsgBox Yes
      DoSave(sectionName)
    }else{
      DoSave(sectionName)
    }
  }
return

ButtonLoad:
  ListViewAdd()
return

ListViewAdd(){
  Gui, MyGui:Destroy
  MouseGetPos, xpos, ypos,
  Gui, MyGui:Add, ListView, r20 w400 gMyListView, 配置名|至少|词缀1|词缀2|词缀3|词缀4
  Gui, MyGui:Default
  ;获取段名列表
  IniRead, OutputVarSectionNames, %A_ScriptDir%\config.ini
  Array := StrSplit(OutputVarSectionNames , "`n")
  For index, value in Array
  if(value != "Config"){
    LV_Add("", value, ConfigGet("Min",value), ConfigGet("Name1",value), ConfigGet("Name2",value), ConfigGet("Name3",value), ConfigGet("Name4",value))
  }

  LV_ModifyCol(1,80) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(2,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(3,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(4,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(5,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(6,60) ; 根据内容自动调整每列的大小.
  Gui, MyGui:Show
}

MyListView:
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    Gui, MyGui:Destroy
    Gui, %DefaultGui%:Default
    NowSection = %RowText%
    LoadData(RowText,DefaultGui)
  }
  if (A_GuiEvent = "R")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    MsgBox, 4, , 确认删除 
    IfMsgBox Yes
    DoDelete(RowText)
    ListViewAdd()
  }

return

LeftTop:
  StartGetPos(1)
return

RightBottom:
  StartGetPos(2)
return

DianJinPos:
  ImgSearch(3)
return

TuiBianPos:
  ImgSearch(4)
return

GaiZaoPos:
  ImgSearch(5)
return

ZengFuPos:
  ImgSearch(6)
return

FuHaoPos:
  ImgSearch(7)
return

HunDunPos:
  ImgSearch(8)
return

ChongZhuPos:
  ImgSearch(9)
return

JiHuiPos:
  ImgSearch(10)
return

StartGetPos(type){
  ToolTip, 开始获取
  getPosType = %type%
  gnPressCount := 0
  Hotkey, ^!p,, UseErrorLevel
  if ErrorLevel not in 5,6
    Hotkey, ~LButton , off
  Hotkey, ~LButton , GetCursor, on
}

GetCursor:
  gnPressCount += 1
  SetTimer, ProcSubroutine, Off
  SetTimer, ProcSubroutine, 300
return

TopCheck:
  AlwaysOnTopFlag := ConfigGet("AlwaysOnTopFlag")
  if(AlwaysOnTopFlag = 0){
    AlwaysOnTopFlag:=1
    ConfigSet("AlwaysOnTopFlag",1)
    Gui +AlwaysOnTop
  }Else{
    AlwaysOnTopFlag:=0
    ConfigSet("AlwaysOnTopFlag",0)
    Gui -AlwaysOnTop
  }
return

ButtonReload:
  Reload
return

GuiClose:
ExitApp

gnPressCount := 0
ProcSubroutine:
  {
    WinActivate, Path of Exile
    ; 在计时器事件触发时，需要将其关掉
    SetTimer, ProcSubroutine, Off
    If gnPressCount = 1
    {
      ; 第一类行为
      ;MsgBox, 触发单击鼠标右键事件
    }Else If gnPressCount = 2
    {
      gnPressCount := 0
      ; 第二类行为
      MouseGetPos, xpos, ypos,id, control
      WinGetTitle, title, ahk_id %id%
      if(title = "Path of Exile"){
        Hotkey, ~LButton , off
        Gui, %DefaultGui%:Default
        SavePos(xpos,ypos,getPosType)
      }
    }Else
    {
      ;MsgBox, 触发三击鼠标右键事件
    }
    ; 在结束后，还需要将鼠标右键的按键次数置为0，以方便下次使用
    gnPressCount := 0
    Return
  }

#F1::
  Gui, Submit,NoHide
  SetTimer, TimerWork, Off
return

TimerWork:
  if(WinActive("Path of Exile")){
    type := itemList.Pop()
    itemList.InsertAt(0,type)
    res := Use(type)
    if(res != 0){
      ToolTip, success
      SetTimer, TimerWork, Off
    }
  }Else{
    WinActivate, Path of Exile
  }
return