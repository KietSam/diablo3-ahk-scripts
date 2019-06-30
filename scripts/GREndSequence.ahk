WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Blacksmith.ahk
#Include, %A_ScriptDir%\..\modules\Kadala.ahk
#Include, %A_ScriptDir%\..\modules\Orek.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\RiftStone.ahk
#Include, %A_ScriptDir%\..\modules\Town.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Urshi.ahk
#Include, %A_ScriptDir%\..\modules\Misc.ahk
#Include, %A_ScriptDir%\..\modules\Sequences.ahk

SpendBloodShards_() {
  Loop, 3 {
    ; Quiver
    KadalaClickTab(1)
    Loop, 3 {
      KadalaClickSlot(3)
      Sleep, 50
    }

    KadalaClickTab(2)
    ; Feet
    Loop, 3 {
      KadalaClickSlot(3)  
      Sleep, 50
    }

    ; Gloves
    Loop, 3 {
      KadalaClickSlot(2)  
      Sleep, 50
    }

    ; Belt
    Loop, 6 {
      KadalaClickSlot(5)  
      Sleep, 50
    }

    ; Gloves
    Loop, 3 {
      KadalaClickSlot(5)  
      Sleep, 50
    }

    ; kadala -> blacksmith
    ClickAt(1530, 350)
    BlacksmithWaitTillPanelActive()
    BlacksmithSalvageWhiteBlueYellow()

    ; blacksmith -> kadala
    ClickAt(980, 840)
    KadalaWaitTillPanelActive()
  }
  ; kadala -> blacksmith
  ClickAt(1530, 350)
}

HomeSequence() {
  MapOpenTown(3)
  InventoryOpenPanel()
  is_armor_damaged := IsArmorDamaged()
  num_empty_slots := InventoryNumEmptySlots()
  blood_shards_greater_than_1k := InventoryBloodShardsGreaterThan1K()
  InventoryCloseIfActive()

  TownWaitTillActive(3)

  while !StashIsPanelActive() {
    TownClickStash(3)
    StashWaitTillActive(1500)
  }
  StashClickChest(1)

  RightClickImportantToStash()
  num_empty_slots := InventoryNumEmptySlots()

  MapOpenTown(1)
  TownWaitTillActive(1)
  while !OrekIsPopupActive() {
    TownClickOrek(1)
    OrekWaitTillPopupActive(2000)
  }
  Loop, 5 {
    Send, {Space}
    Sleep, 50
  }

  if (is_armor_damaged || num_empty_slots <= 8 || blood_shards_greater_than_1k) {
    ; Click blacksmith from Orek pos
    ClickAt(1640, 130)
    BlacksmithWaitTillPanelActive()
    if is_armor_damaged {
      BlacksmithClickRepairTab()
      BlacksmithClickRepairButton()
    }
    if (num_empty_slots <= 8) {
      BlacksmithClickSalvageTabIfNotActive()
      BlacksmithSalvageWhiteBlueYellow()
      BlacksmithSalvageLegendaries()
    }
    ; Click Kadela from Blacksmith
    if blood_shards_greater_than_1k {
      ClickAt(980, 840)
      KadalaWaitTillPanelActive()
      SpendBloodShards_()
    }
    while !RiftIsPanelActive() {
      TownClickNephalemStoneAfterBlacksmith(1)
      Sleep, 1500
    }
  } else {
    Sleep, 3250
    while !RiftIsPanelActive() {
      TownClickNephalemStoneAfterOrek(1)
      Sleep, 1500
    }
  }
  RiftClickGreaterOption()
  RiftClickAccept()
}

UrshiUpgradeSequence()
Sleep, 1000
HomeSequence()


ExitApp

F1::
ExitApp
Return