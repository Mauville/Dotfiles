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


^#j:: ;Searches on Jisho.org
	prevclip=%clipboard%
	address=http://jisho.org/search/
	Send ^c
	query=%clipboard%
	fulladd=%address%%query%
	Run, %fulladd%
	clipboard:=prevclip
	Return 

^#k:: ;Searches on Kanji Koohii
	prevclip=%clipboard%
	address=https://kanji.koohii.com/study/kanji/
	Send ^c
	query=%clipboard%
	fulladd=%address%%query%
	Run, %fulladd%
	clipboard:=prevclip
	Return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       ;;;;
;;;;     Abbreviations     ;;;;
;;;;                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




:*:ahk::
	Send AutoHotKey
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

:*:atA016::
	Send A01657110@itesm.mx
	SoundBeep, 2500,150
	Return

:*:at016::
	Send a01657110@itesm.mx
	SoundBeep, 2500,150
	Return

:*:vpoa016::
	Send Vargas Perez Oscar A01657110
	SoundBeep, 2500,150
	Return

:*:VPOA016::
	Send VARGAS PEREZ OSCAR A01657110
	SoundBeep, 2500,150
	Return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                    ;;;;
;;;;    Accelerators    ;;;;
;;;;                    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;



#d:: ;Calc
	Run, calc
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
	Run, idea64.exe
	Return
	
#n:: ; OneNote
	Run, onenote
	Return

#+PrintScreen:: ; Open Scrot directory
	Run, explorer.exe  C:/Users/X220/Pictures/Screenshots
	Return

$#Enter:: ;PowerShell. If just ran, it breaks something I don't remember
	send #r
	prevclip=%clipboard%
	command = powershell -nologo -noexit -command "cd '%USERPROFILE%'"
	clipboard:= command
	sleep, 60
	send ^v{enter}
	clipboard:=prevclip
	Return

#+Enter:: ;Powershell in current directory
	Send {Escape}
	Send ^l	
	SendInput powershell -nologo {Enter}
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

#c:: ;Edit this file
    Run, vim %USERPROFILE%/Desktop/TEC/Dotfiles/shortcuts.ahk
    Return

#s:: ;Source this file
    Reload
    Return

#+b:: ;BlackBoard
    Run, https://miscursos.tec.mx/ultra/stream
    Return

#b:: ;Canvas
    Run, https://experiencia21.tec.mx
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

#2:: ;Documentation
    Run, https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/
    Return
#+2:: ;Extended Documentation
    Run, https://asciidoctor.org/docs/user-manual/
    Return
#!2:: ;Equations
    Run, http://offcenterapps.com/asciidoctor/
    Return

#/:: ;Search Prompt
    InputBox, qry, Search, Startpage Search:,, , 125, 600
    address=https://www.startpage.com/do/dsearch?query=
    tail=&cat=web&pl=ext-ff&language=english

	if ErrorLevel
		Return
	else
	    Run, %address%%qry%%tail%
	    Return

#v:: ;Visual Code
    Run, code
    Reload
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                              ;;;;
;;;;   Program Specific Hotkeys   ;;;;
;;;;                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




#q:: ;i3 like Kill Button
    Send !{F4}
    Return

#IfWinActive Windows PowerShell ;Enable Alt+F4 in Powershell
#q:: 
    Send exit{enter}
    Return 
#IfWinActive

#IfWinActive Mozilla Firefox ;Search selected word on engine
^Space:: 
    Send ^c 
    Send ^t 
    Sleep 155
    Send ^v 
    Send {Enter}
    Return 
#IfWinActive

#IfWinActive PowerShell ;Enable Alt+F4 in Cmder
#q:: 
    Send exit{enter}
    Return 
#IfWinActive

#IfWinActive VIM ;Enable Alt+F4 in VIM
#q:: 
    Send :q!!{enter}
    Return 
#IfWinActive

#IfWinActive VIM ;Enable Ctrl+BackSpace in Vim
    $BackSpace:: 
    Send ^w
    Return
#IfWinActive

#IfWinActive Anki - Oscar ;Remap ` to undo in Anki
`::
    Send ^z
    Return 
#IfWinActive

#IfWinActive PowerShell ;Imitate sudo command in PowerShell
:*:sudo::
    SendInput Start-Process Powershell -Verb runAs -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
    Return
#IfWinActive

#IfWinActive powerShell ;Imitate sudo command in PowerShell
:*:sudo::
    SendInput Start-Process Powershell -Verb runAs -ArgumentList "-noexit", "-command cd $PWD;cls";exit{Enter}
    Return
#IfWinActive

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

$*MButton::

Hotkey, $*MButton Up, MButtonup, off
KeyWait, MButton, T0.2
If ErrorLevel = 1
{
	Hotkey, $*MButton Up, MButtonup, on
	MouseGetPos, ox, oy
 	SetTimer, WatchTheMouse, 1
	SystemCursor("Toggle")
}
Else
	Send {MButton}
return

MButtonup:
Hotkey, $*MButton Up, MButtonup, off
SetTimer, WatchTheMouse, off
SystemCursor("Toggle")
return

WatchTheMouse:
MouseGetPos, nx, ny
dy := ny-oy
dx := nx-ox
If (dx**2 > 0 and dx**2>dy**2) ;edit 4 for sensitivity (changes sensitivity to movement)
{
	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal)
	Loop, %times%
	{
		If (dx > 0)
			Click WheelRight
		Else
			Click WheelLeft
   	}
}
If (dy**2 > 0 and dy**2>dx**2) ;edit 0 for sensitivity (changes sensitivity to movement)
{
	times := Abs(dy)/1 ;edit 1 for sensitivity (changes frequency of scroll signal)
	Loop, %times% 
	{
		If (dy > 0)
			Click WheelDown
		Else
			Click WheelUp
	}   
}
MouseMove ox, oy
return

SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors
    if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
    {
        $ = h                                          ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
            b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
                , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
        }
    }
    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
        $ = b  ; use blank cursors
    else
        $ = h  ; use the saved cursors

    Loop %c0%
    {
        h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
        DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}
