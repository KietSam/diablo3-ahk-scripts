#Include, %A_ScriptDir%\..\modules\Utils.ahk

class Lobby {
  static LOBBY_COLOR_PICK_X := 900
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
    first_slot_offset := 100
    ; 305
    ; 935
    point := this.window.coordToPoint(this.LOBBY_COLOR_PICK_X, 935)
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
    y := first_slot_offset + (n - 11) * delta_y
    point := this.window.coordToPoint(this.LOBBY_COLOR_PICK_X, y)
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
  }
}

class WindowContainer {
  static DEFAULT_WINDOW_HEIGHT := 2433
  static DEFAULT_WINDOW_WIDTH := 1406

  static SCROLL_LOBBY_X := 1000
  static SCROLL_LOBBY_Y := 400

  setWindowX(x) {
    this.x := x
  }

  setWindowY(y) {
    this.y := y
  }

  setWindowHeight(height) {
    this.height := height
  }

  setWindowWidth(width) {
    this.width := width
  }

  setActiveWindow() {
    p := this.coordToPoint(1500, 175)
    ClickPoint(p)
  }

  print() {
    Print("x: " . this.x . ", y: " . this.y . ", height: " . this.height . ", width: " . this.width)
  }

  coordToPoint(x, y) {
    return [this.x + x, this.y + y]
  }

  colorAtCoord(x, y) {
    coord_x := this.x + x
    coord_y := this.y + y
    PrintColorPoint([coord_x, coord_y])
  }

  moveToCoord(x, y) {
    CoordMode, Mouse, Screen
    coord_x := this.x + x
    coord_y := this.y + y

    ; Print("coord_x: " . coord_x . ", coord_y: " . coord_y)
    MovePoint([coord_x, coord_y])
    CoordMode, Mouse, Screen
  }

  scrollUpLobbyMax() {
    this.scrollUpLobby(10)
  }

  scrollDownLobbyMax() {
    this.scrollDownLobby(10)
  }

  scrollUpLobby(n:=1) {
    Loop % n {
      x := this.x + this.SCROLL_LOBBY_X
      y := this.y + this.SCROLL_LOBBY_Y
      ScrollUpPoint([x, y])
    }
    Sleep, 100
  }

  scrollDownLobby(n:=1) {
    Loop % n {
      x := this.x + this.SCROLL_LOBBY_X
      y := this.y + this.SCROLL_LOBBY_Y
      ScrollDownPoint([x, y])
    }
    Sleep, 100
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
; lobby := new RunlingRunLobby(window)
lobby := new EntropyTdLobby(window)


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