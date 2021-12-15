#SingleInstance
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

global itemX := 0
global itemY := 0
global itemList := []
global matchStrList := []
global fixTypeList := []
global readyFlag := 0
global fixMin := 0
global oldMatch := 0
global anyfix := 0
global prefix := 0
global suffix := 0
global needfix := 0
global gotPrefix := 0
global gotSuffix := 0
global gotNeedfix := 0
global nowPrefix := 0
global nowSuffix := 0
global addNum := 0  ;富豪 增幅数量
global allowChongZhu := 0

StartWork(){
  global itemList := []
  global matchStrList := []
  global fixTypeList := []
  global readyFlag := 0
  global fixMin := 0
  global oldMatch := 0
  global anyfix := 0
  global prefix := 0
  global suffix := 0
  global needfix := 0
  global gotPrefix := 0
  global gotSuffix := 0
  global gotNeedfix := 0
  global nowPrefix := 0
  global nowSuffix := 0
  global addNum := 0  ;富豪 增幅数量
  global allowChongZhu := 0
  genItemList()
  return
}

Use(type){
  if(CheckImg(type) = 0){
    return "nonono"
  }
  if(  type = 6){
    if(nowSuffix = 1 and nowPrefix = 1){
      return 0
    }
    if(nowPrefix = 0 and nowSuffix = 1 and (prefix>0 or anyfix>0)){
      a = 1
    }else if(nowSuffix = 0 and nowPrefix = 1 and (suffix>0 or anyfix>0)){
      a = 2
    }else if(nowPrefix = 0 and nowSuffix = 1 and suffix>0 and anyfix=0){
      return 0
    }else if(nowSuffix = 0 and nowPrefix = 1 and prefix>0 and anyfix=0){
      return 0
    }else if((fixMin - oldMatch)> addNum or (nowSuffix = 1 and nowPrefix = 1)){
      return 0
    }
  }
  if(oldMatch != (fixMin-1) and type = 7){
    return 0
  }
  if(allowChongZhu = 0 and type = 9){
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
      if(type = 7 or type = 10 or type = 3){
        global allowChongZhu := 1
      }Else{
        global allowChongZhu := 0
      }
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
  global fixTypeList := []
  global itemList := []
  global addNum := 0
  GuiControlGet, Min
  GuiControlGet, Name1
  GuiControlGet, Name2
  GuiControlGet, Name3
  GuiControlGet, Name4
  GuiControlGet, Name5
  GuiControlGet, Name6
  GuiControlGet, Name1Type
  GuiControlGet, Name2Type
  GuiControlGet, Name3Type
  GuiControlGet, Name4Type
  GuiControlGet, Name5Type
  GuiControlGet, Name6Type
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
    addNum += 1
    itemList.Push(7)
  }
  if(ZengFu = 1){
    addNum += 1
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

  global anyfix := 0
  global prefix := 0
  global suffix := 0
  global needfix := 0

  global matchStrList := []
  strListLength := 0
  if(StrLen(Trim(Name1))>0){
    addFixNum(Name1Type)
    strListLength+=1
    matchStrList.Push(Trim(Name1))
  }
  if(StrLen(Trim(Name2))>0){
    addFixNum(Name2Type)
    strListLength+=1
    matchStrList.Push(Trim(Name2))
  }
  if(StrLen(Trim(Name3))>0){
    addFixNum(Name3Type)
    strListLength+=1
    matchStrList.Push(Trim(Name3))
  }
  if(StrLen(Trim(Name4))>0){
    addFixNum(Name4Type)
    strListLength+=1
    matchStrList.Push(Trim(Name4))
  }
  if(StrLen(Trim(Name5))>0){
    addFixNum(Name5Type)
    strListLength+=1
    matchStrList.Push(Trim(Name5))
  }
  if(StrLen(Trim(Name6))>0){
    addFixNum(Name6Type)
    strListLength+=1
    matchStrList.Push(Trim(Name6))
  }
  RegList := []
  fixMin = %Min%
  if(fixMin > strListLength){
    fixMin = %strListLength%
  }
  if(fixMin = 0){
    return 
  }
  SBSetText("ready")
  readyFlag = 1
}

match(){
  MouseMove, %itemX%,%itemY% 
  Sleep, 30
  send ^!C
  Sleep, 30
  Haystack:= Clipboard
  matchCount := 0
  matchRes :=""
  global gotPrefix := 0
  global gotSuffix := 0
  global gotNeedfix := 0
  global oldMatch := 0
  global nowPrefix := 0
  global nowSuffix := 0
  if(InStr(Clipboard, "前缀") or InStr(Clipboard, "prefix")){
    nowPrefix += 1
  }
  if(InStr(Clipboard, "后缀") or InStr(Clipboard, "suffix")){
    nowSuffix += 1
  }
  For index, value in matchStrList
  {    
    ; MsgBox, % Haystack
    if(RegExMatch(Haystack, value)){
      
      addGotFixNum(fixTypeList[index])
      matchCount += 1
      matchRes = %matchRes% %value%
    }

  }
  
  ; ToolTip,% gotPrefix " " gotSuffix " " oldMatch " " Haystack
  if(matchCount >= fixMin and matchCount>0 and gotNeedfix = needfix){
    return matchRes
  }
  return 0
}

addFixNum(type){
  fixTypeList.Push(type)
  if(type = 0 or type = 1){
    anyfix += 1
  }
  if(type = 2){
    prefix += 1
  }
  if(type = 3){
    suffix += 1
  }
  if(type = 4){
    needfix += 1
  }
}

addGotFixNum(type){
  oldMatch += 1
  if(type = 2){
    gotPrefix += 1
  }
  if(type = 3){
    gotSuffix += 1
  }
  if(type = 4){
    gotNeedfix += 1
  }
}