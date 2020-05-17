Import-Module Get-ChildItemColor
Set-Alias ls Get-ChildItemColor -Option AllScope
Set-Alias l Get-ChildItemColorFormatWide -Option AllScope


function chocolist{ choco list --local-only --all-versions | less }

Set-Alias clist chocolist 

Set-Alias e explorerhere -Option AllScope

Set-Alias g git

Set-Alias v nvim

Set-Alias vim nvim

Set-Alias a adb

Set-Alias j java

Set-Alias dk docker

Set-Alias jc javac

Set-Alias rn Rename-Item

function explorerhere{ ii ..}
Set-Alias e explorerhere -Option AllScope

function vindex{ vim index.adoc}
Set-Alias vin vindex -Option AllScope

function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

function cddocs{ Set-Location ~/Documents }
Set-Alias docs cddocs -Option AllScope

function gitAdd {git add *}
Set-Alias gia gitAdd -Option AllScope

function gitStatus {git status}
Set-Alias gis gitStatus -Option AllScope

function gitCommit {git commit}
Set-Alias gic gitCommit -Option AllScope

function gitAmmend {git commit --amend}
Set-Alias giam gitAmmend -Option AllScope

function gitPush {git push}
Set-Alias gip gitPush -Option AllScope

function cdtoDesktop { Set-Location ~/Desktop}
Set-Alias D cdtoDesktop -Option AllScope

function cdtoTEC { Set-Location ~/Desktop/TEC }
Set-Alias cdtec cdtoTEC -Option AllScope

function doubleCD{ Set-Location ../../}
Set-Alias cd...  doubleCD -Option AllScope

function tripleCD{ Set-Location /../../../}
Set-Alias cd....  tripleCD -Option AllScope
