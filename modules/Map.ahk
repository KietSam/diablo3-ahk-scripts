#Include, %A_ScriptDir%\..\modules\Utils.ahk

MapIsPanelActive() {
  return ColorAtSimilarTo(1090, 110, 0x5094bb)
}

MapClickMinus() {
  ClickAt(1195, 170)
}

MapClickPlus() {
  ClickAt(1370, 170)
}

MapClickAct(n) {
  ; n: The act number.
  act_x := [990, 1450, 940, 1940, 770]
  act_y := [820, 700, 515, 485, 725]
  ClickAt(act_x[n], act_y[n])
}

MapClickTown(n) {
  ; n: The act number for the town
  town_x := [1360, 1380, 670, 680, 1560]
  town_y := [640, 1040, 640, 990, 830]
  ClickAt(town_x[n], town_y[n])
}

MapOpenTown(n) {
  if !MapIsPanelActive() {
    Send, {m}
    Sleep, 100
  }
  MapClickMinus()
  MapClickAct(n)
  MapClickTown(n)
  Sleep, 2000
}

MapIsActActive(n) {
  ; Use 3 points in order to what act we're currently in.
  points := [[Point(1357, 640), Point(776, 791), Point(1805, 695)]
            ,[Point(1382, 1036), Point(577, 839), Point(1971, 375)]
            ,[Point(679, 637), Point(1879, 299), Point(1736, 1046)]
            ,[Point(680, 986), Point(1920, 334), Point(878, 318)]
            ,[Point(1555, 827), Point(981, 735), Point(1387, 709)]]
  colors := [[0xFFFFFF, 0x263334, 0x427594]
            ,[0xFFFFFF, 0x153450, 0x0A121A]
            ,[0xFFFFFF, 0x0B1723, 0x0E1826]
            ,[0xFFFFFF, 0x1C3448, 0x386782]
            ,[0xFFFFFF, 0x162C36, 0x112436]]
  points := points[n]
  colors := colors[n]
  Loop % points.Length() {
    if (!ColorPointSimilarTo(points[A_Index], colors[A_Index])) {
      return false
    }
  }
  return true
}

MapWhatActIsActive() {
  Loop, 5 {
    if MapIsActActive(A_Index) {
      return A_Index
    }
  }
}