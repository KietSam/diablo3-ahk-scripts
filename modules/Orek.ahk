#Include, %A_ScriptDir%\..\modules\Utils.ahk

OrekIsPopupActive() {
  return ColorAtSimilarTo(930, 1072, 0xEBEA15)
}

OrekWaitTillPopupActive(n:=100000) {
  time_waited := 0
  while !OrekIsPopupActive() {
    Sleep, 50
    time_waited += 50
    if (time_waited > n) {
      return
    }
  }
}