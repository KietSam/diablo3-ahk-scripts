#Include, %A_ScriptDir%\..\modules\Helpers.ahk

if !InventoryIsPanelActive() {
  ExitApp, [ ExitCode]
}

InventoryRightClickUnidentifiable()


Escape::
ExitApp
Return