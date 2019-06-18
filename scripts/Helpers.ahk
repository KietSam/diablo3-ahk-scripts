DisableChat() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
    Sleep, 500
  }
}

SmartEnter() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
  Send, {Enter}
  Sleep, 100
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
}

;===============================================================
; Kadala stone
;===============================================================

KadalaClickWeaponTab() {
  Click, 680, 300, Left
}

KadalaClickArmorTab() {
  Click, 680, 470, Left
}

KadalaClickSlot(n) {
  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2
  ;    3 | 4
  ;    ...
  xx := 210 + 290 * Mod(n - 1, 2)
  yy := 280 + 130 * (Ceil(n / 2) - 1)
  Click, %xx%, %yy%, Right
}

;===============================================================
; Rift stone
;===============================================================

RiftClickNephalemOption() {
  Click, 350, 380, Left
}

RiftClickNephalemAccept() {
  Click, 350, 1130, Left
}