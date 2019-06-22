StashIsPanelActive() {
  return ColorAtSimilarTo(363, 102, 0x1C5C9F) && ColorAtSimilarTo(510, 65, 0x080811)
}

StashWaitTillActive() {
  while !StashIsPanelActive() {
    Sleep, 50
  }
}

StashClickTab(n) {
  ; n : tab number, index starts at 1.
  ;    e.g: 
  ;    1
  ;    2
  ;    ...
  ClickAt(680, 355 + (n - 1) * 170)
}

StashClickChest(n) {
  ; n : tab number, index starts at 1.
  ;    e.g: 1 | 2 | 3
  ClickAt(150 + (n - 1) * 65, 240)
}

StashSlotPoint(x, y, x_shift:=0, y_shift:=0) {
  return Point(122 + (x - 1) * 76.3 + x_shift, 329 + (y - 1) * 76.66 + y_shift)
}

StashClickSlot(x, y) {
  ; Coordinates starts from top left
  ; x: x-coord, starts at 1 (left to right) 
  ; y: y-coord, starts at 1 (top to bottom)
  ClickPoint(StashSlotPoint(x, y))
}

StashIsSlotEmpty(x, y) {
  return ColorPointSimilarTo(StashSlotPoint(x, y, 0, 30), 0x080B10)
      && ColorPointSimilarTo(StashSlotPoint(x, y, 0, -30), 0x080D15)
      ; && ColorPointSimilarTo(StashSlotPoint(x, y, -15, -15), 0x080D15)
}

StashNumEmptySlots() {
  num := 0
  Loop, 10 { ; Top -> Bottom
    y := A_Index
    Loop, 7 { ; Left -> Right
      x := A_Index
      if StashIsSlotEmpty(x, y) {
        num++
      }
    }
  }
  return num
}