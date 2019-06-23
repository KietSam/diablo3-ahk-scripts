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

IsGoodClickRegion(x, y) {
  ; Checks if the given x and y coordinates are in a good clickable region.
  ; x: x position in terms of user's resolution
  ; y: y position in terms of user's resolution
  ; Character portraits
  char_portrait_p := Point(140, 800)
  if (x <= char_portrait_p[1] && y <= char_portrait_p[2]) {
    return false
  }
  ; Follower portraits
  follower_portrait_p := Point(260, 125)
  if (x <= follower_portrait_p[1] && y <= follower_portrait_p[2]) {
    return false
  }
  ; Skill Bar
  skill_bar_top_left_p := Point(825, 1300)
  skill_bar_bot_right_p := Point(1725, 1440)
  if (x >= skill_bar_top_left_p[1] && x <= skill_bar_bot_right_p[1] && y <= skill_bar_bot_right_p[2] && y >= skill_bar_top_left_p[2]) {
    return false
  }
  return true
}