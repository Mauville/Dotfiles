;
;                                                                                                       ;
;                                                                                                       ;
;         db                 mm          `7MMF'  `7MMF'         mm   `7MMF' `YMM'                       ;
;        ;MM:                MM            MM      MM           MM     MM   .M'                         ;
;       ,V^MM.  `7MM  `7MM mmMMmm ,pW"Wq.  MM      MM  ,pW"Wq.mmMMmm   MM .d"     .gP"Ya `7M'   `MF'    ;
;      ,M  `MM    MM    MM   MM  6W'   `Wb MMmmmmmmMM 6W'   `Wb MM     MMMMM.    ,M'   Yb  VA   ,V      ;
;      AbmmmqMA   MM    MM   MM  8M     M8 MM      MM 8M     M8 MM     MM  VMA   8M""""""   VA ,V       ;
;     A'     VML  MM    MM   MM  YA.   ,A9 MM      MM YA.   ,A9 MM     MM   `MM. YM.    ,    VVV        ;
;   .AMA.   .AMMA.`Mbod"YML. `Mbmo`Ybmd9'.JMML.  .JMML.`Ybmd9'  `Mbmo.JMML.   MMb.`Mbmmd'    ,V         ;
;                                                                                           ,V          ;
;                                                                                        OOb"           ;
;                                                                                                       ;
;                                                                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;TODO get some env variables going.
;TODO remove hard paths
;TODO get an auto rice thing going with choco

#SingleInstance FORCE
#HotkeyInterval 160
;#NoTrayIcon
SendMode Input
CoordMode, Mouse, Screen  ; Absolute screen coordinates
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%

;Check if we have admin rights
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}


; ^#j:: ;Searches on Jisho.org
; 	prevclip=%clipboard%
; 	address=http://jisho.org/search/
; 	Send ^c
; 	query=%clipboard%
; 	fulladd=%address%%query%
; 	Run, %fulladd%
; 	clipboard:=prevclip
; 	Return

; ^#k:: ;Searches on Kanji Koohii
; 	prevclip=%clipboard%
; 	address=https://kanji.koohii.com/study/kanji/
; 	Send ^c
; 	query=%clipboard%
; 	fulladd=%address%%query%
; 	Run, %fulladd%
; 	clipboard:=prevclip
; 	Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;                       ;;;;
;;;;     Abbreviations     ;;;;
;;;;                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




:*:ahk::
	Send AutoHotKey
	SoundBeep, 2500,150
	Return


:*:posh::
	Send Powershell
	SoundBeep, 2500,150
	Return

:*:vpo::
	Send Vargas Perez Oscar
	SoundBeep, 2500,150
	Return

:*:VPO::
	Send VARGAS PEREZ OSCAR
	SoundBeep, 2500,150
	Return

:*:a016::
	Send a01657110
	SoundBeep, 2500,150
	Return
:*:A016::
	Send A01657110
	SoundBeep, 2500,150
	Return

:*:At016::
	Send A01657110@itesm.mx
	SoundBeep, 2500,150
	Return

:*:at016::
	Send a01657110@itesm.mx
	SoundBeep, 2500,150
	Return

:*:w99::
	Send w990120@outlook.com
	SoundBeep, 2500,150
	Return

:*:efr::
	Send oscar.vargas-perez@epita.fr
	SoundBeep, 2500,150
	Return

:*:vpa::
	Send Vargas Perez Oscar A01657110
	SoundBeep, 2500,150
	Return

:*:VPA::
	Send VARGAS PEREZ OSCAR A01657110
	SoundBeep, 2500,150
	Return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                    ;;;;
;;;;    Accelerators    ;;;;
;;;;                    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#d:: ;Calc
Run, "C:\Program Files (x86)\SpeedCrunch\speedcrunch.exe"
	Return

#w:: ;Whatsapp
	Run, https://web.whatsapp.com
	Return

#+w:: ;Word
	Run, WINWORD
	Return

#m:: ; Thunderbird
	Run, thunderbird
	Return

#j:: ;Intellij
	Run, idea
	Return

#n:: ; OneNote
	Run, onenote
	Return

$#Enter:: ;PowerShell. Control has been delegated to Wox
	;send #-
	;sleep, 550
	;send {enter}
	;sleep, 550
	;send !{tab}
	;sleep, 250
	;send a
    ;Return
	sendevent #r
	prevclip=%clipboard%
	command = wt
	clipboard:= command
	sleep, 250
	sendevent ^v{enter}
	clipboard:=prevclip
	;Run wt
	;Run wt ; -Process wt -Verb runasuser ; -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
	;RunAs
    ;Run wt.exe -Process wt -Verb runasuser ; -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
	Return

