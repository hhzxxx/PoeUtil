#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

global LTopX = 0
global LTopY = 0
global RBottomX = 0
global RBottomY = 0

Gui, New ,  , PoeUtil
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
      global LTopX = % ConfigGet("LTopX")
      global LTopY = % ConfigGet("LTopY")
      GuiControl,, LeftTopXY , % ConfigGet("LTopX") " " ConfigGet("LTopY")
    }
    if(ConfigGet("RBottomX") and ConfigGet("RBottomY")){
      global RBottomX = % ConfigGet("RBottomX")
      global RBottomY = % ConfigGet("RBottomY")
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
    if(ConfigGet("GaoDianJinX") and ConfigGet("GaoDianJinY")){
      GuiControl,, GaoDianJinXY , % ConfigGet("GaoDianJinX") " " ConfigGet("GaoDianJinY")
    }
    if(ConfigGet("ShopText")){
      GuiControl,, ShopText , % ConfigGet("ShopText")
      clipboard := ConfigGet("ShopText")
    }
    src := % A_ScriptDir "\pic\Capture.png"
    GuiControl,, MyPic, *w120 *h-1 %src%

    Loop, %A_ScriptDir%\scripts\*.*
    {
        checkStatus := ConfigGet(A_LoopFileName,"checkStatus")
        if(checkStatus){
            pid := ConfigGet(A_LoopFileName,"scriptList")
            if(pid = 0){
                Run, %A_ScriptDir%\scripts\%A_LoopFileName% ,,,outPid
                if(outPid){
                    ConfigSet(A_LoopFileName,outPid,"scriptList")
                }
            }Else{
              Process, Exist , %pid%
              if(ErrorLevel = 0){
                Run, %A_ScriptDir%\scripts\%A_LoopFileName% ,,,outPid
                if(outPid){
                    ConfigSet(A_LoopFileName,outPid,"scriptList")
                }
              }
            }
        }
    }
  }Else{
    FileAppend,, %A_ScriptDir%\config.ini,UTF-8
    ConfigSet("AlwaysOnTopFlag",0)
  }
  checkImgFile()
  ; https://gitee.com/hhzxxx/static4-me/raw/master/pic/poeUtil/3.png
}

checkImgFile(){
  picSrc :=% A_ScriptDir "\pic"
  if !FileExist(picSrc)
  {
    FileCreateDir, % A_ScriptDir "\pic"
  }
  imgType := 3
  Loop{
    if(imgType > 10){
      Break
    }
    src := % A_ScriptDir "\pic\" imgType ".png"
    if !FileExist(src)
    {
      url := % "https://gitee.com/hhzxxx/static4-me/raw/master/pic/poeUtil/" imgType ".png"
      UrlDownloadToFile, % url, % src
    }
    imgType += 1
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