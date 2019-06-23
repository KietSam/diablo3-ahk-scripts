DEFAULT_SCREEN_RESOLUTION_WIDTH := 2560
DEFAULT_SCREEN_RESOLUTION_HEIGHT := 1440

WidthRatio() {
  global DEFAULT_SCREEN_RESOLUTION_WIDTH
  return A_ScreenWidth / DEFAULT_SCREEN_RESOLUTION_WIDTH
}

HeightRatio() {
  global DEFAULT_SCREEN_RESOLUTION_HEIGHT
  return A_ScreenHeight / DEFAULT_SCREEN_RESOLUTION_HEIGHT
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

ColorPointSimilarTo(p, color, search_width:=4, search_height:=4, variance:=3, debug:=false) {
  search_diameter_width := search_width * WidthRatio()
  search_diameter_height := search_height * HeightRatio()
  top_left := [p[1] - search_diameter_width / 2, p[2] - search_diameter_height / 2]
  bot_right := [p[1] + search_diameter_width / 2, p[2] + search_diameter_height / 2]
  PixelSearch, cx, cy, top_left[1], top_left[2], bot_right[1], bot_right[2], color, variance, Fast

  similar := true
  if ErrorLevel {
    similar := false
  }

  if debug {
    Print("color at (" . p[1] . ", " . p[2] . "): " . ColorPoint(p) . ", similar?: " . similar)
    MovePoint(p)
  }
  return similar
}

ColorAtSimilarTo(x, y, color, search_width:=4, search_height:=4, variance:=3, debug:=false) {
  p := Point(x, y)
  return ColorPointSimilarTo(p, color, search_width, search_height, variance, debug)
}

WaitTillPointIsColor(p, color, search_width:=4, search_height:=4, variance:=3) {
  while (!ColorPointSimilarTo(p, color, search_width:=4, search_height:=4, variance:=3)) {
    Sleep, 50
  }
  Sleep, 100
}


IsEmptySlotColorAt(x, y) {
  p := Point(x, y)
  return IsEmptySlotColorPoint(p)
}

IsEmptySlotColorPoint(p) {
  return ColorPointSimilarTo(p, 0x080808)
}

Point(x, y) {
  ; x: x-coordinate in terms of the DEFAULT_SCREEN_RESOLUTION_WIDTH
  ; y: y-coordinate in terms of the DEFAULT_SCREEN_RESOLUTION_HEIGHT
  ; Returns: A point that is scaled in terms of the 
  ;          user's screen height and screen width.
  xx := Round(x * WidthRatio())
  yy := Round(y * HeightRatio())
  return [xx, yy]
}

DragPoint(p1, p2) {
  x1 := p1[1]
  y1 := p1[2]
  Click, %x1%, %y1%, Down
  x2 := p2[1]
  y2 := p2[2]
  Click, %x2%, %y2%, Up
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

MovePoint(p) {
  x := p[1]
  y := p[2]
  Click, %x%, %y%, 0
}

MoveAt(x, y) {
  p := Point(x, y)
  MovePoint(p)
}

ClickAt(x, y) {
  p := Point(x, y)
  ClickPoint(p)
}

RightClickAt(x, y) {
  p := Point(x, y)
  RightClickPoint(p)
}

ColorAt(x, y) {
  p := Point(x, y)
  return ColorPoint(p)
}

ColorPoint(p) {
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

Square(x) {
  return x * x
}

Distance(x1, y1, x2, y2) {
  return Sqrt(Square(x1 - x2) + Square(y1 - y2))
}

ArrayJoin(arr, sep:=", ") {
  res := ""
  for i, s in arr {
    if (i == 1) {
      res .= s
    } else {
      res .= sep . s
    }
  }
  return res
}