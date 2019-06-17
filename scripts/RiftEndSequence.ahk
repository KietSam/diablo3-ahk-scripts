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

salvage_icons_xx := [335, 430, 515]
salvage_icons_yy := [390, 390, 390]
salvage_icons_inactive_color := [0x12274E, 0x0B0804, 0x272D4A]

Loop % salvage_icons_xx.Length() {
  xx := salvage_icons_xx[A_Index]
  yy := salvage_icons_yy[A_Index]
  inactive_color := salvage_icons_inactive_color[A_Index]
  PixelGetColor, salvage_icon_color, xx, yy
  ; MsgBox % "xx: " . xx ", yy: " . yy . ", salvage_icon_color: " . salvage_icon_color
  if (salvage_icon_color != inactive_color) {
    Click, %xx%, %yy%, Left, Down
    Click, %xx%, %yy%, Left, Up
    SmartEnter()
  }
}

Sleep, 30000

; Click neph stone
Click, 1400, 1000, Left, Down
Click, 1400, 1000, Left, Up
Sleep, 1000

; Click nephalem option
Click, 350, 380, Left, Down
Click, 350, 380, Left, Up

; Click accept
Click, 350, 1130, Left, Down
Click, 350, 1130, Left, Up

Sleep, 4000

; Click rift
Click, 1300, 700, Left, Down
Click, 1300, 700, Left, Up

ExitApp

Escape::
ExitApp
Return