#+Enter:: ;Powershell in current directory
	Send {Escape}
	Send ^l
	SendInput wt {Enter}
	Return

#f::  ;Run Firefox
    Run, firefox
    Return

#a:: ;Run Anki
    Run C:\Program Files\Anki\anki.exe
    Return

#h:: ;Open Tec folder

	Run, explorer.exe %Userprofile%\Desktop\TEC
	Return

#k:: ;run chips
	Run,powershell.exe %Userprofile%\Documents\zTRUE\chips\chips.ps1
	Return

+#v:: ;Edit this file
    Run, nvim-qt.exe %USERPROFILE%\Desktop\TEC\Dotfiles\shortcuts.ahk
    Return

#s:: ;Source this file
    Reload
    Return

;;;;;;;
; courses
;;;;;;;

 +!l:: ;langs
    Run, zoommtg://zoom.us/join?action=join&confno=8896538266
 	Return

 #!l:: ;Langs
    Run, https://experiencia21.tec.mx/courses/166275/modules
 	Return

 +!a:: ;api
    Run, zoommtg://zoom.us/join?action=join&confno=8895403353
 	Return

 #!a:: ;api
 	Run, https://experiencia21.tec.mx/courses/166333/modules
 	Return

 +!e:: ;empren
    Run, zoommtg://zoom.us/join?action=join&confno=7678184265
 	Return

 #!e:: ;empren
 	Run, https://experiencia21.tec.mx/courses/164931/modules
 	Return


 +!w:: ;web
    Run, zoommtg://zoom.us/join?action=join&confno=6802790997
 	Return

 #!w:: ;web
	Run, https://experiencia21.tec.mx/courses/166317/modules
 	Return

 #!p:: ;web project
 	Run, https://experiencia21.tec.mx/courses/166355/modules
 	Return

 +!p:: ;web project
    Run, zoommtg://zoom.us/join?action=join&confno=4535959294
 	Return

 +!d:: ;deep
    Run, zoommtg://zoom.us/join?action=join&confno=96943063778
 	Return

 #!d:: ;deep
 	Run, https://experiencia21.tec.mx/courses/193568/modules
 	Return

 +!s:: ;deep
    Run, zoommtg://zoom.us/join?action=join&confno=8173250119
 	Return

; +!s:: ;Sebas
;     Run, zoommtg://zoom.us/join?action=join&confno=7301860067&pwd=TC9kS0l3V0dYUURFeWhtU1BPaUpkZz09
; 	Return
;
; +!m:: ;Martha
;     Run, zoommtg://zoom.us/join?action=join&confno=9577025203
; 	Return
;
; #!m:: ;Martha
;     Run, https://experiencia21.tec.mx/courses/162353/modules
;     Return
; #!s:: ;Sebas
; 	Run, https://classroom.google.com/u/0/w/MzY1OTk2NTg0OTMy/t/all
; 	Return

;+!a::
;    Run, zoommtg://zoom.us/join?action=join&confno=4771816524
;    Return
;
;+!c:: ;Chess
;    Run, zoommtg://zoom.us/join?action=join&confno=6970653171
;    Return
;
;#!d:: ;Databases
;    Run, https://experiencia21.tec.mx/courses/110342/modules
;    Return
;
;+!d::
;    ;Run, zoommtg://zoom.us/join?action=join&confno=2736320870
;    Run, zoommtg://zoom.us/join?action=join&confno=9088298466
;    Return
;
;#!t:: ;Tests
;    Run, https://experiencia21.tec.mx/courses/110344/modules
;    Return
;
;+!t::
;	WDay:=((A_WDay>1)?A_WDay-1:A_WDay+6)
;	MsgBox The current 24-hour time is %WDay%.
;	if(WDay = 1){
;		Run, zoommtg://zoom.us/join?action=join&confno=8895403353
;		Return
;		}
;	else{
;		Run, zoommtg://zoom.us/join?action=join&confno=9114124312
;		Return
;		}
;
;
;#!l:: ;Lineal
;    Run, https://experiencia21.tec.mx/courses/127076/modules
;    Return
;
;+!l::
;    Run, zoommtg://zoom.us/join?action=join&confno=8543638819
;    Return
;
;#!m:: ;Mobile
;    Run, https://experiencia21.tec.mx/courses/110334/modules
;    Return
;
;+!m::
;    Run, zoommtg://zoom.us/join?action=join&confno=6592082834
;    Return
;
;#!p:: ;Photo
;    Run, https://experiencia21.tec.mx/courses/129956/modules
;    Return
;
;+!p::
;    Run, zoommtg://zoom.us/join?action=join&confno=5738939861
;    Return
;
;+!u::
;    Run, zoommtg://zoom.us/join?action=join&confno=6320104751
;    Return
;+!o::
;    Run, zoommtg://zoom.us/join?action=join&confno=6491302891
;    Return



