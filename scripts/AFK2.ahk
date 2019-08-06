AutoSend:
Click, WheelDown
Sleep, 100
Click, WheelDown
Sleep, 100
Click, WheelUp
Sleep, 100
Click, WheelUp
Return

F2::
AutoSend := !AutoSend
If AutoSend {
  Click, WheelDown
  Sleep, 100
  Click, WheelDown
  Sleep, 100
  Click, WheelUp
  Sleep, 100
  Click, WheelUp
  SetTimer AutoSend, 30000
} Else {
  SetTimer AutoSend, Off
}
Return

F4::
ExitApp
Return