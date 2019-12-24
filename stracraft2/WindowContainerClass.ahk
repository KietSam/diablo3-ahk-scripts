#Include, %A_ScriptDir%\..\modules\Utils.ahk

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