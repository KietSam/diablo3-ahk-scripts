WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

SpendBloodShards() {
  global at_blacksmith
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

      ; Feet
      KadalaClickArmorTab()
      Loop, 3 {
        KadalaClickSlot(3)  
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
      ClickAt(1550, 320)
      Sleep, 1500
      BlacksmithSalvageWhiteBlueYellow()

      ; blacksmith -> kadala
      ClickAt(970, 810)
      Sleep, 2000
    }
    ; ; kadala -> blacksmith
    ; ClickAt(1550, 320)
    ; Sleep, 1500
    ; BlacksmithSalvageWhiteBlueYellow()

    ; ; blacksmith -> kadala
    ; ClickAt(970, 810)
    ; Sleep, 2000
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

Send, "t"

MoveAt(1600, 700)
Sleep, 6800

InventoryCloseIfActive()

ClickAt(2000, 700)
Sleep, 1000

ClickAt(1800, 1000)
Sleep, 1000

ClickAt(1655, 905)
Sleep, 500

Loop, 5 {
  Send, {Space}
  Sleep, 50
}

; Click blacksmith
ClickAt(1600, 150)

; Move to near the salvage tab button
MoveAt(680, 650)
Sleep, 2000

BlacksmithClickSalvageTabIfNotActive()

BlacksmithSalvageWhiteBlueYellow()

BlacksmithClickRepairTab()

BlacksmithClickRepairButton()

; blacksmith -> kadala
ClickAt(970, 810)
Sleep, 2000

SpendBloodShards()

; Click neph stone
ClickAt(1600, 900)
Sleep, 1300

RiftClickGreaterOption()
RiftClickAccept()

ExitApp

F1::
ExitApp
Return