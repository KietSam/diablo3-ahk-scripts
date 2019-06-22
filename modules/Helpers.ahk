#Include, %A_ScriptDir%\..\modules\Blacksmith.ahk
#Include, %A_ScriptDir%\..\modules\Chat.ahk
#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\Kadala.ahk
#Include, %A_ScriptDir%\..\modules\Kanai.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\Skills.ahk
#Include, %A_ScriptDir%\..\modules\Stash.ahk
#Include, %A_ScriptDir%\..\modules\Town.ahk
#Include, %A_ScriptDir%\..\modules\Urshi.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk


IsInGame() {
  active := true
  xs := [545, 545, 620]
  ys := [1325, 1380, 1325]
  active_colors := [0X161513, 0X544E4B, 0X0F0F0F]

  Loop, 3 { ; We have 4 points but just check 3 cause it's faster
    active := active && ColorAtSimilarTo(xs[A_Index], ys[A_Index], active_colors[A_Index], 4, 4, 3)
    if !active {
      return false
    }
  }
  return active
}

WaitTillInGame() {
  ; Sleeps until in game.
  while !IsInGame() {
    Sleep, 50
  }
}

;===============================================================
; Game Menu (the menu when you press ESC while in-game)
;===============================================================

GameMenuItemPoint(n) {
  start_x := 465
  start_y := 425
  delta_y := 75
  return Point(start_x, start_y + (n - 1) * delta_y)
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
    Sleep, 200
  }
}

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
    active := active && ColorAtSimilarTo(start_x + (A_Index - 1) * delta_x, start_y, active_colors[A_Index])
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
  Sleep, 200
}

StartScreenClickStartGame() {
  ClickAt(320, 680)
}

;===============================================================
; Rift stone
;===============================================================

RiftClickNephalemOption() {
  ClickAt(350, 380)
}

RiftClickGreaterOption() {
  ClickAt(350, 600)
}

RiftClickAccept() {
  ClickAt(350, 1130)
}

