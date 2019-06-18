DisableChat() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
    Sleep, 500
  }
}

SmartEnter() {
  active_chat_panel_color = 0x8CCBFF
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
  Send, {Enter}
  Sleep, 100
  PixelGetColor, ChatOpenColor, 43, 1398
  if (ChatOpenColor = active_chat_panel_color) {
    Send, {Enter}
  }
}

;===============================================================
; Kadala stone
;===============================================================

KadalaClickWeaponTab() {
  Click, 680, 300, Left
}

KadalaClickArmorTab() {
  Click, 680, 470, Left
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
  Click, 350, 380, Left
}

RiftClickGreaterOption() {
  Click, 350, 600, Left
}

RiftClickAccept() {
  Click, 350, 1130, Left
}

;===============================================================
; Blacksmith
;===============================================================

BlacksmithIsPanelOpened() {
  active_color := 0x54D9F7
  PixelGetColor, curr_color, 350, 100
  return curr_color = active_color
}

BlacksmithIsSalvageTabActive() {
  inactive_color := 0x0212A4
  PixelGetColor, curr_color, 680, 650
  return curr_color != inactive_color
}

BlacksmithClickSalvageTab() {
  Click, 680, 650, Left
}

BlacksmithClickSalvageTabIfNotActive() {
  if (!BlacksmithIsSalvageTabActive()) {
    BlacksmithClickSalvageTab()
  }
}

BlacksmithIsSalvageActive() {
  active_salvage_color = 0x5DACFF
  PixelGetColor, curr_color, 222, 400
  return active_salvage_color = curr_color
}

BlacksmithClickSalvageButton() {
  Click, 222, 400, Left
}

BlacksmithClickSalvageButtonIfNotActive() {
  if (!BlacksmithIsSalvageActive()) {
    BlacksmithClickSalvageButton()
  }
}

BlacksmithIsRepairTabActive() {
  inactive_color := 0x00004C
  PixelGetColor, curr_color, 680, 800
  return curr_color != inactive_color
}

BlacksmithClickRepairTab() {
  Click, 680, 800, Left
}

BlacksmithClickRepairButton() {
  Click, 350, 780, Left
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
  PixelGetColor, curr_color, 605, 1060
  return curr_color != not_scrolled_all_the_way_down_color
}

UrshiScrollDownOnce() {
  Click, 400, 1000, 0
  Click, WheelDown
}

UrshiIsGem100PercentUpgradeChance() {
  gem_100_color := 0xFFFFFF
  PixelGetColor, curr_gem_100_color, 495, 680
  return curr_gem_100_color = gem_100_color
}

UrshiOneUpgradeLeft() {
  one_upgrade_left_color := 0xFFFFFF
  PixelGetColor, curr_color, 412, 730
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

  Loop % xxs_fade.Length() {
    xx_fade := xxs_fade[A_Index]
    yy_fade := yys_fade[A_Index]
    curr_distance := Distance(xx, yy, xx_fade, yy_fade)
    ; MsgBox % "xx_fade: " . xx_fade . ", yy_fade: " . yy_fade
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
  Click, 360, 740, Left
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