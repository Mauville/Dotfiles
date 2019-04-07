﻿;                                                                                                       ;
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
#NoTrayIcon

SetTitleMatchMode, 2


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
	Send A01657110
	SoundBeep, 2500,150
	Return
:*:A016::
	Send A01657110
	SoundBeep, 2500,150
	Return

:*:A016@::
	Send A01657110@itesm.mx
	SoundBeep, 2500,150
	Return

:*:a016@::
	Send A01657110@itesm.mx
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




#d:: ;Calce
	Run, calc
	Return

#w:: ;Word
	Run, WINWORD
	Return

#m:: ; Thunderbird
	Run, thunderbird
	Return

#j:: ;Intellij
	Run, "C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2018.2.6\bin\idea64.exe"
	Return
	
#n:: ; OneNote
	Run, onenote
	Return

$#Enter UP:: ;PowerShell. If just ran, it breaks something I don't remember
	send #r
	sleep, 45
	SendInput powershell -nologo -noexit -command "cd '%USERPROFILE%'"{Enter}
	Return

#+Enter UP:: ;Powershell in current directory
	Send {Escape}
	Send ^l	
	SendInput powershell -NoLogo{Enter}
	Return

#f::  ;Run Firefox
    Run, firefox
    Return

#a:: ;Run Anki
    Run "C:\Program Files (x86)\Anki\anki.exe"
    Return

#h:: ;Open home folder
	
	Run, explorer.exe C:\Users\X220\Desktop\TEC\DOCS\TEC\PROGRAMMING\SEM2
	Return

#+h:: ;prepare a git env
	Run, powershell.exe -noexit -NoLogo -command "cd C:\Users\X220\Desktop\TEC\DOCS;git status"
	Return

#k:: ;run chips
	Run,powershell.exe C:\Users\X220\Documents\zTRUE\chips\chips.ps1
	Return

#c:: ;Edit this file
    Run, powershell.exe -noexit -command "vim %USERPROFILE%/Desktop/TEC/Dotfiles/shortcuts.ahk"
    Return

#s:: ;Source this file
    Run, "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" C:\Windows\shortcuts.ahk
    Return

#b:: ;BlackBoard
    Run, https://miscursos.tec.mx/ultra/stream
    Return

#x:: ;Shut it down!
    Msgbox, 36, Shutdown, Shutdown computer?
    IfMsgbox Yes
        Run, shutdown.exe /s /hybrid /t 1
	Return


#1:: ;Help!
    Msgbox,  Firefox `n Anki `n oneNote `n Word `n Quit `n Config `n Source `n intelliJ `n Mail `n <br>alt Powershell `n BlackBoard `n /search
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

$BackSpace:: 
    Send ^{Backspace}
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

#IfWinActive Windows PowerShell ;Imitate sudo command
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

