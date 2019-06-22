#NoEnv
#SingleInstance Force
#IfWinActive ahk_exe Diablo III64.exe

#Include, %A_ScriptDir%\..\modules\Helpers.ahk

INI_ERROR_MSG := "ERROR"

DEFAULT_INI_FILENAME := "settings.ini"

; Defines x and y coordinates for the center point of the character.
; Currently set for a 1440p monitor.
CHARACTER_CENTER_X := 1250
CHARACTER_CENTER_Y := 600

MAX_INTERVAL := 100
COUNTER := 0

MOUSE_LOCK := False

; Read in data from last saved file
Gosub, ReadSettings

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
  GuiControlGet, initialKeys,, INITIAL_KEYS
  GuiControlGet, repeatedKeys,, REPEATED_KEYS
  GuiControlGet, toggleRadialClicks,, TOGGLE_RADIAL_CLICKS
  GuiControlGet, maxRadius,, MAX_RADIUS

  GuiControlGet, skill1Key,, SKILL_1_KEY
  GuiControlGet, skill2Key,, SKILL_2_KEY
  GuiControlGet, skill3Key,, SKILL_3_KEY
  GuiControlGet, skill4Key,, SKILL_4_KEY

  GuiControlGet, toggleSkill1WhenInactive,, TOGGLE_SKILL_1_WHEN_INACTIVE
  GuiControlGet, toggleSkill2WhenInactive,, TOGGLE_SKILL_2_WHEN_INACTIVE
  GuiControlGet, toggleSkill3WhenInactive,, TOGGLE_SKILL_3_WHEN_INACTIVE
  GuiControlGet, toggleSkill4WhenInactive,, TOGGLE_SKILL_4_WHEN_INACTIVE

  GuiControlGet, toggleSkill1WhenAvailable,, TOGGLE_SKILL_1_WHEN_AVAILABLE
  GuiControlGet, toggleSkill2WhenAvailable,, TOGGLE_SKILL_2_WHEN_AVAILABLE
  GuiControlGet, toggleSkill3WhenAvailable,, TOGGLE_SKILL_3_WHEN_AVAILABLE
  GuiControlGet, toggleSkill4WhenAvailable,, TOGGLE_SKILL_4_WHEN_AVAILABLE

  skill_keys := [skill1Key, skill2Key, skill3Key, skill4Key]
  toggle_skills_when_inactive := [toggleSkill1WhenInactive, toggleSkill2WhenInactive, toggleSkill3WhenInactive, toggleSkill4WhenInactive]
  toggle_skills_when_available := [toggleSkill1WhenAvailable, toggleSkill2WhenAvailable, toggleSkill3WhenAvailable, toggleSkill4WhenAvailable]

  MouseGetPos mouse_x, mouse_y
  char_center_point := Point(CHARACTER_CENTER_X, CHARACTER_CENTER_Y)
  if (IsGoodClickRegion(mouse_x, mouse_y)) {
    if (toggleRadialClicks 
     && Distance(mouse_x, mouse_y, char_center_point[1], char_center_point[2]) <= maxRadius) {
      Send, {Click}
    }
  }

  Loop % skill_keys.Length() {
    i := A_Index
    key := skill_keys[i]
    if (toggle_skills_when_inactive[i] && !SkillIsOnCooldown(i)) {
      Send, %key%
    }
    if (toggle_skills_when_available[i] && SkillIsAvailable(i)) {
      Send, %key%
    }
  }

  Send, %repeatedKeys%
  COUNTER := COUNTER + 1
  Return
}

