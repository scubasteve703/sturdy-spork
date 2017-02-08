 $outpath= "\\wccldfps\sbrennan\act lists\"+$marketer +"\"+$filename
 $columns=(get-content "c:\users\sbrennan\documents\format-list\schema\AltMist.txt").split(",")
            $csv = import-csv -path $path |select $columns|select *,@{expression={$_.phone};label='main number'},`
            @{expression={$_.D_Phone};label='phone number'},@{expression={$_.d_fax};label='Fax'},`
            @{expression={$_.person_ID};label='person ID'},@{expression={$_.keycode};label='messenger id'},`
            @{expression={$_.firstname + ' ' +$_.lastname};label='contact'},@{expression={'x'};label='personal email'}`
            -ExcludeProperty phone,d_phone,d_fax,person_id,keycode|Export-Csv $outpath -NoTypeInformation