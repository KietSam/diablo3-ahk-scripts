#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\StartScreen.ahk

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
Print(InventoryNumLegendaryItems())

; Print(InventoryIsSingleSlotEmpty(1, 3))

; for k in settings?:
;   Print("k: " . k . ", v: " . v)



; Loop, 1 { ; Top -> Bottom
;   y := A_Index
;   Loop, 1 { ; Left -> Right
;     x := A_Index
;     ; InventoryIsSingleSlotAncient(x, y)
;     Print("x: " . x . ", y: " . y . ", is_ancient_item: " . InventoryIsSingleSlotAncient(x, y))
;     ; StashClickSlot(x, y)
;     ; StashIsSlotEmpty(x, y)
;   }
; }

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