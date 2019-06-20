WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

Send, "t"

MoveAt(1600, 700)
InventoryCloseIfActive()
Sleep, 6900

; Location 1
ClickAt(2000, 700)
Sleep, 1500

; Location 2
ClickAt(1800, 1000)
Sleep, 1000

; Orek
ClickAt(1680, 900)
Sleep, 500
Loop, 5 {
  Send, {Space}
  Sleep, 50
}

; Click blacksmith
ClickAt(1600, 150)
Sleep, 2000

BlacksmithSalvageWhiteBlueYellow()

Sleep, 30000

; Click neph stone
ClickAt(1400, 1000)
Sleep, 1000

; Click nephalem option
RiftClickNephalemOption()

; Click accept
RiftClickAccept()

Sleep, 4000

; Click rift
ClickAt(1300, 700)

ExitApp

Escape::
ExitApp
Return