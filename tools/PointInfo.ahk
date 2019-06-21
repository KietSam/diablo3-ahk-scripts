WinActivate, Diablo III ahk_class D3 Main Window Class
SetWorkingDir %A_ScriptDir%
#Include, %A_ScriptDir%\..\modules\Helpers.ahk



stage := 0
saved_x := 0
saved_y := 0

F2::
if (stage == 0) {
  MouseGetPos mouse_x, mouse_y
  saved_x := mouse_x
  saved_y := mouse_y
  stage++
} else {
  color := ColorAt(saved_x, saved_y)
  text1 := "Point(" . saved_x . ", " . saved_y . ")"
  text2 := "ColorAtSimilarTo(" . saved_x . ", " . saved_y . ", " . color ")"
  text3 := saved_x . ", " . saved_y . ", " . color
  Gui, New
  Gui +AlwaysOnTop
  Gui, Add, edit, h100 w200 , % text1 . "`n" . text2 . "`n" . text3
  Gui, Show
  stage := 0
}
Return
