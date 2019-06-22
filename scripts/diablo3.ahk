#NoEnv
#SingleInstance Force
#IfWinActive ahk_exe Diablo III64.exe

#Include, %A_ScriptDir%\..\modules\Helpers.ahk

INI_ERROR_MSG := "ERROR"

DEFAULT_INI_FILENAME := "settings.ini"
DEFAULT_INITIAL_KEYS := "Q"
DEFAULT_REPEATED_KEYS := "WE"
DEFAULT_MAX_RADIUS := 250
DEFAULT_TOGGLE_RADIAL_CLICKS := 1
DEFAULT_TOGGLE_Q_WHEN_INACTIVE := 0
DEFAULT_TOGGLE_W_WHEN_INACTIVE := 0
DEFAULT_TOGGLE_E_WHEN_INACTIVE := 0
DEFAULT_TOGGLE_R_WHEN_INACTIVE := 1

; Defines x and y coordinates for the center point of the character.
; Currently set for a 1440p monitor.
CHARACTER_CENTER_X := 1250
CHARACTER_CENTER_Y := 600

TOGGLE_RADIAL_CLICKS := DEFAULT_TOGGLE_RADIAL_CLICKS
MAX_RADIUS := DEFAULT_MAX_RADIUS
MAX_INTERVAL := 100
COUNTER := 0

INITIAL_KEYS := DEFAULT_INITIAL_KEYS
REPEATED_KEYS := DEFAULT_REPEATED_KEYS
TOGGLE_Q_WHEN_INACTIVE := DEFAULT_TOGGLE_Q_WHEN_INACTIVE
TOGGLE_W_WHEN_INACTIVE := DEFAULT_TOGGLE_W_WHEN_INACTIVE
TOGGLE_E_WHEN_INACTIVE := DEFAULT_TOGGLE_E_WHEN_INACTIVE
TOGGLE_R_WHEN_INACTIVE := DEFAULT_TOGGLE_R_WHEN_INACTIVE

MOUSE_LOCK := False

; Read in data from last saved file
Gosub, ReadSettings

; Window
Gui, Show, w300 h200, Choose Keys
; Left
Gui, Add, Text, x10 y10 w130 Center, Initial key presses:
Gui, Add, Edit, x10 y25 w130 h20 vINITIAL_KEYS Center, %INITIAL_KEYS%
Gui, Add, Text, x10 y50 w130 Center, Keys to repeat:
Gui, Add, Edit, x10 y65 w130 h20 vREPEATED_KEYS Center, %REPEATED_KEYS%
; Right
Gui, Add, Text, x160 y10 w100 Left, Enable radial clicks:
Gui, Add, Checkbox, x260 y10 Checked%TOGGLE_RADIAL_CLICKS% vTOGGLE_RADIAL_CLICKS,

Gui, Add, Text, x160 y25 w100 Left, Max radius:
Gui, Add, Edit, x215 y25 w75 h15 vMAX_RADIUS Center, %MAX_RADIUS%

Gui, Add, Text, x160 y45 w100 Left, Toggle when inactive:
Gui, Add, CheckBox, x160 y60 Checked%TOGGLE_Q_WHEN_INACTIVE% vTOGGLE_Q_WHEN_INACTIVE, Q
Gui, Add, CheckBox, x190 y60 Checked%TOGGLE_W_WHEN_INACTIVE% vTOGGLE_W_WHEN_INACTIVE, W
Gui, Add, CheckBox, x220 y60 Checked%TOGGLE_E_WHEN_INACTIVE% vTOGGLE_E_WHEN_INACTIVE, E
Gui, Add, CheckBox, x250 y60 Checked%TOGGLE_R_WHEN_INACTIVE% vTOGGLE_R_WHEN_INACTIVE, R

Gui, Add, Button, x10 y90 w130 h100 gSaveSettings, Save


; Checks if the given x and y coordinates are in a good clickable region.
IsGoodClickRegion(x, y) {
  ; x: x position in terms of user's resolution
  ; y: y position in terms of user's resolution
  ; Character portraits
  char_portrait_p := Point(140, 800)
  if (x <= char_portrait_p[1] && y <= char_portrait_p[2]) {
    return false
  }
  ; Follower portraits
  follower_portrait_p := Point(260, 125)
  if (x <= follower_portrait_p[1] && y <= follower_portrait_p[2]) {
    return false
  }
  ; Skill Bar
  skill_bar_top_left_p := Point(825, 1300)
  skill_bar_bot_right_p := Point(1725, 1440)
  if (x >= skill_bar_top_left_p[1] && x <= skill_bar_bot_right_p[1] && y <= skill_bar_bot_right_p[2] && y >= skill_bar_top_left_p[2]) {
    return false
  }
  return true
}

AutoSend:
{
  if (GetKeyState("Alt", "P") || GetKeyState("t", "P") || GetKeyState("m", "P") || GetKeyState("Alt", "P")) {
    Return
  }
  GuiControlGet, toggleRadialClicks,, TOGGLE_RADIAL_CLICKS
  GuiControlGet, maxRadius,, MAX_RADIUS
  MouseGetPos mouse_x, mouse_y
  char_center_point := Point(CHARACTER_CENTER_X, CHARACTER_CENTER_Y)
  if (IsGoodClickRegion(mouse_x, mouse_y)) {
    if (toggleRadialClicks && Distance(mouse_x, mouse_y, char_center_point[1], char_center_point[2]) <= maxRadius) {
      Send, {Click}
    }
  }
  GuiControlGet, toggleQWhenInactive,, TOGGLE_Q_WHEN_INACTIVE
  GuiControlGet, toggleWWhenInactive,, TOGGLE_W_WHEN_INACTIVE
  GuiControlGet, toggleEWhenInactive,, TOGGLE_E_WHEN_INACTIVE
  GuiControlGet, toggleRWhenInactive,, TOGGLE_R_WHEN_INACTIVE

  if (toggleQWhenInactive && !SkillIsActive(1)) {
    Send, "q"
  }
  if (toggleWWhenInactive && !SkillIsActive(2)) {
    Send, "w"
  }
  if (toggleEWhenInactive && !SkillIsActive(3)) {
    Send, "e"
  }
  if (toggleRWhenInactive && !SkillIsActive(4)) {
    Send, "r"
  }

  Send, %REPEATED_KEYS%
  COUNTER := COUNTER + 1
  Return
}

