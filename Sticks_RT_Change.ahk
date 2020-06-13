#Persistent
#SingleInstance force

SendMode Input
#Include XInput.ahk
#NoEnv
SetWinDelay 0

CoordMode Mouse, Screen

XInput_Init()

global Flipped := 0
global Toggle := 0
global StickMove := 0
global KeyPressed := 0
global MenuOpened := 0
global StartDebounce := 0
global vRed

;OTHER

ID1 := Box(2,4,70)
ID2 := Box(3,70,4)

ID3 := QWERT(4, "A", 0)
ID4 := QWERT(5, "B", 1)
ID5 := QWERT(6, "X", 2)
ID6 := QWERT(7, "Y", 3)
ID7 := QWERT(8, "LS", 4)
;controller6 := Controls(9, "RS", 5)
ID8 := Clicks(9, "LT", 0)
ID9 := Clicks(10, "RT", 1)
ID10 := Clicks(11, "RS", 2)


ID11 := Flasks(12, "LB", 0)
ID12 := Flasks(13, "Le", 1)
ID13 := Flasks(14, "Up", 2)
ID14 := Flasks(15, "Ri", 3)
ID15 := Flasks(16, "RB", 4)
ID16 := OurMenu(17)

MAX_STICK_POS := 26500

ReleasePressedKey(key)
{
	GetKeyState, state, %key%
	if state = D
		Send {%key% up}

}

PressKey(key)
{
	global KeyPressed := 1
	GetKeyState, state, %key%
	if state = U
		Send {%key% down}
}

ClickLeft(){
	GetKeyState, state, LButton
	if state = U
		Click, down, left
}

UnClickLeft(){
	GetKeyState, state, LButton
	if state = D
		Click, up, left
}

ClickMiddle(){
	GetKeyState, state, MButton
	if state = U
		Click, down, middle
}

UnClickMiddle(){
	GetKeyState, state, MButton
	if state = D
		Click, up, middle
}

ClickRight(){
	GetKeyState, state, RButton
	if state = U
		Click, down, right
}

UnClickRight(){
	GetKeyState, state, RButton
	if state = D
		Click, up, right
}
Box(n,wide,high)
{
   Gui %n%:Color, 00FFFF                  ; Black
   Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
   Gui %n%:+Border
   Gui %n%: Show, Center W%wide% H%high%      ; Show it
   WinGet ID, ID, A                    ; ...with HWND/handle ID
   Winset AlwaysOnTop,ON,ahk_id %ID%   ; Keep it always on the top
   WinSet Transparent,255,ahk_id %ID%  ; Opaque
	
   Return ID
}
QWERT(n,message,offset){
	global
	Gui %n%:Color, EEAA99
	Gui %n%: -Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%:Font, cBlack S20, Trebuchet MS
	place1y := A_ScreenHeight*.955
	place1x := A_ScreenWidth*.741+(offset*A_ScreenWidth*.03)
	WinGet ID, ID, A                    ; ...with HWND/handle ID

	Gui %n%:Add, Text, cWhite x%place1x% y%place1y% vRed, %message%
	Gui %n%: +LastFound +AlwaysOnTop +ToolWindow +E0x20
	WinSet, TransColor, EEAA99
	Gui %n%: -Caption
	Gui %n%:Show, Maximize, Center, A_ScreenWidth, A_ScreenHeight
	
	Return ID
}

Clicks(n,message,offset){
	global
	Gui %n%:Color, EEAA99
	Gui %n%: -Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%:Font, cBlack S20, Trebuchet MS
	place1y := A_ScreenHeight*.89
	place1x := A_ScreenWidth*.8+(offset*A_ScreenWidth*.03)
	WinGet ID, ID, A                    ; ...with HWND/handle ID

	Gui %n%:Add, Text, cWhite x%place1x% y%place1y% vRed, %message%
	Gui %n%: +LastFound +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui %n%: -Caption
	Gui %n%:Show, Maximize, Center, A_ScreenWidth, A_ScreenHeight
	
	Return ID
}

