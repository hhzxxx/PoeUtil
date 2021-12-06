#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Gui, New , Resize , PoeUtil

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

    }Else{
        FileAppend,, %A_ScriptDir%\config.ini,UTF-8
        ConfigSet("AlwaysOnTopFlag",0)
    }
}

ConfigSet(key,value,SectionName := "Config"){
    IniWrite, %value%, %A_ScriptDir%\config.ini, %SectionName%, %key%
}

ConfigGet(key,SectionName := "Config"){
    IniRead, OutputVar, %A_ScriptDir%\config.ini, %SectionName%,  %key%,0
    return OutputVar
}

ConfigSectionGet(SectionName := "Config"){
    IniRead, OutputVarSection, %A_ScriptDir%\config.ini,  %SectionName%
    return OutputVarSection
}
