WinActivate, Diablo III ahk_class D3 Main Window Class

DisableChat() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
    Sleep, 500
  }
}

SmartEnter() {
  DisableChat()
  Send, {Enter}
  Sleep, 100
  DisableChat()
}

OpenPanel() {
  active_panel_color = 0x1D3D68
  PixelGetColor, PanelToggleColor, 778, 173
  ; MsgBox, , %PanelToggleColor%,,
  if (PanelToggleColor != active_panel_color) {
    Click, 574, 1105 Left, Down
    Click, 574, 1105, Left, Up
  }
}

RemoveItemFromCubeSlot() {
  top_left_slot_khanduran_rune_color1 = 0x5B849A
  top_left_slot_khanduran_rune_color2 = 0x4475A0
  top_left_empty_slot_color = 0x080D0D
  top_right_empty_slot_color = 0x080E0E
  PixelGetColor, TopLeftColor, 280, 550
  ; MsgBox %TopLeftColor%
  if (TopLeftColor = top_left_slot_khanduran_rune_color1 || TopLeftColor = top_left_slot_khanduran_rune_color2) {
    PixelGetColor, TopRightSlotColor, 440, 540
    ; MsgBox %TopRightSlotColor%
    if (TopRightSlotColor != top_right_empty_slot_color) {
      ; Top right
      Click, 428, 543 Right, Down
      Click, 428, 543 Right, Up
    } else {
      ; Mid right
      Click, 428, 610 Right, Down
      Click, 428, 610 Right, Up
    }
  } else {
    if (TopLeftColor = top_left_empty_slot_color) {
      ; Mid right
      Click, 428, 610 Right, Down
      Click, 428, 610 Right, Up
    } else {
      ; Top left
      Click, 280, 550 Right, Down
      Click, 280, 550 Right, Up
    }
  }
}

Run(xx, yy) {
  Sleep, 120

  OpenPanel()

  Click, %xx%, %yy% Right, Down
  Click, %xx%, %yy% Right, Up

  ; Clicks fill
  Click, 965, 1121 Left, Down
  Click, 957, 1121 Left, Up

  DisableChat()
  
  ; Clicks transmute
  Click, 413, 1107 Left, Down
  Click, 413, 1107 Left, Up

  Click, 150, 600, 0
  Sleep, 200

  SmartEnter()
  Sleep, 1500
  RemoveItemFromCubeSlot()
}

top_left_xx = 1837
top_left_yy = 717

xx_delta = 67
yy_delta = 65

empty_slot_color1 = 0x080D10
empty_slot_color2 = 0x080E10

; Top -> Down
Loop, 5 {
  i := A_Index
  ; Left -> Right
  Loop, 8 {
    j := A_Index
    xx := top_left_xx + j * xx_delta
    yy := top_left_yy + i * yy_delta
    PixelGetColor, SlotColor, %xx%, %yy%
    if (SlotColor != empty_slot_color1 && SlotColor != empty_slot_color2) {
      Run(xx, yy)
    }
  }
}

Escape::
ExitApp
Return


; Move back to original mouse position
; Click, %xx%, %yy%, 0