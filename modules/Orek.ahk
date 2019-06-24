#Include, %A_ScriptDir%\..\modules\Utils.ahk

OrekIsPopupActive() {
  return ColorAtSimilarTo(930, 1072, 0xEBEA15)
}

OrekWaitTillPopupActive() {
  while !OrekIsPopupActive() {
    Sleep, 50
  }
}