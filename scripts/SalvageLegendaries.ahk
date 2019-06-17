top_left_xx = 1837
top_left_yy = 717

xx_delta = 67
yy_delta = 65

SmartEnter() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
  Send, {Enter}
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
}

TurnSalvageOn() {
  active_salvage_color = 0x5DACFF
  PixelGetColor, SalvageToggleColor, 222, 400
  if (SalvageToggleColor != active_salvage_color) {
    Click, 222, 400, Left, Down
    Click, 222, 400, Left, Up
  }
}


empty_slot_color1 = 0x080D10
empty_slot_color2 = 0x080E10

; Top -> Down
scan =
Loop, 6 {
  i := A_Index
  ; Left -> Right
  Loop, 8 {
    j := A_Index
    xx := top_left_xx + j * xx_delta
    yy := top_left_yy + i * yy_delta
    PixelGetColor, SlotColor, %xx%, %yy%
    if (SlotColor != empty_slot_color1 && SlotColor != empty_slot_color2) {
      TurnSalvageOn()
      Click, %xx%, %yy%, Left, Down
      Click, %xx%, %yy%, Left, Up
      SmartEnter()
    }
  }
}

ExitApp

Escape::
ExitApp
Return


; FileAppend, %scan%, D:\outty.txt