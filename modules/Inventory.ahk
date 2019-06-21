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

InventoryCloseIfActive() {
  if InventoryIsPanelActive() {
    Send, "i"
  }
}

InventoryGetSlotPoint(x, y, xx_shift:=0, yy_shift:=0) {
  xx_delta := 67.3 * WidthRatio()
  yy_delta := 66.7 * HeightRatio()
  top_left := Point(1902 + xx_shift, 778 + yy_shift)
  xx := top_left[1] + (x - 1) * xx_delta
  yy := top_left[2] + (y - 1) * yy_delta
  return [xx, yy]
}

InventoryGetDoubleSlotPoint(x, y, xx_shift:=0, yy_shift:=0) {
  return InventoryGetSlotPoint(x, y + (y - 1), xx_shift, yy_shift)
}

InventoryIsSingleSlotUnidentifiable(x, y) {
  slot_point1 := InventoryGetSlotPoint(x, y, 1, 14)
  if ColorPointSimilarTo(slot_point1, 0xFFFFFF, 4, 4, 2) {
    slot_point2 := InventoryGetSlotPoint(x, y, 1, 2)
    return ColorPointSimilarTo(slot_point2, 0xFFFFFF, 4, 4, 2)
  }
  return false
}

InventoryIsDoubleSlotUnidentifiable(x, y) {
  slot_point1 := InventoryGetDoubleSlotPoint(x, y, 1, 49)
  if ColorPointSimilarTo(slot_point1, 0xFFFFFF, 4, 4, 2) {
    slot_point2 := InventoryGetDoubleSlotPoint(x, y, 1, 34)
    return ColorPointSimilarTo(slot_point2, 0xFFFFFF, 4, 4, 2)
  }
  return false
}

InventoryCountNumberUnidentifiable() {
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

InventoryRightClickUnidentifiable() {
  Loop, 6 { ; Top -> Bottom
    y := A_Index
    Loop, 8 { ; Left -> Right
      x := A_Index
      if (y <= 3 && InventoryIsDoubleSlotUnidentifiable(x, y)) {
        RightClickPoint(InventoryGetDoubleSlotPoint(x, y))
      }
      if InventoryIsSingleSlotUnidentifiable(x, y) {
        RightClickPoint(InventoryGetSlotPoint(x, y))
      }
    }
  }
}

InventoryIsSlotEmpty(x, y) {
  ; TODO: REDO THIS
  x_shifts := [-15, -15, 15]
  y_shifts := [-15, 15, -15]

  empty := true
  Loop, 2 {
    slot_point := InventoryGetSlotPoint(x, y, x_shifts[A_Index], y_shifts[A_Index])
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
      if InventoryIsSlotEmpty(x, y) {
        num++
      }
    }
    return num
  }
}

InventoryClickSlot(x, y) {
  slot_point := InventoryGetSlotPoint(x, y)
  ClickPoint(slot_point)
}

InventoryRightClickSlot(x, y) {
  slot_point := InventoryGetSlotPoint(x, y)
  RightClickPoint(slot_point)
}