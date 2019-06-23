#Include, %A_ScriptDir%\..\modules\Inventory.ahk

if !InventoryIsPanelActive() {
  ExitApp
}

InventoryRightClickUnidentifiable()


Escape::
ExitApp
Return