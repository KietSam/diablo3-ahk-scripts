DEFAULT_SCREEN_RESOLUTION_WIDTH := 2560
DEFAULT_SCREEN_RESOLUTION_HEIGHT := 1440

USER_SCREEN_RESOLUTION_WIDTH := 2560
USER_SCREEN_RESOLUTION_HEIGHT := 1440


WidthRatio() {
  global USER_SCREEN_RESOLUTION_WIDTH
  global DEFAULT_SCREEN_RESOLUTION_WIDTH
  return USER_SCREEN_RESOLUTION_WIDTH / DEFAULT_SCREEN_RESOLUTION_WIDTH
}

HeightRatio() {
  global USER_SCREEN_RESOLUTION_HEIGHT
  global DEFAULT_SCREEN_RESOLUTION_HEIGHT
  return USER_SCREEN_RESOLUTION_HEIGHT / DEFAULT_SCREEN_RESOLUTION_HEIGHT
}

IndexOf(arr, val) {
  ; Returns the index of val if it exists.
  ; If it does not exist, returns 0.
  ; Note that AHK is 1-indexed for arrays.
  Loop % arr.Length() {
    if (arr[A_Index] == val) {
      return A_Index
    }
  }
  return 0
}

Exists(arr, val) {
  return IndexOf(arr, val)
}

IsEmptySlotColor(c) {
  empty_slot_colors := [0x080808, 0x080D10, 0x080E10, 0x080D0D, 0x080E0E]
  return Exists(empty_slot_colors, c)
}

Point(x, y) {
  ; x: x-coordinate in terms of the DEFAULT_SCREEN_RESOLUTION_WIDTH
  ; y: y-coordinate in terms of the DEFAULT_SCREEN_RESOLUTION_HEIGHT
  ; Returns: A point that is scaled in terms of the 
  ;          USER_SCREEN_RESOLUTION_WIDTH and USER_SCREEN_RESOLUTION_HEIGHT.
  xx := Round(x * WidthRatio())
  yy := Round(y * HeightRatio())
  return [xx, yy]
}

ClickPoint(p) {
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Left
}

RightClickPoint(p) {
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Right
}

MoveAt(x, y) {
  p := Point(x, y)
  x := p[1]
  y := p[2]
  Click, %x%, %y%, 0
}

ClickAt(x, y) {
  p := Point(x, y)
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Left
}

RightClickAt(x, y) {
  p := Point(x, y)
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Right
}

ColorAt(x, y) {
  p := Point(x, y)
  x := p[1]
  y := p[2]
  PixelGetColor, curr_color, %x%, %y%
  return curr_color
}

GetMousePoint() {
  MouseGetPos, xx, yy
  return [xx, yy]
}

PrintPoint(p) {
  MsgBox % "PrintPoint: p[1]: " . p[1] . ", p[2]: " . p[2]
}

Print(s) {
  MsgBox % s
}

SmartEnter() {
  ; Smartly presses Enter by disabling chat panel if it's open
  DisableChat()
  Send, {Enter}
  Sleep, 100
  DisableChat()
}

;===============================================================
; Chat
;===============================================================

IsChatPanelActive() {
  active_color := 0x000000
  return ColorAt(40, 1200) = active_color
}

IsInChatPanelArea(p) {
  top_left := Point(0, 635)
  bot_right := Point(720, 1215)
  x_good := p[1] >= top_left[1] && p[1] <= bot_right[2]
  y_good := p[2] >= top_left[2] && p[2] <= bot_right[2]
  return x_good && y_good 
}

