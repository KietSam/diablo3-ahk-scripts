#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

inactive_color := 000000

; Slot 1
x := 850
y := 1328

; Slot 2
; x := 939
; y := 1328

; Slot 3
; x := 1027
; y := 1328

; Slot 4
x := 1117
y := 1328

Print("color_at: " . ColorAt(x, y) . ", similar: " . ColorAtSimilarTo(x, y, inactive_color, 3, 3, 1))
MoveAt(x, y)

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

; curr_slot := 1
; exit_on_next_upgrade := false
; While, true {  
;   if (UrshiOneUpgradeLeft()) {
;     exit_on_next_upgrade := true
;   }
;   UrshiClickSlot(curr_slot)
;   if (UrshiIsGem100PercentUpgradeChance()) {
;     UrshiClickUpgrade()
;     if (exit_on_next_upgrade) {
;       break
;     }
;     UrshiClickSlot(curr_slot)
;     Sleep, 1500
;   } else {
;     curr_slot++
;     if (curr_slot = 16) {
;       UrshiScrollDownOnce()
;       curr_slot := 1
;     }
;   }
; }
; MsgBox, Done!

; Loop, 15 {
;   UrshiClickSlot(A_Index)
;   Sleep, 250
; }
; UrshiScrollDownOnce()
; Loop, 15 {
;   UrshiClickSlot(A_Index)
;   Sleep, 250
; }
; UrshiScrollDownOnce()
; Loop, 15 {
;   UrshiClickSlot(A_Index)
;   Sleep, 250
; }

ExitApp

Escape::
ExitApp
Return