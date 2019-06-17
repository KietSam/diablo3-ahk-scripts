#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

blood_shard_1k_color := 0xFFFFFF

PixelGetColor, blood_shard_1k_number_color, 2476, 1167
MsgBox % "blood_shard_1k_number_color: " . blood_shard_1k_number_color

; salvage_icons_xx := [335, 430, 515]
; salvage_icons_yy := [390, 390, 390]
; salvage_icons_inactive_color := [0x12274E, 0x0B0804, 0x272D4A]

; Loop % salvage_icons_xx.Length() {
;   xx := salvage_icons_xx[A_Index]
;   yy := salvage_icons_yy[A_Index]
;   inactive_color := salvage_icons_inactive_color[A_Index]
;   PixelGetColor, salvage_icon_color, xx, yy
;   ; MsgBox % "xx: " . xx ", yy: " . yy . ", salvage_icon_color: " . salvage_icon_color
;   if (salvage_icon_color != inactive_color) {
;     Click, %xx%, %yy%, Left, Down
;     Click, %xx%, %yy%, Left, Up
;     SmartEnter()
;   }
; }


