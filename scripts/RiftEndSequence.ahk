WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Kadala.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\Town.ahk
#Include, %A_ScriptDir%\..\modules\Blacksmith.ahk
#Include, %A_ScriptDir%\..\modules\GameMenu.ahk
#Include, %A_ScriptDir%\..\modules\StartScreen.ahk
#Include, %A_ScriptDir%\..\modules\Misc.ahk
#Include, %A_ScriptDir%\..\modules\RiftStone.ahk
#Include, %A_ScriptDir%\..\modules\Sequences.ahk


SpendBloodShardSequence() {
  if (ColorAtSimilarTo(2476, 1167, 0xFFFFFF)) {
    SpendBloodShards()
  }
}

MapOpenTown(1)
InventoryOpenPanel()
num_empty_slots := InventoryNumEmptySlots()
InventoryCloseIfActive()

TownWaitTillActive(1)

if (num_empty_slots <= 16) {
  ; Click blacksmith from Orek pos
  while !BlacksmithIsPanelActive() {
    TownClickBlacksmith(1)
    Sleep, 2000
  }
  BlacksmithRepairAndSalvage()
}

GameMenuOpen()
GameMenuClick(4)

StartScreenWaitActive()
while !IsInGame() {
  StartScreenClickStartGame()
  Sleep, 1000
}

act_to_goto := 2
if (MapIsActActive(2)) {
  ; If it's 2, then go to 1
  act_to_goto := 1
}

MapOpenTown(act_to_goto)
TownWaitTillActive(act_to_goto)
while !RiftIsPanelActive() {
  TownClickNephalemStone(act_to_goto)
  Sleep, 2500
}

RiftWaitTillPanelActive()
RiftClickNephalemOption()

; Click accept
RiftClickAccept()
; Wait for it to open
Sleep, 3500
TownClickPortal(act_to_goto)

ExitApp

F1::
ExitApp
Return