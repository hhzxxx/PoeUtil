﻿#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

Gui, New , Resize , PoeUtil
gui, font, s10, Verdana
InitConfig(){
  if (FileExist(A_ScriptDir . "/config.ini")){
    AlwaysOnTopFlag := ConfigGet("AlwaysOnTopFlag")
    if(AlwaysOnTopFlag = 1){
      GuiControl,, TopCheckBox , 1
      Gui +AlwaysOnTop
    }Else{
      GuiControl,, TopCheckBox , 0
      Gui -AlwaysOnTop
    }

    if(ConfigGet("LTopX") and ConfigGet("LTopY")){
      GuiControl,, LeftTopXY , % ConfigGet("LTopX") " " ConfigGet("LTopY")
    }
    if(ConfigGet("RBottomX") and ConfigGet("RBottomY")){
      GuiControl,, RightBottomXY , % ConfigGet("RBottomX") " " ConfigGet("RBottomY")
    }
    if(ConfigGet("DianJinX") and ConfigGet("DianJinY")){
      GuiControl,, DianJinXY , % ConfigGet("DianJinX") " " ConfigGet("DianJinY")
    }
    if(ConfigGet("TuiBianX") and ConfigGet("TuiBianY")){
      GuiControl,, TuiBianXY , % ConfigGet("TuiBianX") " " ConfigGet("TuiBianY")
    }
    if(ConfigGet("GaiZaoX") and ConfigGet("GaiZaoY")){
      GuiControl,, GaiZaoXY , % ConfigGet("GaiZaoX") " " ConfigGet("GaiZaoY")
    }
    if(ConfigGet("ZengFuX") and ConfigGet("ZengFuY")){
      GuiControl,, ZengFuXY , % ConfigGet("ZengFuX") " " ConfigGet("ZengFuY")
    }
    if(ConfigGet("FuHaoX") and ConfigGet("FuHaoY")){
      GuiControl,, FuHaoXY , % ConfigGet("FuHaoX") " " ConfigGet("FuHaoY")
    }
    if(ConfigGet("HunDunX") and ConfigGet("HunDunY")){
      GuiControl,, HunDunXY , % ConfigGet("HunDunX") " " ConfigGet("HunDunY")
    }
    if(ConfigGet("ChongZhuX") and ConfigGet("ChongZhuY")){
      GuiControl,, ChongZhuXY , % ConfigGet("ChongZhuX") " " ConfigGet("ChongZhuY")
    }
    if(ConfigGet("JiHuiX") and ConfigGet("JiHuiY")){
      GuiControl,, JiHuiXY , % ConfigGet("JiHuiX") " " ConfigGet("JiHuiY")
    }

  }Else{
    FileAppend,, %A_ScriptDir%\config.ini,UTF-8
    ConfigSet("AlwaysOnTopFlag",0)
  }
}

ConfigSet(key,value,SectionName := "Config"){
  IniWrite, %value%, %A_ScriptDir%\config.ini, %SectionName%, %key%
}

ConfigGet(key,SectionName := "Config"){
  IniRead, OutputVar, %A_ScriptDir%\config.ini, %SectionName%, %key%,0
  return OutputVar
}

ConfigSectionGet(SectionName := "Config"){
  IniRead, OutputVarSection, %A_ScriptDir%\config.ini, %SectionName%
  return OutputVarSection
}

ConfigDelete(SectionName){
  IniDelete, %A_ScriptDir%\config.ini, %SectionName%
}