Flasks(n,message,offset){
	global
	Gui %n%:Color, EEAA99
	Gui %n%: -Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%:Font, cBlack S20, Trebuchet MS
	place1y := A_ScreenHeight*.955
	place1x := A_ScreenWidth*.164+(offset*A_ScreenWidth*.0242)
	WinGet ID, ID, A                    ; ...with HWND/handle ID

	Gui %n%:Add, Text, cWhite x%place1x% y%place1y% vRed, %message%
	Gui %n%: +LastFound +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui %n%: -Caption
	Gui %n%:Show, Maximize, Center, A_ScreenWidth, A_ScreenHeight
	
	Return ID
}

OurMenu(n){
	global
	our_height := A_ScreenHeight*.5
	our_width := A_ScreenWidth*.5
	Gui, Show , w%our_width% h%our_height%, Window title
	Gui, -Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui, Font, S30, Trebuchet MS
	
	button_width := our_width/2
	button_height := our_height/3
	; here you have a text, button and edit
	of_1 := button_height
	of_2 := button_height*2
	
	Gui, Add, Button, x0 y0 w%button_width% h%button_height% vFIRSTBUTTON gCharinfo, Character Info
	Gui, Add, Button, x0 y%of_1% w%button_width% h%button_height% vSECONDBUTTON gInventory, Inventory
	Gui, Add, Button, x0 y%of_2% w%button_width% h%button_height% vTHIRDBUTTON gHideout, Hideout
	Gui, Add, Button, x%button_width% y0 w%button_width% h%button_height% vFOURTHBUTTON gPassives, Passives
	Gui, Add, Button, x%button_width% y%of_1% w%button_width% h%button_height% vFIFTHBUTTON gQuit, Logout
	Gui, Add, Button, x%button_width% y%of_2% w%button_width% h%button_height% vSIXTHBUTTON gSettings, Settings
}

