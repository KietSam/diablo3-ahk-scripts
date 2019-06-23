WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, %A_ScriptDir%\..\modules\Helpers.ahk

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
      Sleep, 1500
      BlacksmithSalvageWhiteBlueYellow()

      ; blacksmith -> kadala
      ClickAt(980, 840)
      Sleep, 1500
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
    UrshiClickSlot(curr_x, curr_y)
    if (UrshiIsGem100PercentUpgradeChance()) {
      UrshiClickUpgrade()
      Sleep, 1500
    } else {
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
  WaitTillPointIsColor(Point(1036, 223), 0x392828, 20, 20, 9)
  Sleep, 500
  TownClickStash(3)
  StashWaitTillActive()
  StashClickChest(1)

  tab := 2
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
    InventoryRightClickUnidentifiable()
  }

  MapOpenTown(1)
  WaitTillPointIsColor(Point(2232, 954), 0xF6F52C, 20, 20, 20)
  TownClickOrek(1)
  Sleep, 2000
  Loop, 5 {
    Send, {Space}
    Sleep, 50
  }

  ; Click blacksmith from Orek pos
  ClickAt(1640, 130)
  Sleep, 2000

  BlacksmithRepairAndSalvage()

  ; Click Kadela from Blacksmith
  ClickAt(980, 840)
  Sleep, 1500

  SpendBloodShards()

  MapOpenTown(2)
  Sleep, 1000
  TownClickNephalemStone(2)
  RiftWaitTillActive()
  RiftClickGreaterOption()
  RiftClickAccept()
}

UrshiUpgradeSequence()
HomeSequence()


ExitApp

F1::
ExitApp
Return