#+x:: ;Restart
    Msgbox, 36, Restart, Restart computer?
    IfMsgbox Yes
        Run, shutdown.exe /r /t 1
	Return

#x:: ;Shut it down!
    Msgbox, 36, Shutdown, Shutdown computer?
    IfMsgbox Yes
        Run, shutdown.exe /s /hybrid /t 1
	Return

#e:: ;Explorer on home directory
    Run, explorer %USERPROFILE%
    Return

#+e:: ;Default Explorer
    Run, explorer
    Return

#1:: ;Help!
    Msgbox,  Firefox `n Anki `n oneNote `n Word `n Quit `n Config `n Source `n intelliJ `n Mail `n <br>alt Powershell `n BlackBoard `n /search
    Return


#!2:: ;Extended Documentation
    str :=" .... literal block `n ---- code block `n **** sidebar `n//// comment `n -- any block `n ____ blockquote `n ++++ passthrough/latex `n  ==== example `n table `n |=== `n |header |header | `n `n |cell1|cell2|`n `n` NOTE: ℹ,`n TIP: 💡`n IMPORTANT:🔴, `n WARNING:⚠, `n `CAUTION:🔥 "
    Msgbox, %str%
    Return

#2:: ;Documentation
    Run, https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/
    Return

#3:: ;Documentation
    Run, https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols#Set_and.2For_logic_notation
    Return

#+2:: ;Extended Documentation
    Run, https://asciidoctor.org/docs/user-manual/
    Return

#/:: ;Search Prompt
	Run everything.exe
	Return

#Esc:: ;Pause Script
    Pause
    Return

#+Esc:: ;Kill Script
    ExitApp
    Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                              ;;;;
;;;;    Remap Caps to <BS> and <BS> to <C-BS>     ;;;;
;;;;                                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




$CapsLock::
    Send {Backspace}
    Return

$^CapsLock::
    Send ^{Backspace}
    Return

$+CapsLock::
    Send +{Backspace}
    Return

$!CapsLock::
    Send +{Backspace}
    Return

$BackSpace::
    Send ^{Backspace}
    Return

$+BackSpace::
    Send ^+{Backspace}
    Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                              ;;;;
;;;;    External Keyboard Shortcuts               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


^+d:: ^#Right ;X220 specific bind. Use Browser Forward key to switch desktops


^+a:: ^#Left ;X220 specific bind. Use Browser Back key to switch desktops


;;Pause as mute key
;Pause::
;
;SoundSet, +1, MASTER, mute,11 ;12 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 12's  <---------IMPORTANT
;SoundGet, mas
;
;ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle
;SetTimer, RemoveToolTip, 1000
;return
;
;RemoveToolTip:
;SetTimer, RemoveToolTip, Off
;ToolTip
;return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                              ;;;;
;;;;   Program Specific Hotkeys   ;;;;
;;;;                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;XButton2::
	;MouseGetPos, posX, posY ; Get mouse position
	;If (posX <= 22) and (posY <= 22){
		;Send ^#{Right} ;X220 specific bind. Use Browser Forward key to switch desktops
		;Return
		;}
	;Send {Browser_Forward}
	;;Return
;XButton1::
	;MouseGetPos, posX, posY ; Get mouse position
	;If (posX <= 22) and (posY <= 22){
		;Send ^#{Left} ;X220 specific bind. Use Browser Forward key to switch desktops
	;}
	;Send {Browser_Back}
	;Return
;
		;Return
#q:: ;i3 like Kill Button
    Send !{F4}
    Return

#IfWinActive Windows PowerShell ;Enable Alt+F4 in Powershell
#q::
    Send {Esc}exit{enter}
    Return
+Up::
    Send {Up}{enter}
    Return
#IfWinActive


#IfWinActive Zoom Meeting ;Enable PrintScreen on Zoom
PrintScreen::
    Send ^!+{F8}
    Return
^PrintScreen::
    Send ^!+{F9}
    Return
^+PrintScreen::
    Send ^!+{F10}
    Return
XButton2::
	MouseGetPos, posX, posY ; Get mouse position
	If (posX <= 22) and (posY <= 22){
		Send ^#{Right} ;X220 specific bind. Use Browser Forward key to switch desktops
		Return
	}
	Send !v
    Return