; Reads in settings from a setting.ini file.
; If the file does not exist, then settings are set to defaults.
ReadSettings:
{
  DEFAULT_INITIAL_KEYS := "Q"
  DEFAULT_REPEATED_KEYS := "WE"
  DEFAULT_MAX_RADIUS := 250
  DEFAULT_TOGGLE_RADIAL_CLICKS := 1

  DEFAULT_SKILL_1_KEY := 1
  DEFAULT_SKILL_2_KEY := 2
  DEFAULT_SKILL_3_KEY := 3
  DEFAULT_SKILL_4_KEY := 4

  DEFAULT_TOGGLE_SKILL_1_WHEN_INACTIVE := 0
  DEFAULT_TOGGLE_SKILL_2_WHEN_INACTIVE := 0
  DEFAULT_TOGGLE_SKILL_3_WHEN_INACTIVE := 0
  DEFAULT_TOGGLE_SKILL_4_WHEN_INACTIVE := 0

  DEFAULT_TOGGLE_SKILL_1_WHEN_AVAILABLE := 0
  DEFAULT_TOGGLE_SKILL_2_WHEN_AVAILABLE := 0
  DEFAULT_TOGGLE_SKILL_3_WHEN_AVAILABLE := 0
  DEFAULT_TOGGLE_SKILL_4_WHEN_AVAILABLE := 0

  IniRead, initialKeys, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, INITIAL_KEYS, %DEFAULT_INITIAL_KEYS%
  IniRead, repeatedKeys, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, REPEATED_KEYS, %DEFAULT_REPEATED_KEYS%

  IniRead, skill1Key, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_1_KEY, %DEFAULT_SKILL_1_KEY%
  IniRead, skill2Key, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_2_KEY, %DEFAULT_SKILL_2_KEY%
  IniRead, skill3Key, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_3_KEY, %DEFAULT_SKILL_3_KEY%
  IniRead, skill4Key, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_4_KEY, %DEFAULT_SKILL_4_KEY%

  IniRead, toggleSkill1WhenInactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_1_WHEN_INACTIVE, %DEFAULT_TOGGLE_SKILL_1_WHEN_INACTIVE%
  IniRead, toggleSkill2WhenInactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_2_WHEN_INACTIVE, %DEFAULT_TOGGLE_SKILL_2_WHEN_INACTIVE%
  IniRead, toggleSkill3WhenInactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_3_WHEN_INACTIVE, %DEFAULT_TOGGLE_SKILL_3_WHEN_INACTIVE%
  IniRead, toggleSkill4WhenInactive, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_4_WHEN_INACTIVE, %DEFAULT_TOGGLE_SKILL_4_WHEN_INACTIVE%

  IniRead, toggleSkill1WhenAvailable, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_1_WHEN_AVAILABLE, %DEFAULT_TOGGLE_SKILL_1_WHEN_AVAILABLE%
  IniRead, toggleSkill2WhenAvailable, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_2_WHEN_AVAILABLE, %DEFAULT_TOGGLE_SKILL_2_WHEN_AVAILABLE%
  IniRead, toggleSkill3WhenAvailable, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_3_WHEN_AVAILABLE, %DEFAULT_TOGGLE_SKILL_3_WHEN_AVAILABLE%
  IniRead, toggleSkill4WhenAvailable, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_4_WHEN_AVAILABLE, %DEFAULT_TOGGLE_SKILL_4_WHEN_AVAILABLE%
  
  IniRead, read_max_radius, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, MAX_RADIUS, %DEFAULT_MAX_RADIUS%
  IniRead, read_toggle_radial_clicks, %DEFAULT_INI_FILENAME%, CLICK_SETTINGS, TOGGLE_RADIAL_CLICKS, %DEFAULT_TOGGLE_RADIAL_CLICKS%
  ; Window
  Gui, Show, w300 h200, Choose Keys
  column_width := 130

  ; ========================================================================
  ; lEFT
  ; ========================================================================
  column1_x := 10
  y := 10
  Gui, Add, Text, x%column1_x% y%y% w%column_width% Center, Initial key presses:
  y += 15
  Gui, Add, Edit, x%column1_x% y%y% w%column_width% h15 vINITIAL_KEYS Center, %initialKeys%

  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% Center, Keys to repeat:
  y += 15
  Gui, Add, Edit, x%column1_x% y%y% w%column_width% h15 vREPEATED_KEYS Center, %repeatedKeys%

  ; Skill section
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Skill Keys

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15, 1
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_1_KEY, %skill1Key%

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 2
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_2_KEY, %skill2Key%

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 3
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_3_KEY, %skill3Key%

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 4
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_4_KEY, %skill4Key%

  ; Skill toggling section (when inactive)
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Toggle when inactive:

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill1WhenInactive% vTOGGLE_SKILL_1_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill2WhenInactive% vTOGGLE_SKILL_2_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill3WhenInactive% vTOGGLE_SKILL_3_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill4WhenInactive% vTOGGLE_SKILL_4_WHEN_INACTIVE

  ; Skill toggling section (when available)
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Toggle when available:

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill1WhenAvailable% vTOGGLE_SKILL_1_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill2WhenAvailable% vTOGGLE_SKILL_2_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill3WhenAvailable% vTOGGLE_SKILL_3_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill4WhenAvailable% vTOGGLE_SKILL_4_WHEN_AVAILABLE

  ; ========================================================================
  ; RIGHT
  ; ========================================================================
  column2_x := 160
  Gui, Add, Text, x%column2_x% y10 w100 Left, Enable radial clicks:
  Gui, Add, Checkbox, x260 y10 Checked%read_toggle_radial_clicks% vTOGGLE_RADIAL_CLICKS,

  Gui, Add, Text, x%column2_x% y25 w100 Left, Max radius:
  Gui, Add, Edit, x215 y25 w75 h15 vMAX_RADIUS Center, %read_max_radius%

  Gui, Add, Button, x%column2_x% y170 w%column_width% h20 gSaveSettings, Save

  return
}

