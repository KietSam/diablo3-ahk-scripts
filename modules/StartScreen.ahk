;===============================================================
; Start Screen
;===============================================================

StartScreenActive() {
  active := true
  start_x := 2010
  start_y := 1320
  delta_x := 93
  active_colors := [0x2C2D2C, 0x2B2C2C, 0x2B2B2B]
  Loop, 3 {
    active := active && ColorAtSimilarTo(start_x + (A_Index - 1) * delta_x, start_y, active_colors[A_Index], 9, 9, 9)
    if !active {
      return false
    }
  }
  return active
}

StartScreenWaitActive() {
  while !StartScreenActive() {
    Sleep, 50
  }
  Sleep, 1000
}

StartScreenClickStartGame() {
  ClickAt(320, 680)
}

