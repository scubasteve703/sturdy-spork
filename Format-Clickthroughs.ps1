
$excluded = 'Times Clicked','Keycode','Salutation','TAG','Links Clicked','link','click count','unsubscribe from all','Opened Count','Unsubscribe from All '#,'mi','dear','department','fax','p_fax','person_id','phone','d_phone','d_fax'

#$folder = "c:\users\sbrennan\downloads\"
#$filename = Read-Host -Prompt "enter filename"
#$marketer = Read-host -Prompt "enter name of marketer"
#$path = $folder + $filename
$outpath= "\\wccldfps\sbrennan\act lists\"+$marketer +"\"+$filename


Get-Content $path |select -First 1 |%{$header = $_.split(',')}

$patternA = $header -match '(first)\s?\w?(name)\w?' |New-Variable firstname
$patternB = $header -match '(last)\s?\w?(name)\w?' |New-Variable lastname

if($header -match '(links)\s?\w?(clicked)\s?\w?'){
    import-csv $path |select *,@{expression={$_.$firstname +" "+$_.$lastname};label='Contact'},@{expression={'x'};label='Personal Email'},@{expression={$_.'Links Clicked'};label='Email'} -ExcludeProperty $excluded |Export-Csv $outpath -NoTypeInformation
      }
      else{

        import-csv $path |select *,@{expression={$_.$firstname +" "+$_.$lastname};label='Contact'},@{expression={'x'};label='Personal Email'}<#,@{expression={$_.person_id};label='Messenger ID'},@{expression={$_.phone};label='Main Number'},@{expression={$_.d_phone};label='Phone'},@{expression={$_.d_fax};label='Fax'}#> -ExcludeProperty $excluded |Export-Csv $outpath -NoTypeInformation
             }

Remove-Variable firstname
Remove-Variable lastname

ii $outpath

