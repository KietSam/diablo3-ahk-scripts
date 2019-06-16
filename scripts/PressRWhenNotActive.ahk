WinActivate, Diablo III ahk_class D3 Main Window Class

not_active_color = 0x2C2B2A

PixelGetColor, ActiveColor, 2200, 100
MsgBox, %ActiveColor%
if (ActiveColor = not_active_color) {
  Send, "Q"
}