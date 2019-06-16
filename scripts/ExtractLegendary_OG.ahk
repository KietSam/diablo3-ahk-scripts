WinActivate, Diablo III ahk_class D3 Main Window Class

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

OpenPanel(xx, yy) {
  active_panel_color = 0x1D3D68
  PixelGetColor, PanelToggleColor, 778, 173
  ; MsgBox, , %PanelToggleColor%,,
  if (PanelToggleColor != active_panel_color) {
    Click, 574, 1105 Left, Down
    Click, 574, 1105, Left, Up
  }
}

RemoveItemFromCubeSlot() {
  ; first_slot_khanduran_rune_color = 0x5B849A
  first_slot_khanduran_rune_color = 0x4475A0
  PixelGetColor, FirstSlotColor, 280, 550
  ; MsgBox %FirstSlotColor%
  if (FirstSlotColor = first_slot_khanduran_rune_color) {
    Click, 428, 543 Right, Down
    Click, 428, 543 Right, Up
  } else {
    Click, 280, 550 Right, Down
    Click, 280, 550 Right, Up
  }
}

MouseGetPos, xx, yy

OpenPanel(xx, yy)

Click, %xx%, %yy% Right, Down
Click, %xx%, %yy% Right, Up

; Clicks fill
Click, 965, 1121 Left, Down
Click, 957, 1121 Left, Up

; Clicks transmute
Click, 413, 1107 Left, Down
Click, 413, 1107 Left, Up

SmartEnter()

; Close recipe panel
; Click, 1190, 25 Left, Down
; Click, 1190, 25 Left, Up

RemoveItemFromCubeSlot()

; Move back to original mouse position
Click, %xx%, %yy%, 0