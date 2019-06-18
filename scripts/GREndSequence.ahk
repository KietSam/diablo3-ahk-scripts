WinActivate, Diablo III ahk_class D3 Main Window Class

#Include, Helpers.ahk

CloseInventoryIfOpened() {
  active_inventory_color = 0x349ADB
  PixelGetColor, inventoryOpenColor, 2200, 100
  if (inventoryOpenColor = active_inventory_color) {
    Send, "i"
  }
}

SpendBloodShards() {
  blood_shard_1k_color := 0xFFFFFF

  PixelGetColor, blood_shard_1k_number_color, 2476, 1167
  if (blood_shard_1k_number_color = blood_shard_1k_color) {
    Loop, 3 {
      ; Quiver
      KadalaClickWeaponTab()
      Loop, 8 {
        KadalaClickSlot(3)  
      }

      ; Feet
      KadalaClickArmorTab()
      Loop, 8 {
        KadalaClickSlot(3)  
      }

      ; Belt
      Loop, 8 {
        KadalaClickSlot(5)  
      }

      ; Gloves
      Loop, 8 {
        KadalaClickSlot(5)  
      }

      ; kadala -> blacksmith
      Click, 1550, 320, Left
      Sleep, 1500
      BlacksmithSalvageWhiteBlueYellow()

      ; blacksmith -> kadala
      Click, 970, 810, Left
      Sleep, 2000
    }
  }
}

curr_slot := 1
exit_on_next_upgrade := false
While, true {  
  if (UrshiOneUpgradeLeft()) {
    exit_on_next_upgrade := true
  }
  UrshiClickSlot(curr_slot)
  if (UrshiIsGem100PercentUpgradeChance()) {
    UrshiClickUpgrade()
    if (exit_on_next_upgrade) {
      break
    }
    UrshiClickSlot(curr_slot)
    Sleep, 1500
  } else {
    curr_slot++
    if (curr_slot = 16) {
      UrshiScrollDownOnce()
      curr_slot := 1
    }
  }
}

Send, "t"
Click, 1600, 700, 0
Sleep, 6800
CloseInventoryIfOpened()
Click, 2000, 700 Left, Down
Click, 2000, 700 Left, Up
Sleep, 1000
Click, 1800, 1000 Left, Down
Click, 1800, 1000 Left, Up
Sleep, 1000
Click, 1655, 905 Left, Down
Click, 1655, 905 Left, Up
Sleep, 500
Loop, 5 {
  Send, {Space}
  Sleep, 50
}

; Click blacksmith
Click, 1600, 150, Left, Down
Click, 1600, 150, Left, Up

; Move to near the salvage buttons
Click, 400, 500, 0
Sleep, 2000

BlacksmithSalvageWhiteBlueYellow()

; Click Kadala
Click, 970, 810, Left
Sleep, 1500

SpendBloodShards()

; Click neph stone
Click, 1600, 900, Left
Sleep, 1500

RiftClickGreaterOption()
RiftClickAccept()

ExitApp

Escape::
ExitApp
Return