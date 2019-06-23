WinActivate, Diablo III ahk_class D3 Main Window Class
#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\KanaiCube.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Chat.ahk

Run(x, y) {
  Sleep, 120

  KanaiCubeClickRecipe()

  InventoryRightClickSingleSlot(x, y)

  DisableChat()

  KanaiCubeRecipeClickFill()

  KanaiCubeClickTransmute()

  MoveAt(150, 600)
  Sleep, 200

  SmartEnter()
  Sleep, 1500

  KanaiCubeRemoveItem()
}

if (!KanaiCubeIsPanelActive()) {
  ExitApp
  Return
}

; Top -> Down
Loop, 6 {
  i := A_Index
  ; Left -> Right
  Loop, 8 {
    j := A_Index
    x := j
    y := i
    if !InventoryIsSingleSlotEmpty(x, y) {
      Run(x, y)
    }
  }
}

Escape::
ExitApp
Return


; Move back to original mouse position
; Click, %xx%, %yy%, 0