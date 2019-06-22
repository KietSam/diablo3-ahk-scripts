KadalaClickTab(n) {
  ; n : tab number
  ; 1 (Weapon tab)
  ; 2 (Armor tab)
  ; 3 (Jewlery tab)
  ClickAt(683, 312 + (n - 1) * 166)
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

KadalaIsPanelActive() {
  return ColorAtSimilarTo(328, 112, 0x749fd8)
      && ColorAtSimilarTo(342, 70, 0x17435f)
      && ColorAtSimilarTo(378, 100, 0x2692b0)
}