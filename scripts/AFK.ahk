WinActivate, Diablo III ahk_class D3 Main Window Class

; Include modules here
; #Include, %A_ScriptDir%\..\modules\Blacksmith.ahk
; #Include, %A_ScriptDir%\..\modules\Chat.ahk
; #Include, %A_ScriptDir%\..\modules\Inventory.ahk
; #Include, %A_ScriptDir%\..\modules\Kadala.ahk
; #Include, %A_ScriptDir%\..\modules\Kanai.ahk
; #Include, %A_ScriptDir%\..\modules\Map.ahk
; #Include, %A_ScriptDir%\..\modules\Misc.ahk
; #Include, %A_ScriptDir%\..\modules\RiftStone.ahk
; #Include, %A_ScriptDir%\..\modules\Skills.ahk
; #Include, %A_ScriptDir%\..\modules\Stash.ahk
; #Include, %A_ScriptDir%\..\modules\Town.ahk
; #Include, %A_ScriptDir%\..\modules\Urshi.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk

; Start here


toggle := true

point := GetMousePoint()

While, True {
  ; if (toggle) {
  ;   point[1] += 100
  ;   toggle := false
  ; } else {
  ;   point[1] -= 100
  ;   toggle := true
  ; }
  ; ClickPoint(point)
  ; Send, {Enter}
  ; Sleep, 100
  ; Send, {Space}
  ; Sleep, 100
  ; Send, {Enter}
  ; Sleep, 100
  ; Send, {Esc}
  Click, WheelDown
  Sleep, 100
  Click, WheelDown
  Sleep, 100
  Click, WheelUp
  Sleep, 100
  Click, WheelUp
  Sleep, 100
  Sleep, 120000
}


F1::
ExitApp
Return