ReadKeys(keys){
	global Red
    ; Constants for gamepad buttons
    XINPUT_GAMEPAD_DPAD_UP          := 0x1
    XINPUT_GAMEPAD_DPAD_DOWN        := 0x2
    XINPUT_GAMEPAD_DPAD_LEFT        := 0x4
    XINPUT_GAMEPAD_DPAD_RIGHT       := 0x8
    XINPUT_GAMEPAD_MENU             := 0x10
    XINPUT_GAMEPAD_VIEW             := 0x20
    XINPUT_GAMEPAD_LEFT_STICK       := 0x40
    XINPUT_GAMEPAD_RIGHT_STICK      := 0x80
    XINPUT_GAMEPAD_LEFT_BUMPER      := 0x100
    XINPUT_GAMEPAD_RIGHT_BUMPER     := 0x200
    XINPUT_GAMEPAD_XBOX             := 0x400
    XINPUT_GAMEPAD_A                := 0x1000
    XINPUT_GAMEPAD_B                := 0x2000
    XINPUT_GAMEPAD_X                := 0x4000
    XINPUT_GAMEPAD_Y                := 0x8000

	
	A := XINPUT_GAMEPAD_A & keys
	B := XINPUT_GAMEPAD_B & keys
	X := XINPUT_GAMEPAD_X & keys
	Y := XINPUT_GAMEPAD_Y & keys
	Start := XINPUT_GAMEPAD_MENU & keys
	Select := XINPUT_GAMEPAD_VIEW & keys
	LS := XINPUT_GAMEPAD_LEFT_STICK & keys
	RS := XINPUT_GAMEPAD_RIGHT_STICK & keys
	LB := XINPUT_GAMEPAD_LEFT_BUMPER & keys
	RB := XINPUT_GAMEPAD_RIGHT_BUMPER & keys
	XBox := XINPUT_GAMEPAD_XBOX & keys
	Up := XINPUT_GAMEPAD_DPAD_UP & keys
	Down := XINPUT_GAMEPAD_DPAD_DOWN & keys
	Left := XINPUT_GAMEPAD_DPAD_LEFT & keys
	Right := XINPUT_GAMEPAD_DPAD_RIGHT & keys
	
	if(A){
		PressKey(1)
		GuiControl 4:+cRed, Red
		GuiControl 4:, Red, A
	}else{
		ReleasePressedKey(1)
		GuiControl 4:+cWhite, Red
		GuiControl 4:, Red, A
	}
	
	if(B){
		PressKey(2)
		GuiControl 5:+cRed, Red
		GuiControl 5:, Red, B
	}else{
		ReleasePressedKey(2)
		GuiControl 5:+cWhite, Red
		GuiControl 5:, Red, B
	}
	
	if(X){
		PressKey(3)
		GuiControl 6:+cRed, Red
		GuiControl 6:, Red, X
	}else{
		ReleasePressedKey(3)
		GuiControl 6:+cWhite, Red
		GuiControl 6:, Red, X
	}
	
	if(Y){
		PressKey(4)
		GuiControl 7:+cRed, Red
		GuiControl 7:, Red, Y
	}else{
		ReleasePressedKey(4)
		GuiControl 7:+cWhite, Red
		GuiControl 7:, Red, Y
	}
	
	if(LB){
		PressKey("q")
		GuiControl 12:+cRed, Red
		GuiControl 12:, Red, LB
	}else{
		ReleasePressedKey("q")
		GuiControl 12:+cWhite, Red
		GuiControl 12:, Red, LB
	}
	
	if(RB){
		PressKey("space")
		GuiControl 16:+cRed, Red
		GuiControl 16:, Red, RB
	}else{
		ReleasePressedKey("space")
		GuiControl 16:+cWhite, Red
		GuiControl 16:, Red, RB
	}
	
	if(Up){
		PressKey("e")
		GuiControl 14:+cRed, Red
		GuiControl 14:, Red, Up
	}else{
		ReleasePressedKey("e")
		GuiControl 14:+cWhite, Red
		GuiControl 14:, Red, Up
	}
	
	if(Down){
		PressKey("t")
	}else{
		ReleasePressedKey("t")
	}
	
	if(Left){
		PressKey("w")
		GuiControl 13:+cRed, Red
		GuiControl 13:, Red, Le
	}else{
		ReleasePressedKey("w")
		GuiControl 13:+cWhite, Red
		GuiControl 13:, Red, Le
	}
	
	if(Right){
		PressKey("r")
		GuiControl 15:+cRed, Red
		GuiControl 15:, Red, Ri
	}else{
		ReleasePressedKey("r")
		GuiControl 15:+cWhite, Red
		GuiControl 15:, Red, Ri
	}
	
	if(Select){
		PressKey("tab")
	}else{
		ReleasePressedKey("tab")
	}
	
	if(Start){
		if(MenuOpened){
			if(StartDebounce == 0){
				StartDebounce := 1
				MenuOpened := 0
				Gui, Hide
			}
		}else{
			if(StartDebounce == 0){
				StartDebounce := 1
				MenuOpened := 1
				Gui, Show
			}
		}
	}else{
		StartDebounce := 0
	}
	
	if(RS){
		ClickRight()
		GuiControl 11:+cRed, Red
		GuiControl 11:, Red, RS
	}else{
		UnClickRight()
		GuiControl 11:+cWhite, Red
		GuiControl 11:, Red, RS
	}
	
	if(LS){
		PressKey(5)
		GuiControl 8:+cRed, Red
		GuiControl 8:, Red, LS
	}else{
		ReleasePressedKey(5)
		GuiControl 8:+cWhite, Red
		GuiControl 8:, Red, LS
	}
	
}

stickSensibility := 1 / 1000

Thread, interrupt, 0  ; Make all threads always-interruptible.

