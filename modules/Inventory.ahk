#Include, %A_ScriptDir%\..\modules\Utils.ahk

;===============================================================
; Inventory
; This is how the coordinates work:
; x: Column number. (index starts at 1)
; y: Row number.
;    Example grid:
;    (1, 1) | (2, 1) | (3, 1) | ...
;    (1, 2) | (2, 2) | (3, 2) | ...
;    ...
;===============================================================

InventoryIsPanelActive() {
  return ColorAtSimilarTo(2200, 230, 0x496C93)
}

InventoryOpenPanel() {
  if !InventoryIsPanelActive() {
    Send, "i"
  }
}

InventoryCloseIfActive() {
  if InventoryIsPanelActive() {
    Send, "i"
  }
}

InventoryIsInSlotRegion() {
  ; Checks if the mouse is currently in the slot region of the inventory
  top_left_p := Point(1862, 734)
  bot_right_p := Point(2552, 1195)
  mouse_p := GetMousePoint()
  return IsPointInRegion(mouse_p, top_left_p, bot_right_p)
}

InventoryMoveMouseOutOfSlotRegion() {
  if InventoryIsInSlotRegion() {
    MovePoint(Point(1794, 891))
    Sleep, 100
  }
}

InventoryGetSingleSlotPoint(x, y, xx_shift:=0, yy_shift:=0) {
  xx_delta := 67.3 * WidthRatio()
  yy_delta := 66.7 * HeightRatio()
  top_left := Point(1902 + xx_shift, 778 + yy_shift)
  xx := top_left[1] + (x - 1) * xx_delta
  yy := top_left[2] + (y - 1) * yy_delta
  return [xx, yy]
}

InventoryGetDoubleSlotPoint(x, y, xx_shift:=0, yy_shift:=0) {
  return InventoryGetSingleSlotPoint(x, 2 * y, xx_shift, yy_shift)
}

InventoryIsSingleSlotUnidentifiable(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y, 1, 14)
  if ColorPointSimilarTo(slot_point1, 0xFFFFFF, 5, 5, 2) {
    slot_point2 := InventoryGetSingleSlotPoint(x, y, 1, 2)
    return ColorPointSimilarTo(slot_point2, 0xFFFFFF, 5, 5, 2)
  }
  return false
}

InventoryIsDoubleSlotUnidentifiable(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y, 1, -17)
  if ColorPointSimilarTo(slot_point1, 0xFFFFFF, 5, 5, 2) {
    slot_point2 := InventoryGetDoubleSlotPoint(x, y, 1, -30)
    return ColorPointSimilarTo(slot_point2, 0xFFFFFF, 5, 5, 2)
  }
  return false
}

InventoryIsDoubleSlotSetItem(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y, 23, 88)
  return ColorPointSimilarTo(slot_point1, 0x4DF05A)
}

InventoryIsSingleSlotSetItem(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y, 23, 21)
  return ColorPointSimilarTo(slot_point1, 0x4DF05A)
}

InventoryIsSingleSlotAncient(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetSingleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x015596, 6, 6, 10)
}

InventoryIsDoubleSlotAncient(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetDoubleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x015596, 6, 6, 10)
}

InventoryIsSingleSlotPrimal(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetSingleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x0B0A72, 6, 6, 10)
}

InventoryIsDoubleSlotPrimal(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetDoubleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x0B0A72, 6, 6, 10)
}

InventoryIsSingleSlotImportant(x, y) {
  return InventoryIsSingleSlotUnidentifiable(x, y) 
      || InventoryIsSingleSlotAncient(x, y) 
      || InventoryIsSingleSlotPrimal(x, y)
}

InventoryIsDoubleSlotImportant(x, y) {
  return InventoryIsDoubleSlotUnidentifiable(x, y) 
      || InventoryIsDoubleSlotAncient(x, y) 
      || InventoryIsDoubleSlotPrimal(x, y)
}

InventoryNumAncient() {
  num := 0
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && InventoryIsDoubleSlotAncient(x, y)) {
        num++
      }
      if InventoryIsSingleSlotAncient(x, y) {
        num++
      }
    }
  }
  return num
}

InventoryNumUnidentifiable() {
  num := 0
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && InventoryIsDoubleSlotUnidentifiable(x, y)) {
        num++
      }
      if InventoryIsSingleSlotUnidentifiable(x, y) {
        num++
      }
    }
  }
  return num
}

InventoryNumSetItems() {
  num := 0
  Loop, 3 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (InventoryIsDoubleSlotSetItem(x, y)) {
        num++
      }
      if InventoryIsSingleSlotSetItem(x, -1 + 2 * y) {
        num++
      }
    }
  }
  return num
}

