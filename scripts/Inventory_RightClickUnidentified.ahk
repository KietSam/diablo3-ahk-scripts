WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Inventory.ahk

if !InventoryIsPanelActive() {
  ExitApp
}

InventoryRightClickUnidentifiable()

ExitApp

Escape::
ExitApp
Return