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

global:
EMPTY := 0
LEGENDARY := 1
SET := 2

NOT_DOUBLE_SLOT := 4

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
    MovePoint(Point(1891, 684))
    Sleep, 350
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
  if ColorPointSimilarTo(slot_point1, 0xFFFFFF, 6, 6, 3) {
    slot_point2 := InventoryGetSingleSlotPoint(x, y, 1, 2)
    return ColorPointSimilarTo(slot_point2, 0xFFFFFF, 6, 6, 3)
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

InventoryIsSingleSlotLegendaryItem(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y, 23, 21)
  return ColorPointSimilarTo(slot_point1, 0x0062DF)
}

InventoryIsSingleSlotSetItem(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y, 23, 21)
  return ColorPointSimilarTo(slot_point1, 0x4DF05A)
}

InventoryIsDoubleSlotLegendaryItem(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y, 23, 21)
  return ColorPointSimilarTo(slot_point1, 0x0062DF)
}

InventoryIsDoubleSlotSetItem(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y, 23, 21)
  return ColorPointSimilarTo(slot_point1, 0x4DF05A)
}

InventoryIsSingleSlotAncient(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetSingleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x015596, 5, 5, 8)
}

InventoryDoubleSlotType(x, y) {
  global
  if !(InventoryIsSingleSlotLegendaryItem(x, -1 + 2 * y) || InventoryIsSingleSlotSetItem(x, -1 + 2 * y)) {
    if InventoryIsDoubleSlotLegendaryItem(x, y) {
      return LEGENDARY
    }
    if InventoryIsDoubleSlotSetItem(x, y) {
      return SET
    }
  }
  return NOT_DOUBLE_SLOT
}

InventoryIsDoubleSlotItem(x, y) {
  if (InventoryIsSingleSlotEmpty(x, -1 + 2 * y)) {
    return false
  } else if (!(InventoryIsSingleSlotLegendaryItem(x, -1 + 2 * y) || InventoryIsSingleSlotSetItem(x, -1 + 2 * y))) {
    return (InventoryIsDoubleSlotLegendaryItem(x, y) || InventoryIsDoubleSlotSetItem(x, y))
  } else {
    return false
  }
}

InventoryIsDoubleSlotAncient(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetDoubleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x015596, 5, 5, 8)
}

InventoryIsSingleSlotPrimal(x, y) {
  slot_point1 := InventoryGetSingleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetSingleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x0B0A72, 5, 5, 8)
}

InventoryIsDoubleSlotPrimal(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y)
  MovePoint(slot_point1)
  Sleep, 100
  item_strip_point := InventoryGetDoubleSlotPoint(x, y, -35, 0)
  return ColorPointSimilarTo(item_strip_point, 0x0B0A72, 5, 5, 8)
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

InventoryNumDoubleSlotItems() {
  num := 0
  Loop, 3 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (InventoryIsDoubleSlotItem(x, y)) {
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

InventoryNumLegendaryItems() {
  global
  num := 0
  Loop, 3 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      type := InventoryDoubleSlotType(x, y)
      if (type == NOT_DOUBLE_SLOT) {
        if InventoryIsSingleSlotLegendaryItem(x, -1 + 2 * y) {
          num++
        }
        if InventoryIsSingleSlotLegendaryItem(x, 2 * y) {
          num++
        }
      } else if (type == LEGENDARY) {
        num++
      }
    }
  }
  return num
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

InventoryIsSingleSlotEmpty(x, y) {
  x_shifts := [0, -15, 15]
  y_shifts := [-17, 15, -15]
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
  return !InventoryIsDoubleSlotItem(x, y)
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
  }
  return num
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

InventoryRightClickImportant(n:=100, start_x:=1, start_y:=1, end_x:=8, end_y:=3) {
  ; n: number of slots to right click
  InventoryMoveMouseOutOfSlotRegion()
  Loop, 8 { ; Top -> Bottom
    x := A_Index + (start_x - 1)
    if (x > end_x) {
      break
    }
    Loop, 3 { ; Left -> Right
      y := A_Index + (start_y - 1)
      if (y > end_y) {
        break
      }
      if (n <= 0) {
        return [x, y]
      }
      single_slot1_y := -1 + 2 * y
      single_slot2_y := 2 * y
      if (InventoryIsDoubleSlotItem(x, y)) {
        if (!InventoryIsDoubleSlotEmpty(x, y) && InventoryIsDoubleSlotImportant(x, y)) {
          InventoryRightClickDoubleSlot(x, y)
          n -= 2
          continue
        }
        if (!InventoryIsSingleSlotEmpty(x, single_slot2_y) && InventoryIsSingleSlotImportant(x, single_slot2_y)) {
          InventoryRightClickSingleSlot(x, single_slot2_y)
          n -= 1
        }
      } else {
        if (!InventoryIsSingleSlotEmpty(x, single_slot1_y) && InventoryIsSingleSlotImportant(x, single_slot1_y)) {
          InventoryRightClickSingleSlot(x, single_slot1_y)
          n -= 1
        }
        if (!InventoryIsSingleSlotEmpty(x, single_slot2_y) && InventoryIsSingleSlotImportant(x, single_slot2_y)) {
          InventoryRightClickSingleSlot(x, single_slot2_y)
          n -= 1
        }
      }
    }
  }
  return [end_x, end_y]
}

InventoryBloodShardsGreaterThan1K() {
  return ColorAtSimilarTo(2476, 1167, 0xFFFFFF)
}