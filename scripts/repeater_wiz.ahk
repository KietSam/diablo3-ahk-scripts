#NoEnv
#SingleInstance Force
#IfWinActive ahk_exe Diablo III64.exe

#Include, %A_ScriptDir%\..\modules\Skills.ahk
#Include, %A_ScriptDir%\..\modules\Utils.ahk
#Include, %A_ScriptDir%\..\modules\Misc.ahk

INI_ERROR_MSG := "ERROR"

DEFAULT_INI_FILENAME := "settings_wiz.ini"

; Defines x and y coordinates for the center point of the character.
; Currently set for a 1440p monitor.
CHARACTER_CENTER_X := 1250
CHARACTER_CENTER_Y := 600

COUNTER := 0

MOUSE_LOCK := False

CURR_PROFILE := GetDefaultProfile()

sequence_num := 0

; Read in data from last saved file
Gosub, ReadSettings

GetDefaultProfile() {
  profile := {}
  profile["initialKeys"] := ""
  profile["repeatedKeys"] := ""
  profile["toggleRadialClicks"] := 1
  profile["maxRadius"] := 350

  profile["skill1Key"] := 1
  profile["skill2Key"] := 2
  profile["skill3Key"] := 3
  profile["skill4Key"] := 4

  profile["toggleSkill1WhenInactive"] := 0
  profile["toggleSkill2WhenInactive"] := 0
  profile["toggleSkill3WhenInactive"] := 0
  profile["toggleSkill4WhenInactive"] := 0

  profile["toggleSkill1WhenAvailable"] := 0
  profile["toggleSkill2WhenAvailable"] := 0
  profile["toggleSkill3WhenAvailable"] := 0
  profile["toggleSkill4WhenAvailable"] := 0

  profile["interval"] := 50
  return profile
}

GetCurrentProfile: 
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

  GuiControlGet, toggleSkill1WhenAvailable,, TOGGLE_SKILL_1_WHEN_AVAILABLE
  GuiControlGet, toggleSkill2WhenAvailable,, TOGGLE_SKILL_2_WHEN_AVAILABLE
  GuiControlGet, toggleSkill3WhenAvailable,, TOGGLE_SKILL_3_WHEN_AVAILABLE
  GuiControlGet, toggleSkill4WhenAvailable,, TOGGLE_SKILL_4_WHEN_AVAILABLE

  CURR_PROFILE["initialKeys"] := initialKeys
  CURR_PROFILE["repeatedKeys"] := repeatedKeys
  CURR_PROFILE["toggleRadialClicks"] := toggleRadialClicks
  CURR_PROFILE["maxRadius"] := maxRadius

  CURR_PROFILE["skill1Key"] := skill1Key
  CURR_PROFILE["skill2Key"] := skill2Key
  CURR_PROFILE["skill3Key"] := skill3Key
  CURR_PROFILE["skill4Key"] := skill4Key

  CURR_PROFILE["toggleSkill1WhenInactive"] := toggleSkill1WhenInactive
  CURR_PROFILE["toggleSkill2WhenInactive"] := toggleSkill2WhenInactive
  CURR_PROFILE["toggleSkill3WhenInactive"] := toggleSkill3WhenInactive
  CURR_PROFILE["toggleSkill4WhenInactive"] := toggleSkill4WhenInactive

  CURR_PROFILE["toggleSkill1WhenAvailable"] := toggleSkill1WhenAvailable
  CURR_PROFILE["toggleSkill2WhenAvailable"] := toggleSkill2WhenAvailable
  CURR_PROFILE["toggleSkill3WhenAvailable"] := toggleSkill3WhenAvailable
  CURR_PROFILE["toggleSkill4WhenAvailable"] := toggleSkill4WhenAvailable
  return
}

