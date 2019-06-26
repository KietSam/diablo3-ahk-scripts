WinActivate, Diablo III ahk_class D3 Main Window Class
#Include, %A_ScriptDir%\..\modules\Utils.ahk

stage := 0
saved_x := 0
saved_y := 0

saved_xs := []
saved_ys := []
saved_colors := []

F2::
if (saved_xs.Length() > 0) {
  ; Just reset the stage num if it was already set
  stage := 0
  lines := []
  lines.Push("s_xs: [" . ArrayJoin(saved_xs) . "]")
  lines.Push("s_ys: [" . ArrayJoin(saved_ys) . "]")
  lines.Push("s_colors: [" . ArrayJoin(saved_colors) . "]")

  Gui, New
  Gui +AlwaysOnTop
  Gui, Add, edit, h100 w500 , % ArrayJoin(lines, "`n")
  Gui, Show
  saved_xs := []
  saved_ys := []
  saved_colors := []
}
if (stage == 0) {
  MouseGetPos mouse_x, mouse_y
  saved_x := mouse_x
  saved_y := mouse_y
  stage++
} else {
  color := ColorAt(saved_x, saved_y)
  lines := []
  lines.Push("ClickAt(" . saved_x . ", " . saved_y . ")")
  lines.Push("Point(" . saved_x . ", " . saved_y . ")")
  lines.Push("ColorAtSimilarTo(" . saved_x . ", " . saved_y . ", " . color ")")
  lines.Push(saved_x . ", " . saved_y . ", " . color)

  Gui, New
  Gui +AlwaysOnTop
  Gui, Add, edit, h100 w500 , % ArrayJoin(lines, "`n")
  Gui, Show
  stage := 0
}
Return

F3::
MouseGetPos mouse_x, mouse_y
color := ColorAt(mouse_x, mouse_y)
saved_xs.Push(mouse_x)
saved_ys.Push(mouse_y)
saved_colors.Push(color)
Return