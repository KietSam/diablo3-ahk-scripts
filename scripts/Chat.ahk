#Include, %A_ScriptDir%\..\scripts\Utils.ahk

IsChatPanelActive() {
  return ColorAtSimilarTo(40, 1200, 0x000000)
}

IsInChatPanelArea(p) {
  top_left := Point(0, 635)
  bot_right := Point(720, 1215)
  x_good := p[1] >= top_left[1] && p[1] <= bot_right[2]
  y_good := p[2] >= top_left[2] && p[2] <= bot_right[2]
  return x_good && y_good 
}

DisableChat() {
  if IsChatPanelActive() {
    ; Move mouse so it's not on that chat panel
    curr_mouse_p := GetMousePoint()
    if IsInChatPanelArea(curr_mouse_p) {
      MoveAt(720, curr_mouse_p[2])
    }
    Send, {Enter}
    Sleep, 400
  }
}

SmartEnter() {
  ; Smartly presses Enter by disabling chat panel if it's open
  DisableChat()
  Send, {Enter}
  Sleep, 100
  DisableChat()
}