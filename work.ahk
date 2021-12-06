#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

genMatchStr(Name1,Name2,Name3,Name4,Min){
    strList := []
    strListLength := 0
    if(StrLen(Trim(Name1))>0){
        strListLength+=1
        strList.Push(Trim(Name1))
    }
    if(StrLen(Trim(Name2))>0){
        strListLength+=1
        strList.Push(Trim(Name2))
    }
    if(StrLen(Trim(Name3))>0){
        strListLength+=1
        strList.Push(Trim(Name3))
    }
    if(StrLen(Trim(Name4))>0){
        strListLength+=1
        strList.Push(Trim(Name4))
    }
    RegList := []
    if(Min > strListLength){
        Min := strListLength
    }
    if(Min = 0){
        return 
    }

    Haystack:= Clipboard

    matchCount := 0
    matchRes :=""
    For index, value in strList
        if(InStr(Haystack, value)){
            matchCount += 1
            matchRes = %matchRes%  %value%
        }
    if(matchCount >= Min){
        Msgbox % matchRes
    }
}

DoSave(sectionName){
    GuiControlGet, Min
    GuiControlGet, Name1
    GuiControlGet, Name2
    GuiControlGet, Name3
    GuiControlGet, Name4
    ConfigSet("Min",Min,sectionName)
    ConfigSet("Name1",Name1,sectionName)
    ConfigSet("Name2",Name2,sectionName)
    ConfigSet("Name3",Name3,sectionName)
    ConfigSet("Name4",Name4,sectionName)
}

LoadData(RowText){
    GuiControl,, TopCheckBox , ("Min",RowText)
    GuiControl,, TopCheckBox , ("Name1",RowText)
    GuiControl,, TopCheckBox , ("Name2",RowText)
    GuiControl,, TopCheckBox , ("Name3",RowText)
    GuiControl,, TopCheckBox , ("Name4",RowText)
}