SetTimer, Sticks, 5
Gui 2:Hide 
Gui 3:Hide 
Gui 4:Hide 
Gui 5:Hide 
Gui 6:Hide 
Gui 7:Hide 
Gui 8:Hide 
Gui 9:Hide 
Gui 10:Hide 
Gui 11:Hide 
Gui 12:Hide 
Gui 13:Hide 
Gui 14:Hide 
Gui 15:Hide 
Gui 16:Hide
Gui, Hide
return
DoubleCheck := 0
Sticks:
    Loop, 1 {
		if(Toggle){
			;Drawing Stuff
			MouseGetPos RulerX, RulerY
		   ;RulerX := RulerX - 5  ;enable to offset the mouse pointer a bit
		   ;RulerY := RulerY - 5
		   If (OldX <> RulerX)
			 OldX := RulerX
		   If (OldY <> RulerY)
			  OldY := RulerY
		   RulerXShift := RulerX - 35
		   RulerYShift := RulerY - 35
		   WinMove ahk_id %ID1%,, %RulerX%, %RulerYShift%   ;create crosshair by moving 1/2 length of segment
		   WinMove ahk_id %ID2%,, %RulerXShift%, %RulerY%
			
			
			if state := XInput_GetState(A_Index-1) {
				WinGetPos, winX, winY, winWidth, winHeight, A
				ReadKeys(state.wButtons)
				global Flipped
				if(Flipped == 1){
					LSx := state.sThumbRX
					LSy := state.sThumbRY
					RSx := state.sThumbLX
					RSy := state.sThumbLY
				}else{
					LSx := state.sThumbLX
					LSy := state.sThumbLY
					RSx := state.sThumbRX
					RSy := state.sThumbRY
				}
				
				if(state.bLeftTrigger){
					ClickLeft()
					GuiControl 9:+cRed, Red
					GuiControl 9:, Red, LT
				}else{
					UnClickLeft()
					GuiControl 9:+cWhite, Red
					GuiControl 9:, Red, LT
				}
				
				if(state.bRightTrigger){
					PressKey("RCtrl")
					GuiControl 10:+cRed, Red
					GuiControl 10:, Red, RT
				}else{
					ReleasePressedKey("RCtrl")
					GuiControl 10:+cWhite, Red
					GuiControl 10:, Red, RT
				}
				
				RSHypotenuse := sqrt(RSx * RSx + RSy * RSy)
				if (RSHypotenuse > XINPUT_GAMEPAD_RIGHT_STICK_DEADZONE) {
					RSValue := RSHypotenuse - XINPUT_GAMEPAD_RIGHT_STICK_DEADZONE
					RSValueInProportion := RSValue / (32767 - XINPUT_GAMEPAD_RIGHT_STICK_DEADZONE)
					;MsgBox % RSx . " - " . RSy . " - " . RSHypotenuse . " - " . RSValue . " - " . RSValueInProportion
					SetMouseDelay, -1 ; Makes movement smoother.
					if RSValueInProportion > 1
						RSValueInProportion := 1
					S := (1 - RSValueInProportion) * 100
					RSx *= RSValueInProportion * stickSensibility				
					RSy *= RSValueInProportion * stickSensibility				
					MouseMove, RSx, -RSy, S, R
				}
				;if (abs(LSx) < XINPUT_GAMEPAD_LEFT_STICK_DEADZONE)
				;{
				;	ReleasePressedDirectionalKey("Right")
				;	ReleasePressedDirectionalKey("Left")
				;	LSx := 0
				;	xDirection := ""
				;	xDirectionLast := ""
				;}				
				;if (abs(LSy) < XINPUT_GAMEPAD_LEFT_STICK_DEADZONE)
				;{
				;	ReleasePressedDirectionalKey("Up")
				;	ReleasePressedDirectionalKey("Down")
				;	LSy := 0
				;	yDirection := ""
				;	yDirectionLast := ""
				;}
				;if LSx
				;	xDirection := LSx > 0 ? "Right" : "Left"
				;if LSy
				;	yDirection := LSy > 0 ? "Up" : "Down"
				;;MsgBox % LSx . " / " . xDirection . " / " . xDirectionLast . " / " . LSy . " / " . yDirection . " / " . yDirectionLast
				;if (xDirection != "" && xDirection != xDirectionLast)
				;{
				;	ReleasePressedDirectionalKey(xDirectionLast)
				;	Send {%xDirection% down}
				;	xDirectionLast := xDirection
				;}
				;if (yDirection != "" && yDirection != yDirectionLast)
				;{
				;	ReleasePressedDirectionalKey(yDirectionLast)
				;	Send {%yDirection% down}
				;	yDirectionLast := yDirection
				;}
				;8 689 = RS dead zone
				;24 078 = RS live zone
				;32 767	= radius
				
				;TopLeft = -26,500 26,500
				;Left = -32,768 0
				;BotLeft = -26,500 -26,500
				;MsgBox % LSx . " / " . LSy
				
				if(LSx > MAX_STICK_POS){
					LSx := MAX_STICK_POS
				}else if(LSx < -MAX_STICK_POS){
					LSx := -MAX_STICK_POS
				}
				
				if(LSy > MAX_STICK_POS){
					LSy := MAX_STICK_POS
				}else if(LSy < -MAX_STICK_POS){
					LSy := -MAX_STICK_POS
				}
				;MsgBox % LSx . " - " . LSy
				;MsgBox % LSx . " - " . LSy . " - " . LSHypotenuse . " - " . LSValue . " - " . LSValueInProportion
				LSHypotenuse := sqrt(LSx * LSx + LSy * LSy)
				if (LSHypotenuse > XINPUT_GAMEPAD_LEFT_STICK_DEADZONE_MINI) {
					if (LSHypotenuse > XINPUT_GAMEPAD_LEFT_STICK_DEADZONE) {
						DoubleCheck := 1
						LSValue := LSHypotenuse - XINPUT_GAMEPAD_LEFT_STICK_DEADZONE
						LSValueInProportion := LSValue / (MAX_STICK_POS - XINPUT_GAMEPAD_LEFT_STICK_DEADZONE)
						SetMouseDelay, -1 ; Makes movement smoother.
						if LSValueInProportion > 1
							LSValueInProportion := 1
						S := (1 - LSValueInProportion) * 100
						LSx *= LSValueInProportion				
						LSy *= LSValueInProportion

						;-24700L, 32700R
						;-32700U, 32700D
						;MsgBox % RSx

						xPix := 0
						yPix := 0

						;1920, 1080
						;960, 660

						xPix := (LSx / (MAX_STICK_POS/(A_ScreenWidth/2)))  + A_ScreenWidth /2
						if(LSy < 0){
							yPix :=  A_ScreenHeight /2.25 + (LSy / (-MAX_STICK_POS/(A_ScreenHeight / 2.25)))
						}else{
							yPix :=  A_ScreenHeight /2.25 - (LSy / (MAX_STICK_POS/(A_ScreenHeight / 1.8)))
						}
							
						if(xPix > A_ScreenWidth*.85){
							xPix := A_ScreenWidth*.85
						}else if(xPix < A_ScreenWidth*.15){
							xPix := A_ScreenWidth*.15
						}
						
						if(yPix > A_ScreenHeight*.85){
							yPix := A_ScreenHeight*.85
						}else if(yPix < A_ScreenHeight*.15){
							yPix := A_ScreenHeight*.15
						}
						
						if(StickMove){
							ClickLeft()
						}
						MouseMove, xPix, yPix
					}else if((LSx = -4386) and (-LSy = -255)) {
						;Drop input
					} else {
						if(StickMove){
							ClickLeft()
						}
						MouseMove, A_ScreenWidth /2, A_ScreenHeight /2.25
					}
				}else if (DoubleCheck){
					DoubleCheck := 0
					MouseMove, A_ScreenWidth/2, A_ScreenHeight/2.25
					UnClickLeft()
				}
			}
		}
    }
