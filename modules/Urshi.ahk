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

UrshiClickSlot(x, y) {

  ; n: The slot number. (index starts at 1)
  ;    Starts at top-left and goes from left to right, top to bottom.
  ;    1 | 2 | 3 | 4 | 5
  ;    6 | 7 | 8 | 9 | 10
  ;    ...
  xx := 140 + 95 * (x - 1)
  yy := 865 + 100 * (y - 1)

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
  MoveAt(min_xx_fade, min_yy_fade)

  ; Wait for a bit to give it some time to disappear
  Sleep, 400
}

UrshiClickUpgrade() {
  ClickAt(360, 740)
}

UrshiClickUpgradeIf100PercentUpgradeChance() {
  if (UrshiIsGem100PercentUpgradeChance()) {
    UrshiClickUpgrade()
  }
}