DisableChat() {
  if IsChatPanelActive() {
    ; Move mouse so it's not on that chat panel
    curr_mouse_p := GetMousePoint()
    if IsInChatPanelArea(curr_mouse_p) {
      MoveAt(720, curr_mouse_p[2])
    }
    Send, {Enter}
    Sleep, 400
  }
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

IsEmptySlotColorPoint(p) {
  search_diameter_width := 6 * WidthRatio()
  search_diameter_height := 6 * HeightRatio()

  top_left := [p[1] - search_diameter_width / 2, p[2] - search_diameter_height / 2]
  bot_right := [p[1] + search_diameter_width / 2, p[2] + search_diameter_height / 2]

  PixelSearch, cx, cy, top_left[1], top_left[2], bot_right[1], bot_right[2], 0x080808, 9, Fast
  if ErrorLevel {
    return false
  } else {
    return true
  }
}

IsEmptySlotColorAt(x, y) {
  p := Point(x, y)
  IsEmptySlotColorPoint(p)
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
;===============================================================

InventoryGetSlotCoordinates(x, y) {
  ; x: Column number. (index starts at 1)
  ; y: Row number.
  ;    Example grid:
  ;    (1, 1) | (2, 1) | (3, 1) | ...
  ;    (1, 2) | (2, 2) | (3, 2) | ...
  ;    ...
  xx_delta := 67 * WidthRatio()
  yy_delta := 65 * HeightRatio()
  top_left := Point(1837, 717)
  xx := top_left[1] + x * xx_delta
  yy := top_left[2] + y * yy_delta
  return [xx, yy]
}

InventoryIsSlotEmpty(x, y) {
  ; x: Column number. (index starts at 1)
  ; y: Row number.
  ;    Example grid:
  ;    (1, 1) | (2, 1) | (3, 1) | ...
  ;    (1, 2) | (2, 2) | (3, 2) | ...
  ;    ...
  slot_point := InventoryGetSlotCoordinates(x, y)
  empty_slot_colors := [0x080808, 0x080D10, 0x080E10]
  slot_color := ColorAt(slot_point[1], slot_point[2])
  return Exists(empty_slot_colors, slot_color)
}

InventoryClickSlot(x, y) {
  slot_point := InventoryGetSlotCoordinates(x, y)
  ClickPoint(slot_point)
}

InventoryRightClickSlot(x, y) {
  slot_point := InventoryGetSlotCoordinates(x, y)
  RightClickPoint(slot_point)
}

;===============================================================
; Blacksmith
;===============================================================

BlacksmithIsPanelOpened() {
  active_color := 0x54D9F7
  p := Point(350, 100)
  PixelGetColor, curr_color, p[1], p[2]
  return curr_color = active_color
}

BlacksmithIsSalvageTabActive() {
  inactive_color := 0x0212A4
  p := Point(680, 650)
  PixelGetColor, curr_color, p[1], p[2]
  return curr_color != inactive_color
}

BlacksmithClickSalvageTab() {
  ClickAt(680, 650)
}

BlacksmithClickSalvageTabIfNotActive() {
  if (!BlacksmithIsSalvageTabActive()) {
    BlacksmithClickSalvageTab()
  }
}

BlacksmithIsSalvageActive() {
  inactive_color := 0x315DB4
  p := Point(222, 400)
  PixelGetColor, curr_color, p[1], p[2]
  return curr_color != inactive_color
}

BlacksmithClickSalvageButton() {
  ClickAt(222, 400)
}

BlacksmithClickSalvageButtonIfNotActive() {
  if (!BlacksmithIsSalvageActive()) {
    BlacksmithClickSalvageButton()
  }
}

BlacksmithIsRepairTabActive() {
  inactive_color := 0x00004C
  p := Point(680, 800)
  PixelGetColor, curr_color, p[1], p[2]
  return curr_color != inactive_color
}

BlacksmithClickRepairTab() {
  ClickAt(680, 800)
}

BlacksmithClickRepairButton() {
  ClickAt(350, 780)
}

BlacksmithSalvageWhiteBlueYellow() {
  if (!BlacksmithIsPanelOpened()) {
    return
  }
  if (!BlacksmithIsSalvageTabActive()) {
    BlacksmithClickSalvageTab()
  }
  salvage_icons_xx := [335, 430, 515]
  salvage_icons_yy := [390, 390, 390]
  salvage_icons_inactive_color := [0x12274E, 0x0B0804, 0x272D4A]

  Loop % salvage_icons_xx.Length() {
    xx := salvage_icons_xx[A_Index]
    yy := salvage_icons_yy[A_Index]
    inactive_color := salvage_icons_inactive_color[A_Index]
    PixelGetColor, salvage_icon_color, xx, yy
    if (salvage_icon_color != inactive_color) {
      Click, %xx%, %yy%, Left
      SmartEnter()
    }
  }
}

;===============================================================
; Urshi (Gem upgrade person)
;===============================================================

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
  one_upgrade_left_color := 0xFFFFFF
  p := Point(412, 730)
  PixelGetColor, curr_color, p[1], p[2]
  return one_upgrade_left_color = curr_color
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

Square(x) {
  return x * x
}

Distance(x1, y1, x2, y2) {
  return Sqrt(Square(x1 - x2) + Square(y1 - y2))
}
