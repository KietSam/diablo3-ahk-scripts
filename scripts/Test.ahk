#Include, Helpers.ahk

WinActivate, Diablo III ahk_class D3 Main Window Class

blood_shard_1k_color := 0xFFFFFF

PixelGetColor, blood_shard_1k_number_color, 2476, 1167
; MsgBox % "blood_shard_1k_number_color: " . blood_shard_1k_number_color

; Click, 970, 810, Left, Down
; Click, 970, 810, Left, Up

; KadalaClickWeaponTab()
; KadalaClickArmorTab()
; KadalaClickSlot(1)

; ; Quiver
; KadalaClickWeaponTab()
; Loop, 8 {
;   KadalaClickSlot(3)  
; }

; ; Feet
; KadalaClickArmorTab()
; Loop, 8 {
;   KadalaClickSlot(3)  
; }

; ; Belt
; Loop, 8 {
;   KadalaClickSlot(5)  
; }

; ; Gloves
; Loop, 8 {
;   KadalaClickSlot(5)  
; }

; Switch back and forth from Kadla to blacksmith
; Click, 1550, 320, Left
; Sleep, 2000
Click, 970, 810, Left
Sleep, 2000
Click, 1550, 320, Left
Sleep, 2000
Click, 970, 810, Left
Sleep, 2000
Click, 1550, 320, Left
Sleep, 2000
Click, 970, 810, Left
Sleep, 2000
Click, 1550, 320, Left
Sleep, 2000
Click, 970, 810, Left
Sleep, 2000