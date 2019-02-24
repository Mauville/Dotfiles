New-Item -Path C:Windows\shortcuts.ahk -ItemType HardLink -Value .\shortcuts.ahk
New-Item -Path %USERNAME\.ideavimrc -ItemType HardLink -Value .\.ideavimrc
New-Item -Path %USERNAME\_vimrc -ItemType HardLink -Value .\_vimrc
