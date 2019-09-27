#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\StartScreen.ahk
#Include, %A_ScriptDir%\..\modules\Sequences.ahk
#Include, %A_ScriptDir%\..\modules\Misc.ahk
#Include, %A_ScriptDir%\..\modules\Town.ahk

; WinActivate, Diablo III ahk_class D3 Main Window Class

; Print(InventoryIsInSlotRegion())
; Print(StartScreenActive())
; Print(StartScreenActive())

; InventoryOpenPanel()
; Print(InventoryNumEmptySlots())

; Print(InventoryIsSingleSlotLegendaryItem(1, 1))
; Print(InventoryIsDoubleSlotSetItem(1, 1))
; Print(InventoryIsDoubleSlotLegendaryItem(1, 1))
; Print(InventoryDoubleSlotType(1, 1))
; Print(InventoryNumDoubleSlotItems())
; Print(InventoryNumLegendaryItems())

; Print(InventoryIsSingleSlotEmpty(1, 3))
; Print(InventoryIsSingleSlotEmpty(1, 4))

; Print(InventoryRightClickSingleSlot(1, 4))

; RightClickImportantToStash()

; Print(InventoryIsDoubleSlotEmpty(6, 1))

; Print(IsArmorDamaged())
; Print(InventoryNumUnidentifiable())
; Print(InventoryIsSingleSlotUnidentifiable(1, 4))

; Print(InventoryIsSingleSlotEmpty(1, 3))
; Print(InventoryIsDoubleSlotItem(1, 2))
; Print(InventoryIsSingleSlotEmpty(1, 4))
; Print(InventoryIsSingleSlotImportant(1, 4))

; Print(InventoryIsDoubleSlotBlue(1, 1))
; RightClickImportantToStash()

; Print("Done!")

; blah(a:=100, b:=0, c:=0) {
;   Print(a + b + c)
; }

; blah()
; blah(2)

; Print(InventoryIsSingleSlotImportant(1, 3))
; Print(InventoryIsSingleSlotImportant(1, 4))

; Print(StashNumEmptySlots())

; InventoryRightClickImportant()

; Print(InventoryIsSingleSlotEmpty(1, 3))

; for k in settings?:
;   Print("k: " . k . ", v: " . v)



Loop, 3 { ; Top -> Bottom
  y := A_Index
  Loop, 8 { ; Left -> Right
    x := A_Index
    ; Print("x: " . x . ", y: " . y . ", var: " . InventoryIsDoubleSlotBlue(x, y))
    Print("x: " . x . ", y: " . y)
  }
}

; Print(InventoryNumSetItems())

; Print(MapWhatActIsActive())
; InventoryRightClickUnidentifiable()

; BlacksmithSalvageWhiteBlueYellow()MapIsActActive(n)

; MapOpenTown(2)
; TownClickNephalemStone(2)
; Sleep, 2000

; Print("Num unidentifiable: " . InventoryNumUnidentifiable())

; Loop, 1 { ; Top -> Bottom
;   y := A_Index
;   Loop, 4 { ; Left -> Right
;     x := A_Index
;     ; Print(InventoryIsSingleSlotUnidentifiable(x, y))
;     ; slot_point := InventoryGetSingleSlotPoint(x, y, 1, 14)
;     ; Print("x: " . x . ", y: " . y . ", similar: " . ColorPointSimilarTo(slot_point, 0xFFFFFF, 6, 6, 3))

;     ; slot_point2 := InventoryGetSingleSlotPoint(x, y, 1, 2)
;     ; Print("x: " . x . ", y: " . y . ", similar: " . ColorPointSimilarTo(slot_point2, 0xFFFFFF, 6, 6, 3, true))
;     ; MovePoint(slot_point)
;   }
; }

; active_color := 0x5094BB
; Print(ColorAt(1090, 110))
; Print(ColorAtSimilarTo(1090, 110, 0x5094bb))

; Print(GameMenuActive())
; GameMenuOpen()

; Print(IsInGame())
; Print(SkillIsInactive(4))

; Print("height: " . A_ScreenHeight . ", width: " . A_ScreenWidth)

; BlacksmithSalvageWhiteBlueYellow()

; Top -> Down
; Loop, 6 {
;   y := A_Index
;   ; Left -> Right
;   Loop, 8 {
;     x := A_Index
;     Print("x: " . x . ", y: " . y . ", empty?: " . InventoryIsSingleSlotEmpty(x, y))
;   }
; }

ExitApp

F1::
ExitApp
Return