return


Numpad0::
	global Toggle
	if(Toggle){
		Toggle := 0
		Gui 2:Hide 
		Gui 3:Hide 
		Gui 4:Hide 
		Gui 5:Hide 
		Gui 6:Hide 
		Gui 7:Hide 
		Gui 8:Hide 
		Gui 9:Hide 
		Gui 10:Hide 
		Gui 11:Hide 
		Gui 12:Hide 
		Gui 13:Hide 
		Gui 14:Hide 
		Gui 15:Hide 
		Gui 16:Hide
		Gui, Hide
		Visible := False
	}else{
		Toggle := 1
		Gui 2:Show 
		Gui 3:Show 
		Gui 4:Show 
		Gui 5:Show 
		Gui 6:Show 
		Gui 7:Show 
		Gui 8:Show 
		Gui 9:Show 
		Gui 10:Show 
		Gui 11:Show 
		Gui 12:Show 
		Gui 13:Show 
		Gui 14:Show 
		Gui 15:Show 
		Gui 16:Show
		Visible := True
	}
return

NumpadDot::
	Send {LCtrl Down}
	Sleep 10
	MouseClick, Left
	Sleep 10
	Send {LCtrl Up}
return

XButton2::
	MouseClick, Middle
return

Passives:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send f
Gui, Hide
return

Charinfo:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send c
Gui, Hide
return

Inventory:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send b
Gui, Hide
return

Hideout:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send {enter}
sleep 100
SendRaw /hideout
sleep 10
Send {enter}
Gui, Hide
return

Quit:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send {enter}
sleep 100
SendRaw /exit
sleep 10
Send {enter}
Gui, Hide
return

Settings:
MenuOpened := 0
WinActivate, ahk_class POEWindowClass
Send {Esc}
Gui, Hide
return