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

^#g:: ;Searches on Google
	prevclip=%clipboard%
	address= http://www.google.com/search?q=
	Send ^c
	query=%clipboard%
	fulladd=%address%%query%
	Run, %fulladd%
	clipboard:=prevclip
	Return
^#w:: ;Searches on Google
	prevclip=%clipboard%
	address= https://en.wiktionary.org/wiki/
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

#d:: ;Calc
	Run, calc.exe
	Return

#w:: ;Word
	Run, "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"
	Return

#m:: ; Thunderbird
	Run, "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
	Return

#j:: ;Intellij
	Run, "C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2018.2.6\bin\idea64.exe"
	Return
	
#n:: ; OneNote
	Run, "C:\Program Files (x86)\Microsoft Office\root\Office16\ONENOTE.EXE"
	Return

#Enter:: ;cmd
	Run, "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" 
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
	Send powershell{Enter}
	Return

~LButton & RButton::MouseClick, Middle
~RButton & LButton::MouseClick, Middle

Browser_Forward::^#Right
Browser_Back::^#Left

#IfWinActive Anki - Oscar
`::
    Send ^z
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

$Backspace::
    SoundPlay, %A_WinDir%\Media\Windows Background.wav
    Return

$^Backspace::
    SoundPlay, %A_WinDir%\Media\Windows Background.wav
    Return

$+Backspace::
    SoundPlay, %A_WinDir%\Media\Windows Background.wav
    Return
#a::
    Run "C:\Program Files (x86)\Anki\anki.exe"
    Return

#q::
    Send !{F4}
    Return

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
