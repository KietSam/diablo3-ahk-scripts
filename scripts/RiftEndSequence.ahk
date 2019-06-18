WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

CloseInventory() {
  active_inventory_color = 0x349ADB
  PixelGetColor, inventoryOpenColor, 2200, 100
  if (inventoryOpenColor = active_inventory_color) {
    Send, "i"
  }
}

Send, "t"

Click, 1600, 700, 0
Sleep, 6900
CloseInventory()

; Location 1
Click, 2000, 700 Left, Down
Click, 2000, 700 Left, Up
Sleep, 1500

; Location 2
Click, 1800, 1000 Left, Down
Click, 1800, 1000 Left, Up
Sleep, 1000

; Orek
Click, 1680, 900 Left, Down
Click, 1680, 900 Left, Up
Sleep, 500
Loop, 5 {
  Send, {Space}
  Sleep, 50
}

; Click blacksmith
Click, 1600, 150, Left, Down
Click, 1600, 150, Left, Up
Sleep, 2000

BlacksmithSalvageWhiteBlueYellow()

Sleep, 30000

; Click neph stone
Click, 1400, 1000, Left, Down
Click, 1400, 1000, Left, Up
Sleep, 1000

; Click nephalem option
RiftClickNephalemOption()

; Click accept
RiftClickAccept()

Sleep, 4000

; Click rift
Click, 1300, 700, Left, Down
Click, 1300, 700, Left, Up

ExitApp

Escape::
ExitApp
Return