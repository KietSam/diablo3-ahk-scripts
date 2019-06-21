WinActivate, Diablo III ahk_class D3 Main Window Class
#Include, %A_ScriptDir%\..\modules\Helpers.ahk

Run(x, y) {
  Sleep, 120

  KanaiCubeClickRecipe()

  InventoryRightClickSlot(x, y)

  DisableChat()

  KanaiCubeRecipeClickFill()

  KanaiCubeClickTransmute()

  MoveAt(150, 600)
  Sleep, 200

  SmartEnter()
  Sleep, 1500

  KanaiCubeRemoveItem()
}

; Top -> Down
Loop, 6 {
  i := A_Index
  ; Left -> Right
  Loop, 8 {
    j := A_Index
    x := j
    y := i
    if !InventoryIsSlotEmpty(x, y) {
      Run(x, y)
    }
  }
}

Escape::
ExitApp
Return


; Move back to original mouse position
; Click, %xx%, %yy%, 0