#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

active_color := 0x5094BB
Print(ColorAt(1090, 110))
Print(ColorAtSimilarTo(1090, 110, 0x5094bb))

; Top -> Down
; Loop, 6 {
;   i := A_Index
;   ; Left -> Right
;   Loop, 8 {
;     j := A_Index
;     slot_point := InventoryGetSlotPoint(j, i)
;     x := slot_point[1]
;     y := slot_point[2]
;     MoveAt(x, y)
;     Print("x: " . x . ", y: " . y . ", color: " . ColorAt(x, y) . "is_unidentified: " . ColorAtSimilarTo(x, y, 0xFFFFBF7))
;     ; if !InventoryIsSlotEmpty(x, y) {
;     ;   Run(x, y)
;     ; }
;   }
; }

; BlacksmithRepairSequence() {
;   if BlacksmithIsPanelOpened() {
;     if !BlacksmithIsRepairTabActive() {
;       BlacksmithClickRepairTab() 
;     }
;     BlacksmithClickRepairButton()
;   }
; }

; BlacksmithRepairSequence()


ExitApp

Escape::
ExitApp
Return