AutoSend:
{
  if (GetKeyState("Alt", "P") || GetKeyState("t", "P") || GetKeyState("m", "P") || GetKeyState("Alt", "P")) {
    Return
  }
  Gosub GetCurrentProfile

  skill_keys := [CURR_PROFILE["skill1Key"]
               , CURR_PROFILE["skill2Key"]
               , CURR_PROFILE["skill3Key"]
               , CURR_PROFILE["skill4Key"]]
  toggle_skills_when_inactive := [CURR_PROFILE["toggleSkill1WhenInactive"]
                                , CURR_PROFILE["toggleSkill2WhenInactive"]
                                , CURR_PROFILE["toggleSkill3WhenInactive"]
                                , CURR_PROFILE["toggleSkill4WhenInactive"]]
  toggle_skills_when_available := [CURR_PROFILE["toggleSkill1WhenAvailable"]
                                , CURR_PROFILE["toggleSkill2WhenAvailable"]
                                , CURR_PROFILE["toggleSkill3WhenAvailable"]
                                , CURR_PROFILE["toggleSkill4WhenAvailable"]]

  MouseGetPos mouse_x, mouse_y
  char_center_point := Point(CHARACTER_CENTER_X, CHARACTER_CENTER_Y)
  if (IsGoodClickRegion(mouse_x, mouse_y)) {
    if (CURR_PROFILE["toggleRadialClicks"]
     && Distance(mouse_x, mouse_y, char_center_point[1], char_center_point[2]) <= CURR_PROFILE["maxRadius"]) {
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

  if (sequence_num == 0) {
    if (SkillIsAvailable(2)) {
      Send, % skill_keys[2]
      sequence_num++
      COUNTER := 0
    }
  } else if (sequence_num == 1) {
    if (SkillIsActive(2)) {
      sequence_num++
    }
  } else if (sequence_num == 2) {
    if (!SkillIsActive(2) && SkillIsOnCooldown(2)) {
      Sleep, 100
      Send, % skill_keys[4]
      sequence_num++
    }
  } else if (sequence_num == 3) {
    if (!SkillIsOnCooldown(2)) {
      sequence_num := 0
    }
  }

  if (COUNTER > 50) {
    ; reset
    sequence_num := 0
  }

  repeatedKeys := CURR_PROFILE["repeatedKeys"]
  Send, %repeatedKeys%
  COUNTER := COUNTER + 1
  Return
}

; Reads in settings from a setting.ini file.
; If the file does not exist, then settings are set to defaults.
ReadSettings:
{
  CURR_PROFILE := GetDefaultProfile()
  IniRead, settings, %DEFAULT_INI_FILENAME%, SETTINGS
  Loop, Parse, settings, `n
  {
    arr := StrSplit(A_LoopField, "=")
    CURR_PROFILE[arr[1]] := arr[2]
  }

  ; Window
  Gui, Show, w300 h300, Choose Keys
  column_width := 130

  ; ========================================================================
  ; lEFT
  ; ========================================================================
  column1_x := 10
  y := 30
  Gui, Add, Text, x%column1_x% y%y% w%column_width% Center, Initial key presses:
  y += 15
  Gui, Add, Edit, x%column1_x% y%y% w%column_width% h15 vINITIAL_KEYS Center, % CURR_PROFILE["initialKeys"]

  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% Center, Keys to repeat:
  y += 15
  Gui, Add, Edit, x%column1_x% y%y% w%column_width% h15 vREPEATED_KEYS Center, % CURR_PROFILE["repeatedKeys"]

  ; Skill section
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Skill Keys

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15, 1
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_1_KEY, % CURR_PROFILE["skill1Key"]

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 2
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_2_KEY, % CURR_PROFILE["skill2Key"]

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 3
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_3_KEY, % CURR_PROFILE["skill3Key"]

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15, 4
  x += 10
  Gui, Add, Edit, x%x% y%y% w18 h15 vSKILL_4_KEY, % CURR_PROFILE["skill4Key"]

  ; Skill toggling section (when inactive)
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Toggle when inactive:

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill1WhenInactive := CURR_PROFILE["toggleSkill1WhenInactive"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill1WhenInactive% vTOGGLE_SKILL_1_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill2WhenInactive := CURR_PROFILE["toggleSkill2WhenInactive"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill2WhenInactive% vTOGGLE_SKILL_2_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill3WhenInactive := CURR_PROFILE["toggleSkill3WhenInactive"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill3WhenInactive% vTOGGLE_SKILL_3_WHEN_INACTIVE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill4WhenInactive := CURR_PROFILE["toggleSkill4WhenInactive"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill4WhenInactive% vTOGGLE_SKILL_4_WHEN_INACTIVE

  ; Skill toggling section (when available)
  y += 20
  Gui, Add, Text, x%column1_x% y%y% w%column_width% h15 Center, Toggle when available:

  y += 15
  x := column1_x
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill1WhenAvailable := CURR_PROFILE["toggleSkill1WhenAvailable"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill1WhenAvailable% vTOGGLE_SKILL_1_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill2WhenAvailable := CURR_PROFILE["toggleSkill2WhenAvailable"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill2WhenAvailable% vTOGGLE_SKILL_2_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill3WhenAvailable := CURR_PROFILE["toggleSkill3WhenAvailable"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill3WhenAvailable% vTOGGLE_SKILL_3_WHEN_AVAILABLE

  x += 22
  Gui, Add, Text, x%x% y%y% w10 h15
  x += 10
  toggleSkill4WhenAvailable := CURR_PROFILE["toggleSkill4WhenAvailable"]
  Gui, Add, CheckBox, x%x% y%y% h15 w18 Checked%toggleSkill4WhenAvailable% vTOGGLE_SKILL_4_WHEN_AVAILABLE

  ; ========================================================================
  ; RIGHT
  ; ========================================================================
  column2_x := 160

  y := 30
  toggleRadialClicks := CURR_PROFILE["toggleRadialClicks"]
  x := column2_x
  Gui, Add, Text, x%x% y%y% w100 Left, Enable radial clicks:
  x += 100
  Gui, Add, Checkbox, x%x% y%y% Checked%toggleRadialClicks% vTOGGLE_RADIAL_CLICKS,

  y += 15
  maxRadius := CURR_PROFILE["maxRadius"]
  x := column2_x
  Gui, Add, Text, x%x% y%y% w100 Left, Max radius:
  x += 55
  Gui, Add, Edit, x%x% y%y% w75 h15 vMAX_RADIUS Center, %maxRadius%

  Gui, Add, Button, x%column2_x% y170 w%column_width% h20 gSaveSettings, Save

  return
}

; Save current settings to the DEFAULT_INI_FILENAME.
SaveSettings:
{
  Gosub GetCurrentProfile
  Gui, Submit, NoHide
  for k, v in CURR_PROFILE {
    IniWrite, %v%, %DEFAULT_INI_FILENAME%, SETTINGS, %k%
  }
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


F4::
sequence_num := 0
AutoSend := !AutoSend
If AutoSend {
  Send, % CURR_PROFILE["initialKeys"]
  interval := CURR_PROFILE["interval"]
  SetTimer AutoSend, %interval%
} Else {
  SetTimer AutoSend, Off
}
Return

m::
if (AutoSend) {
  SetTimer AutoSend, Off
  keywait, m
  interval := CURR_PROFILE["interval"]
  SetTimer AutoSend, %interval%
}
Send, m
Return