; Reads in settings from a setting.ini file.
; If the file does not exist, then settings are set to defaults.
ReadSettings:
{
  if FileExist(DEFAULT_INI_FILENAME) {
    IniRead, read_initial_keys, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, INITIAL_KEYS, %DEFAULT_INITIAL_KEYS%
    IniRead, read_repeated_keys, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, REPEATED_KEYS, %DEFAULT_REPEATED_KEYS%
    IniRead, read_toggle_q_when_inactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_Q_WHEN_INACTIVE, %DEFAULT_TOGGLE_Q_WHEN_INACTIVE%
    IniRead, read_toggle_w_when_inactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_W_WHEN_INACTIVE, %DEFAULT_TOGGLE_W_WHEN_INACTIVE%
    IniRead, read_toggle_e_when_inactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_E_WHEN_INACTIVE, %DEFAULT_TOGGLE_E_WHEN_INACTIVE%
    IniRead, read_toggle_r_when_inactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_R_WHEN_INACTIVE, %DEFAULT_TOGGLE_R_WHEN_INACTIVE%
    
    IniRead, read_max_radius, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, MAX_RADIUS, %DEFAULT_MAX_RADIUS%
    IniRead, read_toggle_radial_clicks, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, TOGGLE_RADIAL_CLICKS, %DEFAULT_TOGGLE_RADIAL_CLICKS%

    INITIAL_KEYS := read_initial_keys
    REPEATED_KEYS := read_repeated_keys
    MAX_RADIUS := read_max_radius
    TOGGLE_RADIAL_CLICKS := read_toggle_radial_clicks

    TOGGLE_Q_WHEN_INACTIVE := read_toggle_q_when_inactive
    TOGGLE_W_WHEN_INACTIVE := read_toggle_w_when_inactive
    TOGGLE_E_WHEN_INACTIVE := read_toggle_e_when_inactive
    TOGGLE_R_WHEN_INACTIVE := read_toggle_r_when_inactive
  } else {
    MsgBox,, Information, Couldn't find %DEFAULT_INI_FILENAME%. Resorting to defaults.
    Gosub, SaveSettings
  }
  return
}

; Save current settings to the DEFAULT_INI_FILENAME.
SaveSettings:
{
  GuiControlGet, toggleRadialClicks,, TOGGLE_RADIAL_CLICKS
  GuiControlGet, toggleQWhenInactive,, TOGGLE_Q_WHEN_INACTIVE
  GuiControlGet, toggleWWhenInactive,, TOGGLE_W_WHEN_INACTIVE
  GuiControlGet, toggleEWhenInactive,, TOGGLE_E_WHEN_INACTIVE
  GuiControlGet, toggleRWhenInactive,, TOGGLE_R_WHEN_INACTIVE
  GuiControlGet, maxRadius,, MAX_RADIUS
  Gui, Submit, NoHide
  IniWrite, %INITIAL_KEYS%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, INITIAL_KEYS
  IniWrite, %REPEATED_KEYS%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, REPEATED_KEYS
  IniWrite, %toggleQWhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_Q_WHEN_INACTIVE
  IniWrite, %toggleWWhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_W_WHEN_INACTIVE
  IniWrite, %toggleEWhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_E_WHEN_INACTIVE
  IniWrite, %toggleRWhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_R_WHEN_INACTIVE

  IniWrite, %maxRadius%, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, MAX_RADIUS
  IniWrite, %toggleRadialClicks%, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, TOGGLE_RADIAL_CLICKS
  MsgBox,, Saved, Settings Saved!
  return
}

; Does not work well.
cluster_click(x, y) {
  MOUSE_LOCK := False
  num_rows := 2
  num_cols := 2
  box_width := 50
  box_height := 50

  top_left_x := x - box_width/2
  top_left_y := y - box_height/2
  
  i := 0
  j := 0
  while (i < num_cols) {
    while (j < num_rows) {
      curr_x := top_left_x + box_width/num_cols*i
      curr_y := top_left_y + box_height/num_rows*j
      Send, {Click %curr_x%, %curr_y%}
      j := j + 1
    }
    i := i + 1
  }
  Send, {Click %x%, %y%}
  MOUSE_LOCK := True
  return
}

CloseInventory() {
  active_inventory_color = 0x349ADB
  PixelGetColor, inventoryOpenColor, 2200, 100
  if (inventoryOpenColor = active_inventory_color) {
    Send, "i"
  }
}


F4::
AutoSend := !AutoSend
If AutoSend {
  Send, %INITIAL_KEYS%
  SetTimer AutoSend, %MAX_INTERVAL%
} Else {
  SetTimer AutoSend, Off
}
Return

m::
if (AutoSend) {
  SetTimer AutoSend, Off
  keywait, m
  SetTimer AutoSend, %MAX_INTERVAL%
}
Send, m
Return