#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Kadala.ahk
#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\Stash.ahk
#Include, %A_ScriptDir%\..\modules\Urshi.ahk

SpendBloodShards() {
  if !KadalaIsPanelActive() {
    return
  }

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

    if (InventoryNumEmptySlots() <= 2) {
      return
    }
  }
}

RightClickImportantToStash() {
  tab := 2
  while (InventoryNumUnidentifiable() != 0) {
    StashClickTab(tab)
    empty_slots := StashNumEmptySlots()
    while (empty_slots <= 2) {
      tab++
      if (tab > 5) {
        break
      }
      StashClickTab(tab)
      empty_slots := StashNumEmptySlots()
    }
    if (tab > 5) {
      break
    }
    InventoryRightClickImportant(empty_slots)
    InventoryMoveMouseOutOfSlotRegion()
  }
}

UrshiUpgradeSequence() {
  ; Upgrades all 100% gems available
  curr_x := 1
  curr_y := 1
  times_scrolled_down := 0
  upgrade_clicks := 0
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
      upgrade_clicks++
    }

    if (upgrade_clicks >= 5) {
      return
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