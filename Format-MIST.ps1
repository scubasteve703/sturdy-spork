$outpath= "\\wccldfps\sbrennan\act lists\"+$marketer +"\"+$filename
$columns=(get-content "c:\users\sbrennan\documents\Format-List\schema\Mist.txt").Split(",")
                   $csv = import-csv -path $path |select $columns|select *,@{expression={$_.firstname + " " + $_.lastname};label='contact'},`
                    @{expression={'x'};label='personal email'},@{expression={$_.phone};label='main number'},`
                    @{expression={$_.keycode};label='messenger id'},@{expression={$_.d_phone};label='phone number'},`
                    @{expression={$_.d_fax};label='fax'},@{expression={$_.person_id};label='person id'}`
                     -ExcludeProperty keycode,d_phone,phone,d_fax,person_id|export-csv $outpath -NoTypeInformation