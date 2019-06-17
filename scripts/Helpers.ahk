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