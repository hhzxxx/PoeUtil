#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

global itemX := 0
global itemY := 0
global itemList := []
global matchStrList := []
global readyFlag := 0
global fixMin := 0
global oldMatch := 0

StartWork(){
  genItemList()
  ; SetTimer, TimerWork, Off
  ; SetTimer, TimerWork, 300
  return
}

Use(type){
  if(oldMatch != 1 and type = 6){
    return 0
  }
  initItemXy()
  typeList:=["","","DianJin","TuiBian","GaiZao","ZengFu","FuHao","HunDun","ChongZhu","JiHui"]
  xName :=typeList[type] "X"
  yName :=typeList[type] "Y"
  if(ConfigGet(xName) and ConfigGet(yName)){
    Random, rand, 1, 10
    x := ConfigGet(xName)+rand
    y := ConfigGet(yName)+rand
    if(WinActive("Path of Exile")){
      Click,%x% %y% Right
      Click,%itemX% %itemY% 
      return match()
    }
  }
  return 0
}

initItemXy(){
  WinActivate,Path of Exile
  if(itemX = 0 or itemY = 0){
    itemX = % Ceil((ConfigGet("LTopX")+ConfigGet("RBottomX")+30)/2)
    itemY = % Ceil((ConfigGet("LTopY")+ConfigGet("RBottomY")+50)/2)
    ; MsgBox, %itemX% %itemY% 
    MouseMove ,%itemX% ,%itemY% 
  }
}

genItemList(){
  itemList := []
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

  if(ChongZhu = 1){
    itemList.Push(9)
  }
  if(FuHao = 1){
    itemList.Push(7)
  }
  if(ZengFu = 1){
    itemList.Push(6)
  }
  if(GaiZao = 1){
    itemList.Push(5)
  }
  if(TuiBian = 1){
    itemList.Push(4)
  }
  if(DianJin = 1){
    itemList.Push(3)
  }
  if(HunDun = 1){
    itemList.Push(8)
  }
  if(JiHui = 1){
    itemList.Push(10)
  }
  genMatchStr(Name1,Name2,Name3,Name4,Min)
}

genMatchStr(Name1,Name2,Name3,Name4,Min){
  matchStrList := []
  strListLength := 0
  if(StrLen(Trim(Name1))>0){
    strListLength+=1
    matchStrList.Push(Trim(Name1))
  }
  if(StrLen(Trim(Name2))>0){
    strListLength+=1
    matchStrList.Push(Trim(Name2))
  }
  if(StrLen(Trim(Name3))>0){
    strListLength+=1
    matchStrList.Push(Trim(Name3))
  }
  if(StrLen(Trim(Name4))>0){
    strListLength+=1
    matchStrList.Push(Trim(Name4))
  }
  RegList := []
  fixMin = %Min%
  if(fixMin > strListLength){
    fixMin = %strListLength%
  }
  if(fixMin = 0){
    return 
  }
  readyFlag = 1
  ToolTip,ready
}
match(){
  MouseMove, %itemX%,%itemY% 
  Sleep, 30
  send ^!C
  Sleep, 20
  Haystack:= Clipboard
  matchCount := 0
  matchRes :=""
  For index, value in matchStrList
  if(InStr(Haystack, value)){
    matchCount += 1
    matchRes = %matchRes% %value%
  }
  oldMatch = %matchCount%
  if(matchCount >= fixMin and matchCount>0){
    return matchRes
  }
  return 0
}