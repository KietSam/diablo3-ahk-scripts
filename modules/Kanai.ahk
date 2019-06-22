KanaiCubeIsPanelActive() {
  active_color := 0x26B4EE
  return ColorAt(350, 75) == active_color
}

KanaiCubeClickTransmute() {
  if KanaiCubeIsPanelActive() {
    ClickAt(470, 1100)
  }
}

KanaiCubeClickRecipe() {
  if KanaiCubeIsPanelActive() && !KanaiCubeIsRecipePanelActive() {
    ClickAt(575, 1100)
  }
}


KanaiCubeIsRecipePanelActive() {
  if KanaiCubeIsPanelActive() {
    active_color := 0x080D2B
    return ColorAt(900, 100) == active_color
  }
  return 0
}

KanaiCubeRecipeClickLeft(n) {
  ; n: number of times to click left
  if KanaiCubeIsRecipePanelActive() {
    Loop % n {
      ClickAt(775, 1120)
    }
  }
}

KanaiCubeRecipeClickRight(n) {
  ; n: number of times to click right
  if KanaiCubeIsRecipePanelActive() {
    Loop % n {
      ClickAt(1140, 1120)
    }
  }
}

KanaiCubeRecipeClickFill() {
  ; n: number of times to click right
  if KanaiCubeIsRecipePanelActive() {
    ClickAt(900, 1100)
  }
}

KanaiCubeRecipeSetPage1() {
  if KanaiCubeIsRecipePanelActive() {
    KanaiCubeRecipeClickLeft(9)
  }
}

KanaiCubeRecipeSetPage(n) {
  start := A_TickCount
  if KanaiCubeIsRecipePanelActive() {
    KanaiCubeRecipeSetPage1()
    n := n - 1
    KanaiCubeRecipeClickRight(n)
  }
  end := A_TickCount - start
  Print(end)
}

KanaiCubeSlotPoint(n) {
  xx := 290 + 70 * Mod(n - 1, 3)
  yy := 540 + 75 * (Ceil(n / 3) - 1)
  return Point(xx, yy)
}

KanaiCubeIsSlotEmpty(n) {
  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2 | 3
  ;    4 | 5 | 6
  ;    ...
  slot_point := KanaiCubeSlotPoint(n)
  return IsEmptySlotColorPoint(slot_point)
}

KanaiCubeRemoveItem() {
  if KanaiCubeIsPanelActive() {
    ; These are all the spots that a 1 slot or 2 slot item will be in.
    RightClickPoint(KanaiCubeSlotPoint(1))
    RightClickPoint(KanaiCubeSlotPoint(3))
    RightClickPoint(KanaiCubeSlotPoint(9))
  }
}