InventoryIsSingleSlotEmpty(x, y) {
  x_shifts := [-15, -15, 15]
  y_shifts := [-15, 15, -15]
  empty := true
  Loop, 2 {
    slot_point := InventoryGetSingleSlotPoint(x, y, x_shifts[A_Index], y_shifts[A_Index])
    empty := empty && ColorPointSimilarTo(slot_point, 0X080E10, 3, 3, 3)
    if !empty {
      return false
    }
  }
  return empty
}

InventoryIsDoubleSlotEmpty(x, y) {
  x_shifts := [-15, -15, 15]
  y_shifts := [-15, 15, -15]
  empty := true
  Loop, 2 {
    slot_point := InventoryGetDoubleSlotPoint(x, y, x_shifts[A_Index], y_shifts[A_Index])
    empty := empty && ColorPointSimilarTo(slot_point, 0X080E10, 3, 3, 3)
    if !empty {
      return false
    }
  }
  return empty
}

InventoryNumEmptySlots() {
  num := 0
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if InventoryIsSingleSlotEmpty(x, y) {
        num++
      }
    }
    return num
  }
}

InventoryClickSingleSlot(x, y) {
  slot_point := InventoryGetSingleSlotPoint(x, y)
  ClickPoint(slot_point)
}

InventoryRightClickSingleSlot(x, y) {
  slot_point := InventoryGetSingleSlotPoint(x, y)
  RightClickPoint(slot_point)
}

InventoryDragSingleSlot(x, y, p) {
  slot_point := InventoryGetSingleSlotPoint(x, y)
  DragPoint(slot_point, p)
}

InventoryClickDoubleSlot(x, y) {
  slot_point := InventoryGetDoubleSlotPoint(x, y)
  ClickPoint(slot_point)
}

InventoryRightClickDoubleSlot(x, y) {
  slot_point := InventoryGetDoubleSlotPoint(x, y)
  RightClickPoint(slot_point)
}

InventoryDragDoubleSlot(x, y, p) {
  slot_point := InventoryGetDoubleSlotPoint(x, y)
  DragPoint(slot_point, p)
}

InventoryDragOutAllKnownInventory() {
  ; Drags out everything from the inventory that isn't unidentified.
  outside_p := Point(1794, 891)
  Loop, 3 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if InventoryIsDoubleSlotUnidentifiable(x, y) {
        continue
      }
      if (!InventoryIsDoubleSlotUnidentifiable(x, y) && !InventoryIsDoubleSlotEmpty(x, y)) {
        InventoryDragSingleSlot(x, 2 * y, outside_p)
        Sleep, 50
        continue
      }
      if (!InventoryIsSingleSlotUnidentifiable(x, -1 + 2 * y) && !InventoryIsSingleSlotEmpty(x, -1 + 2 * y)) {
        InventoryDragSingleSlot(x, -1 + 2 * y, outside_p)
        Sleep, 50
      }
    }
  }
}

InventoryRightClickUnidentifiable() {
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && InventoryIsDoubleSlotUnidentifiable(x, y)) {
        InventoryRightClickDoubleSlot(x, y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
      if InventoryIsSingleSlotUnidentifiable(x, y) {
        InventoryRightClickSingleSlot(x, y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
    }
  }
}

InventoryRightClickAncient() {
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && !InventoryIsDoubleSlotEmpty(x, y) && InventoryIsDoubleSlotAncient(x, y)) {
        InventoryRightClickDoubleSlot(x, y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
      if (!InventoryIsSingleSlotEmpty(x, y) && InventoryIsSingleSlotAncient(x, y)) {
        InventoryRightClickSingleSlot(x, y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
    }
  }
}

InventoryRightClickImportant() {
  InventoryMoveMouseOutOfSlotRegion()
  InventoryRightClickUnidentifiable()
  InventoryMoveMouseOutOfSlotRegion()
  Loop, 3 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && !InventoryIsDoubleSlotEmpty(x, y) && InventoryIsDoubleSlotImportant(x, y)) {
        InventoryRightClickDoubleSlot(x, y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
      single_slot_y := -1 + 2 * y
      if (!InventoryIsSingleSlotEmpty(x, single_slot_y) && InventoryIsSingleSlotImportant(x, single_slot_y)) {
        InventoryRightClickSingleSlot(x, single_slot_y)
        ; Sleep a bit in case the user is inputting into stash, 
        ; so the popup will disappear.
        Sleep, 50
      }
    }
  }
}