WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

MapOpenTown(1)
Sleep, 5000

TownClickOrek(1)
Sleep, 1900
Loop, 5 {
  Send, {Space}
  Sleep, 50
}

; Click blacksmith from Orek pos
ClickAt(1640, 130)
Sleep, 2000

BlacksmithRepairAndSalvage()
Sleep, 1000

ExitApp

F1::
ExitApp
Return