$directory = "-command cd $PWD;cls"
Start-Process Powershell -Verb runAs -ArgumentList "-nologo", "-noexit", "-command cd $PWD;cls"