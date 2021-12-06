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
    GuiControlGet, TuiBian
    GuiControlGet, GaiZao
    GuiControlGet, ZengFu
    GuiControlGet, FuHao
    GuiControlGet, ChongZhu
    GuiControlGet, DianJin
    GuiControlGet, HunDun
    GuiControlGet, ChongGao
    ConfigSet("Min",Min,sectionName)
    ConfigSet("Name1",Name1,sectionName)
    ConfigSet("Name2",Name2,sectionName)
    ConfigSet("Name3",Name3,sectionName)
    ConfigSet("Name4",Name4,sectionName)
    ConfigSet("TuiBian",TuiBian,sectionName)
    ConfigSet("GaiZao",GaiZao,sectionName)
    ConfigSet("ZengFu",ZengFu,sectionName)
    ConfigSet("FuHao",FuHao,sectionName)
    ConfigSet("ChongZhu",ChongZhu,sectionName)
    ConfigSet("DianJin",DianJin,sectionName)
    ConfigSet("HunDun",HunDun,sectionName)
    ConfigSet("ChongGao",ChongGao,sectionName)
}

LoadData(RowText,DefaultGui){
    GuiControl,, Min , % ConfigGet("Min",RowText)
    GuiControl,, Name1 , % ConfigGet("Name1",RowText)
    GuiControl,, Name2 , % ConfigGet("Name2",RowText)
    GuiControl,, Name3 , % ConfigGet("Name3",RowText)
    GuiControl,, Name4 , % ConfigGet("Name4",RowText)
    GuiControl,, TuiBian , % ConfigGet("TuiBian",RowText)
    GuiControl,, GaiZao , % ConfigGet("GaiZao",RowText)
    GuiControl,, ZengFu , % ConfigGet("ZengFu",RowText)
    GuiControl,, FuHao , % ConfigGet("FuHao",RowText)
    GuiControl,, ChongZhu , % ConfigGet("ChongZhu",RowText)
    GuiControl,, DianJin , % ConfigGet("DianJin",RowText)
    GuiControl,, HunDun , % ConfigGet("HunDun",RowText)
    GuiControl,, ChongGao , % ConfigGet("ChongGao",RowText)
}