; Save current settings to the DEFAULT_INI_FILENAME.
SaveSettings:
{
  GuiControlGet, initialKeys,, INITIAL_KEYS
  GuiControlGet, repeatedKeys,, REPEATED_KEYS
  GuiControlGet, toggleRadialClicks,, TOGGLE_RADIAL_CLICKS
  GuiControlGet, maxRadius,, MAX_RADIUS

  GuiControlGet, skill1Key,, SKILL_1_KEY
  GuiControlGet, skill2Key,, SKILL_2_KEY
  GuiControlGet, skill3Key,, SKILL_3_KEY
  GuiControlGet, skill4Key,, SKILL_4_KEY

  GuiControlGet, toggleSkill1WhenInactive,, TOGGLE_SKILL_1_WHEN_INACTIVE
  GuiControlGet, toggleSkill2WhenInactive,, TOGGLE_SKILL_2_WHEN_INACTIVE
  GuiControlGet, toggleSkill3WhenInactive,, TOGGLE_SKILL_3_WHEN_INACTIVE
  GuiControlGet, toggleSkill4WhenInactive,, TOGGLE_SKILL_4_WHEN_INACTIVE

  Gui, Submit, NoHide
  IniWrite, %initialKeys%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, INITIAL_KEYS
  IniWrite, %repeatedKeys%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, REPEATED_KEYS

  IniWrite, %skill1Key%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_1_KEY
  IniWrite, %skill2Key%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_2_KEY
  IniWrite, %skill3Key%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_3_KEY
  IniWrite, %skill4Key%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, SKILL_4_KEY

  IniWrite, %toggleSkill1WhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_1_WHEN_INACTIVE
  IniWrite, %toggleSkill2WhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_2_WHEN_INACTIVE
  IniWrite, %toggleSkill3WhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_3_WHEN_INACTIVE
  IniWrite, %toggleSkill4WhenInactive%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_4_WHEN_INACTIVE

  IniWrite, %toggleSkill1WhenAvailable%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_1_WHEN_AVAILABLE
  IniWrite, %toggleSkill2WhenAvailable%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_2_WHEN_AVAILABLE
  IniWrite, %toggleSkill3WhenAvailable%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_3_WHEN_AVAILABLE
  IniWrite, %toggleSkill4WhenAvailable%, %DEFAULT_INI_FILENAME%, KEY_SETTINGS, TOGGLE_SKILL_4_WHEN_AVAILABLE

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