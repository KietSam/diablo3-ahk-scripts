#Include, %A_ScriptDir%\..\modules\Inventory.ahk


if !InventoryIsPanelActive() {
  ExitApp
  return
}

InventoryDragOutAllKnownInventory()

ExitApp

Escape::
ExitApp
Return