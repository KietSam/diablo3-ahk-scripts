WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Chat.ahk
#Include, %A_ScriptDir%\..\modules\Blacksmith.ahk


if (!BlacksmithIsPanelActive()) {
  ExitApp
}

BlacksmithClickSalvageTabIfNotActive()

BlacksmithSalvageWhiteBlueYellow()

BlacksmithSalvageLegendaries()

; BlacksmithClickRepairTab()

; BlacksmithClickRepairButton()

ExitApp

Escape::
ExitApp
Return


; FileAppend, %scan%, D:\outty.txt