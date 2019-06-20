WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

MapOpenTown(1)
Sleep, 6000

TownClickOrek(1)
Sleep, 2000
Loop, 5 {
  Send, {Space}
  Sleep, 50
}

MapOpenTown(2)
MapOpenTown(1)

TownClickBlacksmith(1)
Sleep, 2000

BlacksmithRepairAndSalvage()
Sleep, 1000

GameMenuOpen()
Sleep, 100

; Leave game
GameMenuClick(4)
StartScreenWaitActive()
StartScreenClickStartGame()
WaitTillInGame()

MapOpenTown(2)
MapOpenTown(1)
Sleep, 1500

TownClickNephalemStone(1)
Sleep, 2000

RiftClickNephalemOption()

; Click accept
RiftClickAccept()
; Wait for it to open
Sleep, 3000
; Click portal
ClickAt(1520, 550)

ExitApp

F1::
ExitApp
Return