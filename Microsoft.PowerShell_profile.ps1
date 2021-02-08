Import-Module Get-ChildItemColor
Set-Alias ls Get-ChildItemColor -Option AllScope
Set-Alias l Get-ChildItemColorFormatWide -Option AllScope

function chocolist{ choco list --local-only --all-versions | less }

Set-Alias clist chocolist

Set-Alias e explorerhere -Option AllScope

Set-Alias g git

Set-Alias v nvim

Set-Alias vi nvim

Set-Alias vim nvim

Set-Alias a adb

Set-Alias j java

Set-Alias dk docker

Set-Alias jc javac

Set-Alias rn Rename-Item

function ffind($glob){ ls -r -inc $glob }

function sshtec{ssh A1657110@murillo.qro.itesm.mx}
Set-Alias murillo sshtec

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

function gitPushPush {git push;git ftp push}
Set-Alias gipp gitPushPush -Option AllScope

function adoc($Files){ asciidoctor-latex -b html -r asciidoctor-diagram $Files}

function compileAll { ls -r -inc *.adoc | adoc }

Set-Alias recadoc compileAll -Option AllScope

function cdtoDesktop { Set-Location ~/Desktop}
Set-Alias D cdtoDesktop -Option AllScope

function cdtoHP { Set-Location ~/Desktop/Tec/HP}
Set-Alias hp cdtoHP -Option AllScope

function cdtoTEC { Set-Location ~/Desktop/TEC }
Set-Alias cdtec cdtoTEC -Option AllScope

function doubleCD{ Set-Location ../../}
Set-Alias cd...  doubleCD -Option AllScope

function tripleCD{ Set-Location /../../../}
Set-Alias cd....  tripleCD -Option AllScope

function adoc2docx{
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true,
                HelpMessage=".adoc file to convert")]
    [string]$INPUT_ADOC
    )
    PROCESS {
    asciidoctor --backend docbook --out-file - $INPUT_ADOC | pandoc --from docbook --to docx --output $INPUT_ADOC.docx
    }
}
