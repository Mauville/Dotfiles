#SingleInstance FORCE
#HotkeyInterval 160
#NoTrayIcon 

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

:*:ahk::
	Send AutoHotKey
	SoundBeep, 2500,150
	Return
	

:*:vpo::
	Send Vargas Pérez Oscar
	SoundBeep, 2500,150
	Return

:*:VPO::
	Send VARGAS PÉREZ OSCAR
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
	Send Vargas Pérez Oscar A01657110
	SoundBeep, 2500,150
	Return

:*:VPOA016::
	Send VARGAS PÉREZ OSCAR A01657110
	SoundBeep, 2500,150
	Return

; :c*:ai::
	; Send, Illustrator
	; SoundBeep, 2500,150
	; Return
	
;:*:ps::
	;Send, Photoshop
	;SoundBeep, 2500,150
	;Return

;:*:9h9p9d::
	;Send, Nine Hours Nine Persons Nine Doors 
	;SoundBeep, 2500,150
	;Return

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

#Enter:: ;PowerShell
	send #r
	prevclip=%clipboard%
	command = powershell -nologo -noexit -command "cd '%USERPROFILE%'"
	clipboard:= command
	sleep, 45
	send ^v{enter}
	clipboard:=prevclip
	Return

	
^#e:: ;Eject Whatever's on E://
	eject= 
	(
	$driveEject = New-Object -comObject Shell.Application
	$driveEject.Namespace(17).ParseName("E:").InvokeVerb("Eject")
	exit`n
	)
	Run powershell (New-Object -comObject Shell.Application).Namespace(17).ParseName(\"E:\").InvokeVerb(\"Eject\")
	Return

#+Enter:: 
	Send {Escape}
	Send ^l	
	Send powershell -NoLogo{Enter}
	Return


~RButton & LButton Up::  
MouseClick, Middle
Return

~LButton & RButton Up::  
MouseClick, Middle
Return

Browser_Forward::^#Right
Browser_Back::^#Left



#IfWinActive Anki - Oscar
`::
    Send ^z
    Return 
#IfWinActive

#IfWinActive Windows PowerShell
:*:sudo::
    Send Start-Process Powershell -Verb runAs {Enter}
    Return

#IfWinActive

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





#a::
    Run "C:\Program Files (x86)\Anki\anki.exe"
    Return


#q::
    Send !{F4}
    Return


#IfWinActive Windows PowerShell
#q::
    Send exit{enter}
    Return 
#IfWinActive


#x:: ;Shut it down!
    Msgbox, 36, Shutdown, Shutdown computer?
    IfMsgbox Yes
        Run, shutdown.exe /s /hybrid /t 1
	Return

#c:: 
    Run, notepad C:\Windows\shortcuts.ahk
    Return


#s:: 
    Run, "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" C:\Windows\shortcuts.ahk
    Return


#f:: 
    Run, firefox
    Return


#1:: ;Shut it down!
    Msgbox,  Firefox `n Anki `n oneNote `n Word `n Quit `n Config `n Source `n intelliJ `n Mail `n <br>alt Powershell `n BlackBoard `n /search


#b:: ;BlackBoard
    Run, https://miscursos.tec.mx/ultra/stream
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
#h:: ;Open home folder
	
	Run, explorer.exe C:\Users\X220\Desktop\TEC\DOCS\TEC\PROGRAMMING\SEM2
	Return

#+h:: ;prepare a git env
	Run, powershell.exe -noexit -NoLogo -command "cd C:\Users\X220\Desktop\TEC\DOCS;git status"
	Return