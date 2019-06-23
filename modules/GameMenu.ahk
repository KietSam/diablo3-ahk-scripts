;===============================================================
; Game Menu (the menu when you press ESC while in-game)
;===============================================================

GameMenuItemPoint(n) {
  return Point(465, 425 + (n - 1) * 75)
}

GameMenuActive() {
  active := true
  start_x := 465
  start_y := 425
  delta_y := 75
  active_colors := [0x0B070A, 0X0C0B0C, 0X0D0E0F]

  Loop, 3 {
    p := GameMenuItemPoint(A_Index)
    active := active && ColorPointSimilarTo(p, active_colors[A_Index])
    if !active {
      return false
    }
  }
  return active
}

GameMenuClick(n) {
  ; n: The left menu item to click. index starts at 1
  ;    (1) Options      
  ;    (2) Achievements 
  ;    (3) Customer Service 
  ;    (4) Leave Game
  ;    (5) Exit Diablo 3
  ClickPoint(GameMenuItemPoint(n))
}

GameMenuOpen() {
  while !GameMenuActive() {
    Send, {Esc}
    Sleep, 150
  }
}