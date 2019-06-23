#Include, %A_ScriptDir%\..\modules\Utils.ahk

;===============================================================
; Rift stone
;===============================================================

RiftIsPanelActive() {
  return ColorAtSimilarTo(320, 92, 0x7B1150)
      && ColorAtSimilarTo(385, 93, 0xAB2576)
}

RiftWaitTillPanelActive() {
  while !RiftIsPanelActive() {
    Sleep, 50
  }
}

RiftClickNephalemOption() {
  ClickAt(350, 380)
}

RiftClickGreaterOption() {
  ClickAt(350, 600)
}

RiftClickAccept() {
  ClickAt(350, 1130)
}

