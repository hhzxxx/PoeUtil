#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#include %A_ScriptDir%\init.ahk
#include %A_ScriptDir%\work.ahk

Gui, Add, Tab3,, General|Settings

Gui, Tab, 1 
Gui, Add, CheckBox, vTuiBian, 蜕变
Gui, Add, CheckBox, vGaiZao, 改造
Gui, Add, CheckBox, vZengFu ys+24 x+10, 增幅
Gui, Add, CheckBox, vFuHao , 富豪
Gui, Add, CheckBox, vChongZhu ys+24 x+10, 重铸
Gui, Add, CheckBox, vDianJin, 点金
Gui, Add, CheckBox, vHunDun ys+24 x+10, 混沌
Gui, Add, CheckBox, vChongGao, 崇高

Gui, Add, Text,xs+10 y+15 , 至少:
Gui, Add, Edit,ys+65 x+10 ReadOnly w60
Gui, Add, UpDown, vMin Range1-4 , 1
Gui, Add, Button, Default w40 x+20 , Save
Gui, Add, Button, Default w40 x+20 , Load

Gui, Add, Edit, vName1 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName2 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName3 w240 Limit50 xs+10 y+10, 
Gui, Add, Edit, vName4 w240 Limit50 xs+10 y+10, 


Gui, Tab, 2 
Gui, Add, CheckBox,  vTopCheckBox gTopCheck , 置顶

Gui, Tab,  
Gui, Add, Button, Default w80 , OK 
Gui, Add, Button, Default w80 x+ , Reload

; Gui, Add, StatusBar,, Bar's starting text (omit to start off empty).
; SB_SetText("没有加载 " . RowCount . " rows selected.")

InitConfig()
Gui, Show,AutoSize
return

ButtonOK:
Gui, Submit,NoHide
genMatchStr(Name1,Name2,Name3,Name4,Min)
return

ButtonSave:
Gui, Submit,NoHide
Gui +OwnDialogs
InputBox, UserInput, 保存, 输入配置名, , 120, 120
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
Gui, MyGui:Destroy
Gui, MyGui:Add, ListView, r20 w400 gMyListView, 配置名|至少|词缀1|词缀2|词缀3|词缀4
Gui, MyGui:Default
;获取段名列表
IniRead, OutputVarSectionNames, %A_ScriptDir%\config.ini
Array := StrSplit(OutputVarSectionNames , "`n")
For index, value in Array
    if(value != "Config"){
        LV_Add("", value, ConfigGet("Min",value),  ConfigGet("Name1",value), ConfigGet("Name2",value), ConfigGet("Name3",value), ConfigGet("Name4",value))
    }

LV_ModifyCol(1,80)  ; 根据内容自动调整每列的大小.
LV_ModifyCol(2,60)  ; 根据内容自动调整每列的大小.
LV_ModifyCol(3,60)  ; 根据内容自动调整每列的大小.
LV_ModifyCol(4,60)  ; 根据内容自动调整每列的大小.
LV_ModifyCol(5,60)  ; 根据内容自动调整每列的大小.
LV_ModifyCol(6,60)  ; 根据内容自动调整每列的大小.
Gui, MyGui:Show
return

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    LV_GetText(RowText, A_EventInfo)  ; 从行的第一个字段中获取文本.
    Gui, MyGui:Destroy
    LoadData(RowText)
}
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






