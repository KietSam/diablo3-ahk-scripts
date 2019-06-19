#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

; p := Point(222, 400)
; x := p[1]
; y := p[2]
; PrintPoint(p)
; Click, p[1], p[2], Left
; Click, %x%, %y%, Left

; ClickPoint(222, 400)

; Print(IsKanaiCubePanelActive())

; Loop, 9 {
;   KanaiCubeIsSlotEmpty(A_Index)
; }

KanaiCubeRemoveItem()


; BlacksmithClickRepairTab()

; p := Point(350, 100)
; active_color := 0x54D9F7
; inactive_color := 0x54D9F7
; PixelGetColor, curr_color, p[0], p[1]
; MsgBox % "curr_color: " . curr_color

; Click, p[0], p[1], Left

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