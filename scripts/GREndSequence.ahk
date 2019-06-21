WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

SpendBloodShards() {
  blood_shard_1k_color := 0xFFFFFF

  PixelGetColor, blood_shard_1k_number_color, 2476, 1167
  if (blood_shard_1k_number_color = blood_shard_1k_color) {
    Loop, 4 {
      ; Quiver
      KadalaClickWeaponTab()
      Loop, 3 {
        KadalaClickSlot(3)
        Sleep, 50
      }

      KadalaClickArmorTab()
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

curr_slot := 1
exit_on_next_upgrade := false
While, true {  
  if (!UrshiIsPanelActive()) {
    break
  }
  UrshiClickSlot(curr_slot)
  if (UrshiIsGem100PercentUpgradeChance()) {
    UrshiClickUpgrade()
    Sleep, 1500
  } else {
    curr_slot++
    if (curr_slot = 16) {
      UrshiScrollDownOnce()
      UrshiScrollDownOnce()
      curr_slot := 1
    }
  }
}

MapOpenTown(1)
Sleep, 6000

TownClickOrek(1)
Sleep, 1900
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
TownClickNephalemStone(2)
Sleep, 2500

RiftClickGreaterOption()
RiftClickAccept()

ExitApp

F1::
ExitApp
Return