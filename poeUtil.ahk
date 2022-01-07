#SingleInstance, force
#NoEnv 
SendMode Input
SetWorkingDir, %A_ScriptDir%
OnExit("ExitFunc")
OnMessage(0x0203, "WM_LBUTTONDBLCLK") ;double click to downsize. Double click again to resize.
#Persistent
#include %A_ScriptDir%\jietu.ahk 


global DefaultGui := ""
global NowSection := ""
global xpos:= 0
global ypos:= 0
global getPosType:= 0

#include %A_ScriptDir%\init.ahk


Gui, Add, Tab3,gTabChange vTabName, 做装|设置|吃药|标价|导航|脚本

Gui, Tab, 1 
Gui, Add, CheckBox, vTuiBian, 蜕变
Gui, Add, CheckBox, vGaiZao, 改造
Gui, Add, CheckBox, vZengFu ys+30 x+1, 增幅
Gui, Add, CheckBox, vFuHao , 富豪
Gui, Add, CheckBox, vChongZhu ys+30 x+1, 重铸
Gui, Add, CheckBox, vDianJin, 点金
Gui, Add, CheckBox, vHunDun ys+30 x+1, 混沌
Gui, Add, CheckBox, vJiHui , 机会
Gui, Add, CheckBox, vGaoDianJin ys+30 x+1, 高阶

Gui, Add, Text,xs+10 y+25 , 至少:
Gui, Add, Edit,x+20 ReadOnly w60
Gui, Add, UpDown, vMin Range1-4 , 1
Gui, Add, Button, Default w40 x+20 , Save
Gui, Add, Button, Default w40 x+20 , Load

Gui, Add, Edit, vName1 w180 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName2 w180 Limit50 xs+10 y+6, 
Gui, Add, Edit, vName3 w180 Limit50 xs+10 y+6, 
Gui, Add, Edit, vName4 w180 Limit50 xs+10 y+6, 
Gui, Add, Edit, vName5 w180 Limit50 xs+10 y+6, 
Gui, Add, Edit, vName6 w180 Limit50 xs+10 y+6, 

Gui, Add, DropDownList, vName1Type w55 ys+110 x+5 AltSubmit, 任意||前缀|后缀|必须
Gui, Add, DropDownList, vName2Type w55 y+10 AltSubmit, 任意||前缀|后缀|必须
Gui, Add, DropDownList, vName3Type w55 y+10 AltSubmit, 任意||前缀|后缀|必须
Gui, Add, DropDownList, vName4Type w55 y+10 AltSubmit, 任意||前缀|后缀|必须
Gui, Add, DropDownList, vName5Type w55 y+10 AltSubmit, 任意||前缀|后缀|必须
Gui, Add, DropDownList, vName6Type w55 y+10 AltSubmit, 任意||前缀|后缀|必须

Gui, Tab, 2 
Gui, Add, CheckBox, vTopCheckBox gTopCheck , 置顶
Gui, Add, Button, Default w50 gLeftTop, 左上 
Gui, Add, Button, Default w50 gRightBottom, 右下 
Gui, Add, Button, Default w50 gDianJinPos, 点金
Gui, Add, Button, Default w50 gTuiBianPos, 蜕变
Gui, Add, Button, Default w50 gGaiZaoPos, 改造
Gui, Add, Button, Default w50 gZengFuPos, 增幅
Gui, Add, Edit, ys+55 x+10 vLeftTopXY w60 +ReadOnly
Gui, Add, Edit, vRightBottomXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vDianJinXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vTuiBianXY w60 y+10 +ReadOnly
Gui, Add, Edit, vGaiZaoXY w60 y+10 +ReadOnly
Gui, Add, Edit, vZengFuXY w60 y+10 +ReadOnly

Gui, Add, Button, Default w50 gFuHaoPos ys+55 x+10, 富豪 
Gui, Add, Button, Default w50 gHunDunPos, 混沌 
Gui, Add, Button, Default w50 gChongZhuPos, 重铸
Gui, Add, Button, Default w50 gJiHuiPos, 机会
Gui, Add, Button, Default w50 gGaoDianJinPos, 高阶点金
Gui, Add, Edit, ys+55 x+10 vFuHaoXY w60 +ReadOnly
Gui, Add, Edit, vHunDunXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vChongZhuXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vJiHuiXY w60 y+10 +ReadOnly 
Gui, Add, Edit, vGaoDianJinXY w60 y+10 +ReadOnly 

