Import-Module Get-ChildItemColor
Import-Module cd-extras
Import-Module posh-git

function adoc($Files){ asciidoctor-latex -b html -r asciidoctor-diagram $Files}
function cddocs{ Set-Location ~/Documents }
function cdtoDesktop { Set-Location ~/Desktop}
function cdtoHP { Set-Location ~/Desktop/Tec/HP}
function cdtoOS { Set-Location ~/Desktop/Tec/HP/NET/OSCP}
function cdtoTEC { Set-Location ~/Desktop/TEC }
function chocolist{ choco list }
function cuserprofile { Set-Location ~ }
function explorerhere{ ii .}
function ffind($glob){ Get-ChildItem -Path . -Filter $glob -Recurse -ErrorAction SilentlyContinue -Force}
function gitAdd {git add *}
function gitAmmend {git commit --amend}
function gitCommit {git commit}
function gitPush {git push}
function gitPushPush {git push;git ftp push}
function gitStatus {git status}
function mchangedir($dir){ md $dir ; cd $dir}
function vindex{ vim index.adoc}
function lsa{ lsd -la}

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

function chime{
[CmdletBinding()]
param (
    [Parameter( HelpMessage=".adoc file to init")]
    [string]$INPUT_ADOC
    )
    PROCESS{
    if (Test-Path -Path ./index.adoc){
        Write-Error "index.adoc files exists!"
        return
    }
   $content = "= <++>
:toc: left
:toclevels: 4
:toc-title: Index
:sectnums:
:imagesdir: imagesdir\"
    md imagesdir
    Add-Content index.adoc $content
    vim ./index.adoc
   }
}

function mcd{
[CmdletBinding()]
param (
    [Parameter( HelpMessage="md and cd a dir")]
    [string]$dir
    )
    PROCESS{
        md $dir;
        cd $dir;
    }
    }

Set-Alias D cdtoDesktop -Option AllScope
Set-Alias adocinit chime
Set-Alias apt choco
Set-Alias cdtec cdtoTEC -Option AllScope
Set-Alias clist chocolist
Set-Alias dk docker
Set-Alias docs cddocs -Option AllScope
Set-Alias e explorerhere -Option AllScope
Set-Alias g git
Set-Alias gia gitAdd -Option AllScope
Set-Alias giam gitAmmend -Option AllScope
Set-Alias gic gitCommit -Option AllScope
Set-Alias gip gitPush -Option AllScope
Set-Alias gipp gitPushPush -Option AllScope
Set-Alias gis gitStatus -Option AllScope
Set-Alias hp cdtoHP -Option AllScope
Set-Alias os cdtoOS -Option AllScope
Set-Alias j java
Set-Alias jc javac
# Set-Alias l Get-ChildItemColorFormatWide -Option AllScope
# Set-Alias ls Get-ChildItemColor -Option AllScope
Set-Alias recadoc compileAll -Option AllScope
Set-Alias rn Rename-Item
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias nvim nvam
Set-Alias vin vindex -Option AllScope
Set-Alias ~ cuserprofile -Option AllScope
Set-Alias gclip Get-Clipboard
Set-Alias ls lsd -Option AllScope
function ldFunction { Get-ChildItem -Directory}
function lrFunction {lsd.exe -R}

Set-Alias ld ldFunction
Set-Alias lr lrFunction

function nvam{
[CmdletBinding()]
param (
    [Parameter( HelpMessage="md and cd a dir")]
    [string]$file
    )
    PROCESS{
    $previous = [console]::title
    [console]::title = "Neovim"
    nvim.exe $file
    [console]::title = $previous
    }
}

function sudo {
    Start-Process -Verb RunAs -FilePath "pwsh" -ArgumentList (@( "-Command") + $args + "; pause")
}

Set-Variable -Name "hosts" -Value "C:\Windows\System32\drivers\etc\hosts"

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression

if(Test-Path 'C:\Users\X1Carbon\.inshellisense\key-bindings-pwsh.ps1' -PathType Leaf){. C:\Users\X1Carbon\.inshellisense\key-bindings-pwsh.ps1}


# A simple search function that uses es.exe and a filepicker to open files.
function Search-Everything {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Filename
  )

  # Escape wildcard characters in the filename
  $escapedFilename = $Filename.Replace('*', '`*').Replace('?', '`?')

  # Call Everything CLI and search for the file
  $results = & es.exe -sort-path-descending -highlight $escapedFilename

  if ($results) {
    Write-Host "Found $($results.Count) results."
    # Ask the user to choose a file
    # Display numbered list and use Read-Host with switch
    $i = 1
    foreach ($file in $results) {
      Write-Host -NoNewline -ForegroundColor Cyan  "($i) "
      Write-Host -ForegroundColor Blue $file
      $i++
    }

    $choice = Read-Host "Enter the number of the file you want to open:"

    switch ($choice) {
        { $_ -in 1..($results.Count) }
            {
                $escapedPath = $results[($choice - 1)].Replace(" ", "` ");
                Invoke-Item -Path "$escapedPath"
                break
            }
          default { Write-Host "Invalid choice." }
    }
  } else {
    # No match found
    Write-Host "Not found?"
  }
}

Set-Alias -Name s -Value Search-Everything

function Make-Hardlink {
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $LinkTo,

    [Parameter(Mandatory = $true)]
    [string]
    $LinkName
  )
    New-Item -ItemType HardLink -Name $LinkName -Value $LinkTo
}

Set-Alias -Name mkhard -Value Make-Hardlink
