#Include, %A_ScriptDir%\..\scripts\Blacksmith.ahk
#Include, %A_ScriptDir%\..\scripts\Chat.ahk
#Include, %A_ScriptDir%\..\scripts\Map.ahk
#Include, %A_ScriptDir%\..\scripts\Town.ahk
#Include, %A_ScriptDir%\..\scripts\Utils.ahk


IsInGame() {
  active := true
  xs := [545, 545, 620]
  ys := [1325, 1380, 1325]
  active_colors := [0X161513, 0X544E4B, 0X0F0F0F]

  Loop, 3 { ; We have 4 points but just check 3 cause it's faster
    active := active && ColorAtSimilarTo(xs[A_Index], ys[A_Index], active_colors[A_Index], 4, 4, 3)
    if !active {
      return false
    }
  }
  return active
}

WaitTillInGame() {
  ; Sleeps until in game.
  while !IsInGame() {
    Sleep, 50
  }
}

;===============================================================
; Game Menu (the menu when you press ESC while in-game)
;===============================================================

GameMenuItemPoint(n) {
  start_x := 465
  start_y := 425
  delta_y := 75
  return Point(start_x, start_y + (n - 1) * delta_y)
}

GameMenuActive() {
  active := true
  start_x := 465
  start_y := 425
  delta_y := 75
  active_colors := [0x0B070A, 0X0C0B0C, 0X0D0E0F]

  Loop, 3 {
    p := GameMenuItemPoint(A_Index)
    active := active && ColorPointSimilarTo(p, active_colors[A_Index])
    if !active {
      return false
    }
  }
  return active
}

GameMenuClick(n) {
  ; n: The left menu item to click. index starts at 1
  ;    (1) Options      
  ;    (2) Achievements 
  ;    (3) Customer Service 
  ;    (4) Leave Game
  ;    (5) Exit Diablo 3
  ClickPoint(GameMenuItemPoint(n))
}

GameMenuOpen() {
  while !GameMenuActive() {
    Send, {Esc}
    Sleep, 200
  }
}

;===============================================================
; Start Screen
;===============================================================

StartScreenActive() {
  active := true
  start_x := 2010
  start_y := 1320
  delta_x := 93
  active_colors := [0x2C2D2C, 0x2B2C2C, 0x2B2B2B]

  Loop, 3 {
    active := active && ColorAtSimilarTo(start_x + (A_Index - 1) * delta_x, start_y, active_colors[A_Index])
    if !active {
      return false
    }
  }
  return active
}

StartScreenWaitActive() {
  while !StartScreenActive() {
    Sleep, 50
  }
  Sleep, 200
}

StartScreenClickStartGame() {
  ClickAt(320, 680)
}

;===============================================================
; Skill bar
;===============================================================

SkillIsInactive(n) {
  ; n: The skill slot, index starts at 1.
  ;    e.g: 1 | 2 | 3 | 4
  inactive_colors := [000000, 000000, 000000, 000000]
  pos_x := [850, 939, 1027, 1117]
  pos_y := [1328, 1328, 1328, 1328]
  return ColorAtSimilarTo(pos_x[n], pos_y[n], inactive_colors[n], 6, 6, 3)
}

;===============================================================
; Kanai Cube Panel
;===============================================================

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

;===============================================================
; Kadala stone
;===============================================================

KadalaClickWeaponTab() {
  ClickAt(680, 300)
}

KadalaClickArmorTab() {
  ClickAt(680, 470)
}

KadalaClickSlot(n) {
  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2
  ;    3 | 4
  ;    ...
  xx := 210 + 290 * Mod(n - 1, 2)
  yy := 280 + 130 * (Ceil(n / 2) - 1)
  RightClickAt(xx, yy)
}

;===============================================================
; Rift stone
;===============================================================

RiftClickNephalemOption() {
  ClickAt(350, 380)
}

RiftClickGreaterOption() {
  ClickAt(350, 600)
}

RiftClickAccept() {
  ClickAt(350, 1130)
}

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
  num := 0
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
  return num
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

;===============================================================
; Urshi (Gem upgrade person)
;===============================================================

UrshiIsPanelActive() {
  return ColorAtSimilarTo(346, 180, 0x00A3FF)
}

UrshiIsScrolledDownAllTheWay() {
  not_scrolled_all_the_way_down_color := 0x000000
  p := Point(605, 1060)
  PixelGetColor, curr_color, p[1], p[2]
  return curr_color != not_scrolled_all_the_way_down_color
}

UrshiScrollDownOnce() {
  p := Point(400, 1000)
  Click, p[1], p[2], 0
  Click, WheelDown
}

UrshiIsGem100PercentUpgradeChance() {
  gem_100_color := 0xFFFFFF
  PixelGetColor, curr_gem_100_color, 495, 680
  return curr_gem_100_color = gem_100_color
}

UrshiOneUpgradeLeft() {
  return ColorAtSimilarTo(412, 730, 0xFFFFFF)
  ; one_upgrade_left_color := 0xFFFFFF
  ; p := Point(412, 730)
  ; PixelGetColor, curr_color, p[1], p[2]
  ; return one_upgrade_left_color = curr_color
}

UrshiClickSlot(n) {
  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2 | 3 | 4 | 5
  ;    6 | 7 | 8 | 9 | 10
  ;    ...
  xx := 140 + 95 * Mod(n - 1, 5)
  yy := 865 + 100 * (Ceil(n / 5) - 1)

  ; Click gem
  Click, %xx%, %yy%, Left

  xxs_fade := [70, 570, xx, xx]
  yys_fade := [yy, yy, 780, 1150]

  min_distance := 100000
  min_xx_fade := 0
  min_yy_fade := 0

  ; Found then nearest spot where we can move the house 
  ; so that the popup doesn't appear.
  Loop % xxs_fade.Length() {
    xx_fade := xxs_fade[A_Index]
    yy_fade := yys_fade[A_Index]
    curr_distance := Distance(xx, yy, xx_fade, yy_fade)
    if (curr_distance < min_distance) {
      min_distance := curr_distance
      min_xx_fade := xx_fade
      min_yy_fade := yy_fade
    }
  }

  ; Move mouse in a position where the popup doesn't appear
  Click, %min_xx_fade%, %min_yy_fade%, 0

  ; Wait for a bit to give it some time to disappear
  Sleep, 500
}

UrshiClickUpgrade() {
  ClickAt(360, 740)
}

UrshiClickUpgradeIf100PercentUpgradeChance() {
  if (UrshiIsGem100PercentUpgradeChance()) {
    UrshiClickUpgrade()
  }
}