Gui, Add, Button, Default w100 gPosSet xs+10 y+80, 设置

Gui, Tab, 4
Gui, Add, Picture,  vMyPic ,
Gui, Add, Edit, vPrice w180 Limit50 xs+10 y+180, 
Gui, Add, Button, Default w100 gAddItemPic xs+10 y+20, 添加物品
Gui, Add, Button, Default w100 gPutItemPic x+10, 开始标价
Gui, Add, Button, Default w100 gTestPrice xs+10 y+20, 测试价格
Gui, Add, Button, Default w100 gTestSubmit x+10, 测试按钮

Gui, Tab, 5
Gui, Add, Button, Default w100 gAct1, ACT1
Gui, Add, Button, Default w100 gAct2, ACT2
Gui, Add, Button, Default w100 gAct3, ACT3
Gui, Add, Button, Default w100 gAct4, ACT4
Gui, Add, Button, Default w100 gAct5, ACT5

Gui, Add, Button, Default w100 gAct6 ys+30 x+1, ACT6
Gui, Add, Button, Default w100 gAct7, ACT7
Gui, Add, Button, Default w100 gAct8, ACT8
Gui, Add, Button, Default w100 gAct9, ACT9
Gui, Add, Button, Default w100 gAct10, ACT10
Gui, Add, Edit, vShopText gShopTextEdit r6  w250 Limit100 xs+10 y+10, 
Gui, Add, Button, Default w100 gDestoryAct, 关闭

Gui, Tab, 6
Gui, Add, ListView, r15 w250 vScriptListViewName gScriptListView Checked AltSubmit, 名称|状态

Gui, Tab, 
Gui, Add, Button, Default w80 , OK 
Gui, Add, Button, Default w80 x+100 , Reload
Gui, Add, StatusBar,, 没有加载配置.


InitConfig()
WinGetPos, X, Y, W, H, ahk_exe Explorer.EXE
xx := % Ceil(W/5)*3
xx = x%xx%
Gui, Show,AutoSize yCenter %xx%
DefaultGui = %A_DefaultGui%
return

ButtonOK:
  Gui, Submit,NoHide
  StartWork()
  SetTimer, TimerWork, Off
  SetTimer, TimerWork, 20
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
      {
        DoSave(sectionName)
        SBSetText(sectionName)
      }
    }else{
      DoSave(sectionName)
      SBSetText(sectionName)
    }
  }
return

TabChange:
Gui, Submit, NoHide
if(TabName = "脚本"){
  initScriptList()
}
return

ButtonLoad:
  ListViewAdd()
return

