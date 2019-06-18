DEFAULT_RESOLUTION_WIDTH := 2560
DEFAULT_RESOLUTION_HEIGHT := 1440

RESOLUTION_WIDTH := 2560
RESOLUTION_HEIGHT := 1440

WidthRatio() {
  global RESOLUTION_WIDTH
  global DEFAULT_RESOLUTION_WIDTH
  return RESOLUTION_WIDTH / DEFAULT_RESOLUTION_WIDTH
}

HeightRatio() {
  global RESOLUTION_HEIGHT
  global DEFAULT_RESOLUTION_HEIGHT
  return RESOLUTION_HEIGHT / DEFAULT_RESOLUTION_HEIGHT
}

Point(x, y) {
  xx := Round(x * WidthRatio())
  yy := Round(y * HeightRatio())
  return [xx, yy]
}

ClickPoint(p) {
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Left
}

ClickPoint(x, y) {
  p := Point(x, y)
  x := p[1]
  y := p[2]
  Click, %x%, %y%, Left
}

PrintPoint(p) {
  MsgBox % "p[1]: " . p[1] . ", p[2]: " . p[2]
}

DisableChat() {
  active_color = 0x8CCBFF
  PixelGetColor, curr_color, 43, 1398
  if (curr_color = active_color) {
    Send, {Enter}
    Sleep, 500
  }
}

SmartEnter() {
  DisableChat()
  Send, {Enter}
  Sleep, 100
  DisableChat()
}

;===============================================================
; Kadala stone
;===============================================================

KadalaClickWeaponTab() {
  p := Point(680, 300)
  ClickPoint(p)
}

KadalaClickArmorTab() {
  p := Point(680, 470)
  ClickPoint(p)
}

KadalaClickSlot(n) {
  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2
  ;    3 | 4
  ;    ...
  xx := 210 + 290 * Mod(n - 1, 2)
  yy := 280 + 130 * (Ceil(n / 2) - 1)
  Click, %xx%, %yy%, Right
}

;===============================================================
; Rift stone
;===============================================================

RiftClickNephalemOption() {
  p := Point(350, 380)
  ClickPoint(p)
}

RiftClickGreaterOption() {
  p := Point(350, 600)
  ClickPoint(p)
}

RiftClickAccept() {
  p := Point(350, 1130)
  ClickPoint(p)
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
  xx_delta = 67
  yy_delta = 65
  top_left_xx = 1837
  top_left_yy = 717
  xx := top_left_xx + x * xx_delta
  yy := top_left_yy + y * yy_delta
  return [xx, yy]
}

InventoryIsSlotEmpty(x, y) {
  ; x: Column number. (index starts at 1)
  ; y: Row number.
  ;    Example grid:
  ;    (1, 1) | (2, 1) | (3, 1) | ...
  ;    (1, 2) | (2, 2) | (3, 2) | ...
  ;    ...
  xx_delta = 67
  yy_delta = 65
  top_left_xx = 1837
  top_left_yy = 717
  xx := top_left_xx + x * xx_delta
  yy := top_left_yy + y * yy_delta

  empty_slot_color1 = 0x080D10
  empty_slot_color2 = 0x080E10
  PixelGetColor, slot_color, %xx%, %yy%
  return slot_color == empty_slot_color1 || slot_color == empty_slot_color2
}

InventoryClickSlot(x, y) {
  xx_delta = 67
  yy_delta = 65
  top_left_xx = 1837
  top_left_yy = 717
  xx := top_left_xx + x * xx_delta
  yy := top_left_yy + y * yy_delta
  Click, %xx%, %yy%, Left
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
  p := Point(680, 650)
  ClickPoint(p)
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
  p := Point(222, 400)
  PrintPoint(p)
  ClickPoint(p)
}

BlacksmithClickSalvageButtonIfNotActive() {
  MsgBox % BlacksmithIsSalvageActive()
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
  p := Point(680, 800)
  ClickPoint(p)
}

BlacksmithClickRepairButton() {
  p := Point(350, 780)
  ClickPoint(p)
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
  p := Point(360, 740)
  ClickPoint(p)
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
