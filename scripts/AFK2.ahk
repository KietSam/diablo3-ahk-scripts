first_run := true

AutoSend:
if (!first_Run) {
  Click, WheelDown
  Sleep, 100
  Click, WheelUp
}
first_run := false
Return

F3::
AutoSend := !AutoSend
If AutoSend {
  Click, WheelDown
  Sleep, 100
  Click, WheelUp
  SetTimer AutoSend, 90000
} Else {
  SetTimer AutoSend, Off
}
Return

F4::
ExitApp
Return