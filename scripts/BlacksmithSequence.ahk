WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\scripts\Chat.ahk
#Include, %A_ScriptDir%\..\scripts\Helpers.ahk


if (!BlacksmithIsPanelOpened()) {
  ExitApp
}

BlacksmithClickSalvageTabIfNotActive()

BlacksmithSalvageWhiteBlueYellow()

BlacksmithSalvageLegendaries()

BlacksmithClickRepairTab()

BlacksmithClickRepairButton()

ExitApp

Escape::
ExitApp
Return


; FileAppend, %scan%, D:\outty.txt