XButton1::
	MouseGetPos, posX, posY ; Get mouse position
	If (posX <= 22) and (posY <= 22){
		Send ^#{Left} ;X220 specific bind. Use Browser Forward key to switch desktops
		Return
	}
	Send !a
    Return
#IfWinActive

#IfWinActive Mozilla Firefox ;Search selected word on engine
^Space::
    Send ^c
    Send ^t
    Sleep 255
    Send ^v
    Send {Enter}
    Return
#IfWinActive


#IfWinActive Neovim
;Enable Alt+F4 in VIM
#q::
    Send :q{!}{Enter}
    Return

;Enable Ctrl+BackSpace in Vim
$BackSpace::
	Send ^w
	Return

F11::
	Send ^{F11}
    Return

#IfWinActive

#IfWinActive Thunderbird ; Archive on thunderbird
F12::
    Send {AppsKey}h
    Return
#IfWinActive


#IfWinActive User 1 - Anki ;Remap ` to undo in Anki
`::
    Send ^z
    Return
#IfWinActive

;#IfWinActive PowerShell ;Imitate sudo command in PowerShell
;:*:sudo::
;    SendInput Start-Process Powershell -Verb runAs -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
;    Return
;#IfWinActive
;
;#IfWinActive powerShell ;Imitate sudo command in PowerShell
;:*:sudo::
;    SendInput Start-Process Powershell -Verb runAs -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
;    Return
;#IfWinActive

~RButton & LButton Up:: ;X220 specific bind. Get Linux middle click with two buttons working
MouseClick, Middle
Return

~LButton & RButton Up:: ;X220 specific bind. Get Linux middle click with two buttons working
MouseClick, Middle
Return

Browser_Forward::^#Right ;X220 specific bind. Use Browser Forward key to switch desktops

Browser_Back::^#Left ;X220 specific bind. Use Browser Back key to switch desktops

+Browser_Forward:: ;Switch current thing to desktop right
	Send #!Right
	Return

+Browser_Back:: ;Switch current thing to desktop left
	Send #!Left

	Return

/* $*MButton:: */

/* Hotkey, $*MButton Up, MButtonup, off */
/* KeyWait, MButton, T0.2 */
/* If ErrorLevel = 1 */
/* { */
/* 	Hotkey, $*MButton Up, MButtonup, on */
/* 	MouseGetPos, ox, oy */
/*  	SetTimer, WatchTheMouse, 1 */
/* 	SystemCursor("Toggle") */
/* } */
/* Else */
/* 	Send {MButton} */
/* return */

/* MButtonup: */
/* Hotkey, $*MButton Up, MButtonup, off */
/* SetTimer, WatchTheMouse, off */
/* SystemCursor("Toggle") */
/* return */

/* WatchTheMouse: */
/* MouseGetPos, nx, ny */
/* dy := ny-oy */
/* dx := nx-ox */
/* If (dx**2 > 0 and dx**2>dy**2) ;edit 4 for sensitivity (changes sensitivity to movement) */
/* { */
/* 	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal) */
/* 	Loop, %times% */
/* 	{ */
/* 		If (dx > 0) */
/* 			Click WheelRight */
/* 		Else */
/* 			Click WheelLeft */
/*    	} */
/* } */
/* If (dy**2 > 0 and dy**2>dx**2) ;edit 0 for sensitivity (changes sensitivity to movement) */
/* { */
/* 	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal) */
/* 	Loop, %times% */
/* 	{ */
/* 		If (dy > 0) */
/* 			Click WheelDown */
/* 		Else */
/* 			Click WheelUp */
/* 	} */
/* } */
/* MouseMove ox, oy */
/* return */

/* SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others */
/* { */
/*     static AndMask, XorMask, $, h_cursor */
/*         ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors */
/*         , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors */
/*         , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors */
/*     if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call */
/*     { */
/*         $ = h                                          ; active default cursors */
/*         VarSetCapacity( h_cursor,4444, 1 ) */
/*         VarSetCapacity( AndMask, 32*4, 0xFF ) */
/*         VarSetCapacity( XorMask, 32*4, 0 ) */
/*         system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650 */
/*         StringSplit c, system_cursors, `, */
/*         Loop %c0% */
/*         { */
/*             h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% ) */
/*             h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 ) */
/*             b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0 */
/*                 , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask ) */
/*         } */
/*     } */
/*     if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T")) */
/*         $ = b  ; use blank cursors */
/*     else */
/*         $ = h  ; use the saved cursors */

/*     Loop %c0% */
/*     { */
/*         h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 ) */
/*         DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% ) */
/*     } */
/* } */
