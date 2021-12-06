#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

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
  GuiControlGet, JiHui
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
  ConfigSet("JiHui",JiHui,sectionName)
}

DoDelete(sectionName){
  ConfigDelete(sectionName)
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
  GuiControl,, JiHui , % ConfigGet("JiHui",RowText)
}

ImgSearch(type){
  WinActivate, Path of Exile
  Sleep, 300
  src := % A_ScriptDir "\pic\" type ".png"
  ImageSearch, FoundX, FoundY, % ConfigGet("LTopX"), % ConfigGet("LTopY"), % ConfigGet("RBottomX"), % ConfigGet("RBottomY"),%src%
  if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
  else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
  else
    SavePos(FoundX,FoundY,type)
}

SavePos(xpos,ypos,type){
  ; SetTimer, RemoveToolTip, -3000
  if(type = 1){ ;左上坐标
    ConfigSet("LTopX",xpos)
    ConfigSet("LTopY",ypos)
    GuiControl,, LeftTopXY , % xpos " " ypos

  }
  if(type = 2){ ;右下坐标
    ConfigSet("RBottomX",xpos)
    ConfigSet("RBottomY",ypos)
    GuiControl,, RightBottomXY , % xpos " " ypos
  }
  if(type = 3){ ;点金
    ConfigSet("DianJinX",xpos)
    ConfigSet("DianJinY",ypos)
    GuiControl,, DianJinXY , % xpos " " ypos
  }
  if(type = 4){ ;蜕变
    ConfigSet("TuiBianX",xpos)
    ConfigSet("TuiBianY",ypos)
    GuiControl,, TuiBianXY , % xpos " " ypos
  }
  if(type = 5){ ;改造
    ConfigSet("GaiZaoX",xpos)
    ConfigSet("GaiZaoY",ypos)
    GuiControl,, GaiZaoXY , % xpos " " ypos
  }
  if(type = 6){ ;增幅
    ConfigSet("ZengFuX",xpos)
    ConfigSet("ZengFuY",ypos)
    GuiControl,, ZengFuXY , % xpos " " ypos
  }
  if(type = 7){ ;富豪
    ConfigSet("FuHaoX",xpos)
    ConfigSet("FuHaoY",ypos)
    GuiControl,, FuHaoXY , % xpos " " ypos
  }
  if(type = 8){ ;混沌
    ConfigSet("HunDunX",xpos)
    ConfigSet("HunDunY",ypos)
    GuiControl,, HunDunXY , % xpos " " ypos
  }
  if(type = 9){ ;重铸
    ConfigSet("ChongZhuX",xpos)
    ConfigSet("ChongZhuY",ypos)
    GuiControl,, ChongZhuXY , % xpos " " ypos
  }
  if(type = 10){ ;机会 
    ConfigSet("JiHuiX",xpos)
    ConfigSet("JiHuiY",ypos)
    GuiControl,, JiHuiXY , % xpos " " ypos
  }
  WinActivate,PoeUtil
}

; RemoveToolTip:
; ToolTip
; return