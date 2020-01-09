param(
    [switch]$silent = $false
)

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    Write-Host "You are not running as privileged user. Please get some permissions and come back then."-BackgroundColor Black -ForegroundColor Magenta
    exit
}

if ($silent -eq $false){

$message  = 'This will create hard links to the dotfiles in the system. You need only pull from the repo to update the files this way. This will overwrite any _vimrc, .ideavim, powershell profiles, ADOC stylesheets and shortcuts.ahk files.'
$question = 'Are you sure you want to proceed?'

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

$decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)

}
else {
$decision = 0

}




if ($decision -eq 0) {
# check if AHK is running
$AutoHotKey = Get-Process autohotkey -ErrorAction SilentlyContinue
$AHK_EXISTS = 0

if ($AutoHotKey) {
  $AHK_EXISTS = 1
  $AutoHotKey.CloseMainWindow()
  Sleep 2
  if (!$AutoHotKey.HasExited) {
    $AutoHotKey | Stop-Process -Force
  }
}
Remove-Variable AutoHotKey

if ($AHK_EXISTS){
rm C:\Windows\shortcuts.ahk
rm $Env:userprofile\.ideavimrc
rm $Env:userprofile\_vimrc
}

New-Item -Path C:\Windows\shortcuts.ahk -ItemType HardLink -Value .\shortcuts.ahk
New-Item -Path $Env:userprofile\.ideavimrc -ItemType HardLink -Value .\.ideavimrc
New-Item -Path $Env:userprofile\_vimrc -ItemType HardLink -Value .\_vimrc
New-Item -Path $Env:userprofile\ADOC.css -ItemType HardLink -Value .\ADOC.css
New-Item -Path $Env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -ItemType HardLink -Value .\Microsoft.PowerShell_profile.ps1

} 


else {
  Write-Host 'Exiting...'
}


