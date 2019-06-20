#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

; active_color := 0x5094BB
; Print(ColorAt(1090, 110))
; Print(ColorAtSimilarTo(1090, 110, 0x5094bb))

; Print(GameMenuActive())
; GameMenuOpen()

; Print(IsInGame())
; Print(SkillIsInactive(4))

BlacksmithSalvageWhiteBlueYellow()

; Top -> Down
; Loop, 6 {
;   y := A_Index
;   ; Left -> Right
;   Loop, 8 {
;     x := A_Index
;     Print("x: " . x . ", y: " . y . ", empty?: " . InventoryIsSlotEmpty(x, y))
;   }
; }

GameMenuActive()
ExitApp

F1::
ExitApp
Return