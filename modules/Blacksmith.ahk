#Include, %A_ScriptDir%\..\modules\Chat.ahk
#Include, %A_ScriptDir%\..\modules\Inventory.ahk
#Include, %A_ScriptDir%\..\modules\Stash.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk

BlacksmithIsPanelActive() {
  return ColorAtSimilarTo(350, 100, 0x54D9F7)
}

BlacksmithWaitTillPanelActive() {
  while !BlacksmithIsPanelActive() {
    Sleep, 50
  }
}

BlacksmithIsSalvageTabActive() {
  return ColorAtSimilarTo(740, 645, 0x1F2B38)
}

BlacksmithClickSalvageTab() {
  ClickAt(680, 650)
}

BlacksmithClickSalvageTabIfNotActive() {
  if (!BlacksmithIsSalvageTabActive()) {
    BlacksmithClickSalvageTab()
  }
}

BlacksmithIsSalvageActive() {
  if BlacksmithIsSalvageTabActive() {
    return ColorAtSimilarTo(220, 400, 0X50ACFF)
  }
}

BlacksmithClickSalvageButton() {
  if BlacksmithIsSalvageTabActive() {
    ClickAt(222, 400)
  }
}

BlacksmithClickSalvageButtonIfNotActive() {
  if (!BlacksmithIsSalvageActive()) {
    BlacksmithClickSalvageButton()
  }
}

BlacksmithIsRepairTabActive() {
  return ColorAtSimilarTo(740, 815, 0x1F2E3C)
}

BlacksmithClickRepairTab() {
  if BlacksmithIsPanelActive() {
    ClickAt(680, 800)
  }
}

BlacksmithClickRepairButton() {
  if BlacksmithIsPanelActive() && BlacksmithIsRepairTabActive() {
    ClickAt(350, 780)
  }
}

BlacksmithIsWhiteInActive() {
  return ColorAtSimilarTo(320, 368, 0x333233) && ColorAtSimilarTo(353, 372, 0x312F31)
}

BlacksmithIsBlueInActive() {
  return ColorAtSimilarTo(407, 367, 0x261307) && ColorAtSimilarTo(440, 403, 0x231206)
}

BlacksmithIsYellowInActive() {
  return ColorAtSimilarTo(497, 369, 0x0C3339) && ColorAtSimilarTo(530, 404, 0x072128)
}

BlacksmithSalvageWhiteBlueYellow() {
  salvage_icons_xx := [335, 430, 515]
  salvage_icons_yy := [390, 390, 390]
  is_inactive := [BlacksmithIsWhiteInActive(), BlacksmithIsBlueInActive(), BlacksmithIsYellowInActive()]

  Loop % salvage_icons_xx.Length() {
    if (!is_inactive[A_Index]) {
      xx := salvage_icons_xx[A_Index]
      yy := salvage_icons_yy[A_Index]
      ClickAt(xx, yy)
      SmartEnter()
    }
  }
}

BlacksmithRepairAndSalvage() {
  if (!BlacksmithIsPanelActive()) {
    return
  }
  BlacksmithClickSalvageTabIfNotActive()
  BlacksmithSalvageWhiteBlueYellow()
  BlacksmithClickRepairTab()
  BlacksmithClickRepairButton()
}

BlacksmithSalvageLegendaries() {
  if (!BlacksmithIsPanelActive()) {
    return
  }
  if (!BlacksmithIsSalvageTabActive()) {
    BlacksmithClickSalvageTab()
  }
  ; Top -> Down
  Loop, 6 {
    InventoryMoveMouseOutOfSlotRegion()
    i := A_Index
    ; Left -> Right
    Loop, 8 {
      j := A_Index
      x := j
      y := i
      if (!InventoryIsSingleSlotEmpty(x, y) && !InventoryIsSingleSlotPrimal(x, y)) {
        BlacksmithClickSalvageButtonIfNotActive()
        InventoryClickSingleSlot(x, y)
        SmartEnter()
      }
    }
  }
}