# 
# https://mirror.pseudoform.org/community/os/x86_64/arch-wiki-docs-20220525-1-any.pkg.tar.zst
#

$location="C:\tempPS\usr\share\doc\arch-wiki\html\en\"

$entries=(Get-ChildItem -Path $location -File *.html -Recurse)
$entry=($entries | Select-Object Fullname,Name | Out-Gridview -Title "Arch Wiki Offline Browser" -passthru )

if ($null -ne $entry ){
    $entry
    Start-Process $entry.Fullname
}else{
    Write-Host "Nothing was selected!"
}
  