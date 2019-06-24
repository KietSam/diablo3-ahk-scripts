#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Kadala.ahk

SpendBloodShards() {
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
  }
}