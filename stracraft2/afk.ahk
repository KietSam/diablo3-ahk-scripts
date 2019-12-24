#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\WindowContainerClass.ahk

class Lobby {
  static LOBBY_SLOT_X_COORD := 900
  static IS_POPULATED_COLOR := 0X25160B

  _checkSlotRange(n, min, max) {
    if (n < min or n > max) {
      Error("n must be between " . min . " (inclusive) and " . max . " (inclusive), got: " . n)
    }
  }
}

class EntropyTdLobby extends Lobby {
  __New(window) {
    this.window := window
  }

  isPopulatedSlot(n) {
    this._checkSlotRange(n, 1, 9)
    this.window.setActiveWindow()
    ; first_slot_offset := 100
    ; 305
    ; 935
    point := this.window.coordToPoint(this.LOBBY_SLOT_X_COORD, 935)
    MovePoint(point)
  }

}

class RunlingRunLobby extends Lobby {
  
  __New(window) {
    this.window := window
  }

  ; Index starts at 1
  isPopulatedSlot(n) {
    this._checkSlotRange(n, 1, 14)

    this.window.setActiveWindow()
    delta_y := 700 / 9
    first_slot_offset := -1
    is_populated := false
    if (n >= 1 && n <= 10) {
      first_slot_offset := 310
      this.window.scrollUpLobbyMax()
    }
    if (n >= 11 && n <= 14) {
      first_slot_offset := 615
      this.window.scrollDownLobbyMax()
    }
    y := first_slot_offset + (n - 1) * delta_y
    point := this.window.coordToPoint(this.LOBBY_SLOT_X_COORD, y)
    is_populated := ColorPointSimilarTo(point, this.IS_POPULATED_COLOR)
    return is_populated
  }

  numPopulatedSlots() {
    count := 0
    Loop, 14 {
      n := A_Index
      is_populated := lobby.isPopulatedSlot(n)
      if (is_populated) {
        count += 1
      }
      Print("slot: " . n . ", populated: " . is_populated)
    }
    return count
  }
}


CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

WinGetPos, x, y, height, width, ahk_class StarCraft II

window := new WindowContainer()
window.setWindowX(x)
window.setWindowY(y)
window.setWindowHeight(height)
window.setWindowWidth(width)

; window.print()
lobby := new RunlingRunLobby(window)
; lobby := new EntropyTdLobby(window)


; window.moveToCoord(100, 100)
; window.scrollUpLobbyMax()
; window.scrollUpLobby()
; window.scrollDownLobby(10)

; lobby.isPopulatedSlot(12)

Loop, 1 { ; Top -> Bottom
  n := A_Index
  is_populated := lobby.isPopulatedSlot(n)
  Print("slot: " . n . ", populated: " . is_populated)
}

; Print("x: " . x . ", y: " . y . ", height: " . height . ", width: " . width)

; point := [x + 100, y + 100]

; MovePoint(point)

ExitApp

F1::
ExitApp
Return

Escape::
ExitApp
Return