ListViewAdd(){
  Gui, MyGui:Destroy
  MouseGetPos, xpos, ypos,
  Gui, MyGui:Add, ListView, r20 w400 gMyListView, 配置名|至少|词缀1|词缀2|词缀3|词缀4|词缀5|词缀6|
  Gui, MyGui:Default
  ;获取段名列表
  IniRead, OutputVarSectionNames, %A_ScriptDir%\config.ini
  Array := StrSplit(OutputVarSectionNames , "`n")
  For index, value in Array
  if(value != "Config" and value != "checkStatus" and value != "scriptList"){
    LV_Add("", value, ConfigGet("Min",value), ConfigGet("Name1",value), ConfigGet("Name2",value), ConfigGet("Name3",value), ConfigGet("Name4",value), ConfigGet("Name5",value), ConfigGet("Name6",value))
  }

  LV_ModifyCol(1,80) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(2,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(3,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(4,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(5,60) ; 根据内容自动调整每列的大小.
  LV_ModifyCol(6,60) ; 根据内容自动调整每列的大小.
  Gui, MyGui:Show
}

global myFileName := "Capture"

AddItemPic:
myFileName := "Capture"
Hotkey, Lbutton, jietuLabel
Hotkey, Lbutton, jietuLabel,On
Return

PutItemPic:
GuiControlGet, Price
if(Price){
  ToolTip, start
  putPrice(Price)
}
return

TestPrice:
myFileName := "111"
Hotkey, Lbutton, jietuLabel
Hotkey, Lbutton, jietuLabel,On
return

TestSubmit:
myFileName := "222"
Hotkey, Lbutton, jietuLabel
Hotkey, Lbutton, jietuLabel,On
return

jietuLabel:
try {
  flag := SCW_ScreenClip2Win(0) ; set to 1 to auto-copy to clipboard
  if(flag != 0){
    WinActivate, ScreenClippingWindow ahk_class AutoHotkeyGUI
    IfWinActive,  ScreenClippingWindow ahk_class AutoHotkeyGUI
    {
      SCW_Win2FileNoFrom(0,myFileName)
    }
    Hotkey, Lbutton, jietuLabel,Off
    Gui, %DefaultGui%:Default
    if(myFileName = "Capture"){
      src := % A_ScriptDir "\pic\Capture.png"
      global itemSrc := % src
      GuiControl,, MyPic, *w120 *h-1 %src%
    }
  }else{
    Hotkey, Lbutton, jietuLabel,Off
    MsgBox, 区域太大或太小
  }
} catch e {
  Hotkey, Lbutton, jietuLabel,Off
  IfWinActive,  ScreenClippingWindow ahk_class AutoHotkeyGUI
    winclose, A
  MsgBox, error
}
Hotkey, Lbutton, jietuLabel,Off
IfWinActive,  ScreenClippingWindow ahk_class AutoHotkeyGUI
  winclose, A

return


MyListView:
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    if(A_EventInfo > 0){
      Gui, MyGui:Destroy
      Gui, %DefaultGui%:Default
      NowSection = %RowText%
      SBSetText(NowSection)
      LoadData(RowText,DefaultGui)
    }
  }
  if (A_GuiEvent = "R")
  {
    LV_GetText(RowText, A_EventInfo) ; 从行的第一个字段中获取文本.
    if(A_EventInfo > 0){
      MsgBox, 4, ,% "确认删除 " RowText "?"
      IfMsgBox Yes
      {
        DoDelete(RowText)
        ListViewAdd()
      }
    }
  }

return

PosSet:
  Try Gui SetGui: Destroy
  Try Gui SetGui: +AlwaysOnTop  +Border -ToolWindow +LastFound -DPIScale +Resize
  Gui SetGui: Show, x100 y50 w900 h50 NA
  Gui, SetGui:Add, Button, Default w100 gSelectArea, 选择区域
  Gui, SetGui:Add, Button, Default y12 w75 gItemBox, 物品框  
  Gui, SetGui:Add, Button, Default y12 w50 gSelect3, 点金
  Gui, SetGui:Add, Button, Default y12 w50 gSelect4, 蜕变
  Gui, SetGui:Add, Button, Default y12 w50 gSelect5, 改造
  Gui, SetGui:Add, Button, Default y12 w50 gSelect6, 增幅
  Gui, SetGui:Add, Button, Default y12 w50 gSelect7, 富豪
  Gui, SetGui:Add, Button, Default y12 w50 gSelect8, 混沌
  Gui, SetGui:Add, Button, Default y12 w50 gSelect9, 重铸
  Gui, SetGui:Add, Button, Default y12 w50 gSelect10, 机会
  Gui, SetGui:Add, Button, Default y12 w100 gSelect11, 高阶点金  
return

SelectArea:
Hotkey, Lbutton, SelectAreaLabel,On
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键点击选择区域，右键取消
return

ItemBox:
StartGetPos(666)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select3:
StartGetPos(3)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select4:
StartGetPos(4)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select5:
StartGetPos(5)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select6:
StartGetPos(6)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select7:
StartGetPos(7)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select8:
StartGetPos(8)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select9:
StartGetPos(9)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select10:
StartGetPos(10)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

Select11:
StartGetPos(11)
Hotkey, Rbutton, CancleSelectAreaLabel,On
ToolTip,左键双击选择坐标，右键取消 
return

CancleSelectAreaLabel:
ToolTip
Hotkey, ~LButton , off
Hotkey, Lbutton, SelectAreaLabel,Off
Hotkey, Rbutton, CancleSelectAreaLabel,Off
return

SelectAreaLabel:
  ToolTip
  MouseGetPos, , , id, control
  WinActivate, ahk_id %id%
  MouseGetPos, MX, MY
  c := "Blue"
  t := "50"
  g := "99" 
  Try Gui %g%: Destroy
  Try Gui %g%: +AlwaysOnTop -caption +Border +ToolWindow +LastFound -DPIScale ;provided from rommmcek 10/23/16

  WinSet, Transparent, %t%
  Gui %g%: Color, %c%
  Hotkey := RegExReplace(A_ThisHotkey,"^(\w* & |\W*)")
  While, (GetKeyState(Hotkey, "p"))
  {
    MouseGetPos, MXend, MYend
    w := abs(MX - MXend), h := abs(MY - MYend)
    X := (MX < MXend) ? MX : MXend
    Y := (MY < MYend) ? MY : MYend
    Gui %g%: Show, x%X% y%Y% w%w% h%h% NA
    Sleep, 10
  }
  MouseGetPos, MXend, MYend
  If ( MX > MXend )
  temp := MX, MX := MXend, MXend := temp
  If ( MY > MYend )
  temp := MY, MY := MYend, MYend := temp

  Hotkey, Lbutton, SelectAreaLabel,Off
  Hotkey, Rbutton, CancleSelectAreaLabel,Off
  MsgBox, 4100 , ,% "确认?"
  Try Gui %g%: Destroy
  IfMsgBox No
  {
    Hotkey, Lbutton, SelectAreaLabel,On
    Hotkey, Rbutton, CancleSelectAreaLabel,On
  }Else{
    Gui, %DefaultGui%:Default
    SavePos(MX,MY,1)
    SavePos(MXend,MYend,2)
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

GaoDianJinPos:
  ImgSearch(11)
return
StartGetPos(type){
  try Hotkey, ~LButton , off
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
      ; if(title = "Path of Exile"){
        ToolTip
        Hotkey, ~LButton , off
        Gui, %DefaultGui%:Default
        SavePos(xpos,ypos,getPosType)
      ; }
    }Else
    {
      ;MsgBox, 触发三击鼠标右键事件
    }
    ; 在结束后，还需要将鼠标右键的按键次数置为0，以方便下次使用
    gnPressCount := 0
    Return
  }

F1::
  Gui, Submit,NoHide
  SetTimer, TimerWork, Off
return

TimerWork:
  if(WinExist("Path of Exile")){
    if(WinActive("Path of Exile")){
      type := itemList.Pop()
      itemList.InsertAt(0,type)
      res := Use(type)
      if(res != 0){
        ToolTip, success
        SetTimer, RemoveToolTip,-1000
        SetTimer, TimerWork, Off
      }
    }Else{
      WinActivate, Path of Exile
    }
  }else{
    SetTimer, TimerWork, Off
  }
return

SBSetText(text){
  SB_SetText("    " . text . "")
}

RemoveToolTip:
ToolTip
return

#include %A_ScriptDir%\core\ActGuide.ahk 
#include %A_ScriptDir%\core\ScriptListView.ahk 
#include %A_ScriptDir%\work.ahk
#include %A_ScriptDir%\DoWork.ahk
#include %A_ScriptDir%\putPrice.ahk



ExitFunc(ExitReason, ExitCode)
{
    if ExitReason in Reload
    {
        ; MsgBox, 4, , 123123t?
        ; IfMsgBox, No
        ;     return 1  ; OnExit 函数必须返回非零值来防止退出.
    }else 
    {
        MsgBox, 4, , Are you sure you want to exit?
        IfMsgBox, No
            return 1  ; OnExit 函数必须返回非零值来防止退出.
        closeScripts()
    }
    ; 不要调用 ExitApp -- 那会阻止其他 OnExit 函数被调用.
}


WM_LBUTTONDBLCLK() { 
   global
   WinGetTitle, title ,A
   WinGet, TempID, , A
   WinGetPos, , , Temp_Width, Temp_Height, A 
  if(title = "poeUtil.ahk"){
    clipboard := ConfigGet("ShopText")
    If (Temp_Width = 80 && Temp_Height = 80) {
        WinMove, A, , , , % %TempID%_Width, % %TempID%_Height
    } else {
    %TempID%_Width := Temp_Width
    %TempID%_Height := Temp_Height
    WinMove, A, , , , 80, 80
    }  
   }
}