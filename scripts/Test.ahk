#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

; active_color := 0x5094BB
; Print(ColorAt(1090, 110))
; Print(ColorAtSimilarTo(1090, 110, 0x5094bb))


; Top -> Down
  Loop, 6 {
    i := A_Index
    ; Left -> Right
    Loop, 8 {
      j := A_Index
      x := j
      y := i
      Print("x: " . x . ", y: " . y . ", empty?: " . InventoryIsSlotEmpty(x, y))
    }
  }

GameMenuActive()
ExitApp

Escape::
ExitApp
Return