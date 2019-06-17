WinActivate, Diablo III ahk_class D3 Main Window Class

CloseInventory() {
  active_inventory_color = 0x349ADB
  PixelGetColor, inventoryOpenColor, 2200, 100
  if (inventoryOpenColor = active_inventory_color) {
    Send, "i"
  }
}

Send, "t"
Click, 1600, 700, 0
Sleep, 8000
CloseInventory()
Click, 2000, 700 Left, Down
Click, 2000, 700 Left, Up
Sleep, 900
Click, 1800, 1000 Left, Down
Click, 1800, 1000 Left, Up
Sleep, 900
Click, 1680, 900 Left, Down
Click, 1680, 900 Left, Up
Sleep, 500
Loop, 5 {
  Send, {Space}
  Sleep, 50
}
ExitApp

Escape::
ExitApp
Return