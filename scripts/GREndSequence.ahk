WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Blacksmith.ahk
#Include, %A_ScriptDir%\..\modules\Kadala.ahk
#Include, %A_ScriptDir%\..\modules\Orek.ahk
#Include, %A_ScriptDir%\..\modules\Map.ahk
#Include, %A_ScriptDir%\..\modules\RiftStone.ahk
#Include, %A_ScriptDir%\..\modules\Town.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Urshi.ahk

SpendBloodShards() {
  blood_shard_1k_color := 0xFFFFFF
  blood_shard_1k_number_color := ColorAt(2476, 1167)
  if (blood_shard_1k_number_color = blood_shard_1k_color) {
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
  }
}

UrshiUpgradeSequence() {
  ; Upgrades all 100% gems available
  curr_x := 1
  curr_y := 1
  exit_on_next_upgrade := false
  times_scrolled_down := 0
  While, true {  
    if (!UrshiIsPanelActive()) {
      break
    }
    go_next_gem := true
    UrshiClickSlot(curr_x, curr_y)
    if (UrshiIsGem100PercentUpgradeChance() && UrshiIsUpgradeAvailable()) {
      go_next_gem := false
      UrshiClickUpgrade()
      Sleep, 1900
    } 
    
    if (go_next_gem) {
      if (curr_x == 5 && curr_y == 3) {
        ; Made it through the first page
        ; Reset x position but stay at y position
        UrshiScrollDownOnce()
        times_scrolled_down++
        curr_x = 1
      } else if (curr_x == 5) {
        curr_x = 1
        curr_y++
      } else {
        curr_x++
      }
    }
    if (times_scrolled_down >= 5) {
      break
    }
  }
}


HomeSequence() {
  MapOpenTown(3)
  Sleep, 4000
  while !(ColorAtSimilarTo(1039, 226, 0x272D3A, 20, 20, 15) 
      && ColorAtSimilarTo(1295, 143, 0x2D3341, 20, 20, 15)
      && ColorAtSimilarTo(976, 1090, 0x16110E, 20, 20, 15)) {
    Sleep, 100
  }

  Sleep, 500
  while !StashIsPanelActive() {
    TownClickStash(3)
    Sleep, 2500  
  }
  StashClickChest(1)

  tab := 3
  while (InventoryNumUnidentifiable() != 0) {
    StashClickTab(tab)
    while (StashNumEmptySlots() <= 2) {
      tab++
      if (tab > 5) {
        break
      }
      StashClickTab(tab)
    }
    if (tab > 5) {
      break
    }
    InventoryRightClickImportant()
  }

  MapOpenTown(1)
  while !(ColorAtSimilarTo(2224, 945, 0xE3D432, 20, 20, 20)) {
    Sleep, 50
  }
  while !OrekIsPopupActive() {
    TownClickOrek(1)
    Sleep, 2000
  }
  Loop, 5 {
    Send, {Space}
    Sleep, 50
  }

  ; Click blacksmith from Orek pos
  ClickAt(1640, 130)
  BlacksmithWaitTillPanelActive()
  BlacksmithRepairAndSalvage()

  ; Click Kadela from Blacksmith
  ClickAt(980, 840)
  Sleep, 1500

  SpendBloodShards()

  MapOpenTown(2)
  Sleep, 1000
  while !RiftIsPanelActive() {
    TownClickNephalemStone(2)
    Sleep, 2500
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