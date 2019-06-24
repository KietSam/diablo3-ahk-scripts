#Include, %A_ScriptDir%\..\modules\Utils.ahk

TownIsActive(n) {
  ; Checks if in town from the town portal position.
  points := [[Point(579, 397), Point(432, 571), Point(298, 150)]
            ,[Point(803, 165), Point(949, 103), Point(387, 798)]
            ,[]
            ,[]
            ,[]]
  colors := [[0xCB8661, 0xD58D66, 0x4C82CF]
            ,[0xF7A787, 0xF4AF85, 0xF8B484]
            ,[]
            ,[]
            ,[]]
  points := points[n]
  colors := colors[n]
  return ColorPointsAreSimilarTo(points, colors, 10, 10, 20)
}

TownWaitTillActive(n) {
  while !TownIsActive(n) {
    Sleep, 10
  }
}

TownClickKadala(n) {
  ; Clicks Kadala starting from the town portal.
  ; n: act number
  xs := [1990, 520, -1, -1, -1]
  ys := [575, 460, -1, -1, -1]
  if (xs[n] == -1) {
    Print("TownClickKadala: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}

TownClickBlacksmith(n) {
  ; Clicks blacksmith starting from the town portal.
  ; n: act number
  xs := [1830, -1, 2080, 2080, 1090]
  ys := [170, -1, 0, 0, 50]
  if (xs[n] == -1) {
    Print("TownClickBlacksmith: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}

TownClickOrek(n) {
  ; Clicks Orek starting from the town portal.
  ; n: act number
  xs := [2220, 435, 15, 15, 550]
  ys := [940, 915, 1170, 1170, 930]
  if (xs[n] == -1) {
    Print("TownClickOrek: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}

TownClickNephalemStone(n) {
  ; Clicks Orek starting from the town portal.
  ; n: act number
  xs := [2500, 145, -1, -1, 40]
  ys := [700, 652, -1, -1, 1100]
  if (xs[n] == -1) {
    Print("TownClickNephalemStone: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}

TownClickPortal(n) {
  ; Clicks the nephalem rift portal starting from the nephalem stone position
  ; n: act number
  xs := [1526, 1000, -1, -1, -1]
  ys := [552, 528, -1, -1, -1]
  if (xs[n] == -1) {
    Print("TownClickPortal: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}

TownClickStash(n) {
  ; Clicks Orek starting from the town portal.
  ; n: act number
  xs := [860, 604, 1035, 1035, 1698]
  ys := [141, 32, 225, 225, 37]
  if (xs[n] == -1) {
    Print("TownClickStash: Not supported for act " . n)
  } else {
    ClickAt(xs[n], ys[n])
  }
}