Function Format-CSV {
$csv=""
$header=""
$columns=""
$outpath=""
$folder = "c:\users\sbrennan\downloads\"
$filename = Read-Host -Prompt "enter filename"
$marketer = Read-host -Prompt "enter name of marketer"
#$columns=""
$path = $folder + $filename
$outpath= "\\wccldfps\sbrennan\act lists\"+$marketer +"\"+$filename
$mistheader="person_id,salutation,firstname,mi,lastname,title,company,address1,address2,address3,city,state,zip,country,keycode,phone,d_phone,fax,d_fax,p_fax,email,department,dear"
$clickheader="MEMBERID_,DATEJOINED_,EMAILADDR_,FIRST_NAME_,LAST_NAME_,ADDRESS_1_,ADDRESS_2_,STATE_PROVINCE_,POSTAL_CODE_,PHONE_OFFICE_,COMPANY_NAME_,CITY,TITLE,FAX_,OPTINDATE_,CUSTID_,IPADDRESS_,GROUPNAME_,TIMECLICKED_,URLTEXT_,PRETTYNAME_,EMAILADDR_,MEMID,FULLNAME_"
$zoomheader="Zoom Individual ID,Last name,First name,Middle name,Salutation,Suffix,Job title,Job title hierarchy level,Job Function,Management Level,Company division name,Direct Phone Number,Email address,Person City,Person State,Person Zip,Country,Source count,Last updated date,Zoom company ID,Company name,Company domain name,Company phone number,Company Street address,Company City,Company State,Company ZIP/Postal code,Company Country,Industry label,Industry hierarchical category,Secondary industry label,Secondary industry hierarchical category,Revenue (in 000s),Revenue Range,Employees,Employees Range,SIC1,SIC2,NAICS1,NAICS2,TitleCode,Highest Level Job Function,Person Pro URL,Encrypted Email Address,Email Domain,Query Name"
$altzoomheader="Zoom Individual ID,Last name,First name,Job title,Direct Phone Number,Email address,Person City,Person State,Person Zip,Company name"
$altclicks="EMAILADDR_,FIRST_NAME_,LAST_NAME_,ADDRESS_1_,ADDRESS_2_,STATE_PROVINCE_,POSTAL_CODE_,PHONE_OFFICE_,COMPANY_NAME_,CITY,TITLE,URLTEXT_"
$altmist="REG_ID,SALUTATION,FIRSTNAME,MIDDLENAME,LASTNAME,TITLE,COMPANY,ADDRESS1,ADDRESS2,ADDRESS3,DEPARTMENT,CITY,STATE,ZIP,COUNTRY,PHONE,D_PHONE,PHONEEXT,FAX,D_FAX,EMAIL,PERSON_ID,DEAR,TICKETTYPE,TICKETSUBT,AMTPD,AMTDUE,TRANSFER,HASBADGE,GUESTS,HOSTREG_ID,KEYCODE,SALE_ID,CONF_ID,CREATED,CREATEDBY,CANCELLED,NOSHOW,PNS,PROD1,PROD2,PROD3,PROD4,PROD5,REG_ID_A,NOT_USED,WRK0A,WRK0B,WRK0C,WRK0Z"
$altmistnew="SALUTATION,FIRSTNAME,MIDDLENAME,LASTNAME,TITLE,COMPANY,ADDRESS1,ADDRESS2,ADDRESS3,CITY,STATE,ZIP,COUNTRY,PHONE,PHONEEXT,D_PHONE,FAX,D_FAX,EMAIL,TITLE_CODE,FUNCTCODE,GENDER,DEAR,SOURCECODE,NCOACODE,NCOADATE,WWWSITE,SIZE,REGION,ZONE,NITEPHONE,ALTADDR1,ALTADDR2,ALTADDR3,ALTCITY,ALTSTATE,ALTCOUNTRY,ALTZIP"
$clicknew="Link,Email,Click Count,First Name,Last Name,State,Company,City,Phone,Country,title,keycode,Salutation,TAG,Unsubscribe From All"


#determine what schema to use and do the thing
$header=(get-content $path |Select-Object -First 1)
    if ($header -eq $mistheader)
        {
            $columns=(get-content "c:\users\sbrennan\documents\Format-List\schema\Mist.txt").Split(",")
                   $csv = import-csv -path $path |select $columns|select *,@{expression={$_.firstname + " " + $_.lastname};label='contact'},`
                    @{expression={'x'};label='personal email'},@{expression={$_.phone};label='main number'},`
                    @{expression={$_.keycode};label='messenger id'},@{expression={$_.d_phone};label='phone number'},`
                    @{expression={$_.d_fax};label='fax'},@{expression={$_.person_id};label='person id'}`
                     -ExcludeProperty keycode,d_phone,phone,d_fax,person_id|export-csv $outpath -NoTypeInformation
        }


    elseif ($header -eq $clickheader)
        {
            $columns=(get-content "c:\users\sbrennan\documents\Format-List\schema\EmailClicks.txt").Split(",")
            $csv = import-csv -Path $path -Header 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24|select '4','5','6','7','8','9','10','11','12','13','14','22'|Select-Object -Skip 1 | #this is neseccary becuase the original file has duplicate headers
                    select @{expression={$_.4+" "+$_.5};label='contact'},`
                    @{expression={'x'};label='personal email'},@{expression={$_.6};label='address1'},@{expression={$_.7};label='address2'},`
                    @{expression={$_.8};label='state'},@{expression={$_.9};label='zip code'},@{expression={$_.10};label='phone'},`
                    @{expression={$_.11};label='company'},@{expression={$_.12};label='city'},@{expression={$_.13};label='title'},`
                    @{expression={$_.14};label='fax'},@{expression={$_.22};label='email'} -ExcludeProperty 1,2,4,5,6,7,8,9,10,11,12,13,14,22|
                    export-csv $outpath -NoTypeInformation

        }


    elseif ($header -eq $zoomheader)
        {
            $columns=(get-content "c:\users\sbrennan\documents\Format-List\schema\ZoomInfo.txt").split(",")
            $csv = import-csv -path $path -header 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46 |
                    select '2','3','7','12','13','21','23','24','25','26','27','28'|select -skip 1|select '2','3','13','21',@{expression={$_.3 +" " + $_.2};label='contact'},`
                    @{expression={'x'};label='personal email'},@{expression={$_.7};label='title'},@{expression={$_.12};label='phone'},`
                    @{expression={$_.23};label='main number'},@{expression={$_.24};label='address1'},@{expression={$_.25};label='city'},`
                    @{expression={$_.26};label='state'},@{expression={$_.27};label='zip'},@{expression={$_.28};label='country'},@{expression={$_.3};label='firstname'},`
                    @{expression={$_.2};label='lastname'},@{expression={$_.13};label='email'},@{expression={$_.21};label='company'} -ExcludeProperty 2,3,7,12,13,21,23,24,25,26,27,28|
                    export-csv $outpath -NoTypeInformation
        }


    elseif ($header -eq $altzoomheader)
        {
            $columns=(get-content "c:\users\sbrennan\documents\Format-List\schema\AltZoom.txt").split(",")
            $csv = import-csv -path $path |select $columns|select *,@{expression={$_.'first name' + ' '  + $_.'last name'};label='contact'},`
                    @{expression={$_.'job title'};label='title'},@{expression={$_.'direct phone number'};label='phone'},@{expression={$_.'email address'};label='email'},`
                    @{expression={$_.'person city'};label='city'},@{expression={$_.'person state'};label='state'},@{expression={$_.'Person zip'};label='zip'},`
                    @{expression={$_.'company name'};label='company'},@{expression={'x'};label='personal email'} -ExcludeProperty 'job title', 'direct phone number','email address','person city','person state','person zip','company name'|
                    export-Csv $outpath -NoTypeInformation
        }

    elseif ($header -eq $altclicks)
        {
            $columns=(get-content "c:\users\sbrennan\documents\format-list\schema\AltClicks.txt").split(",")
            $csv = import-csv -Path $path |select $columns|select *,@{expression={$_.emailaddr_};label='email'},`
                    @{expression={$_.first_name_};label='first name'},@{expression={$_.last_name_};label='last name'},`
                    @{expression={$_.address_1_};label='address 1'}, @{expression={$_.address_2_};label='address 2'},`
                    @{expression={$_.state_province_};label='state'},@{expression={$_.postal_code_};label='zip code'},`
                    @{expression={$_.company_name_};label='company'},@{expression={$_.first_name_ + ' ' + $_.last_name_};label='contact'},`
                    @{expression={'x'};label='personal email'}, @{expression={$_.phone_office_};label='phone'} -ExcludeProperty emailaddr_,first_name_,last_name_,address_1_,address_2_,state_province_,postal_code_,phone_office_,company_name_,urltext_|
                    Export-Csv $outpath -NoTypeInformation

        }

    elseif ($header -eq $altmist)
        {
            $columns=(get-content "c:\users\sbrennan\documents\format-list\schema\AltMist.txt").split(",")
            $csv = import-csv -path $path |select $columns|select *,@{expression={$_.phone};label='main number'},`
            @{expression={$_.D_Phone};label='phone number'},@{expression={$_.d_fax};label='Fax'},`
            @{expression={$_.person_ID};label='person ID'},@{expression={$_.keycode};label='messenger id'},`
            @{expression={$_.firstname + ' ' +$_.lastname};label='contact'},@{expression={'x'};label='personal email'}`
            -ExcludeProperty phone,d_phone,d_fax,person_id,keycode|Export-Csv $outpath -NoTypeInformation
        }

    elseif ($header -eq $altmistnew)
        {
            $columns=(Get-Content "c:\users\sbrennan\documents\format-list\schema\altmistnew.txt").split(",")
            $csv = import-csv -path $path |select $columns|select *,@{expression={$_.phone};label='main number'},`
            @{expression={$_.D_Phone};label='phone number'},@{expression={$_.d_fax};label='Fax'},`
            @{expression={$_.firstname + ' ' +$_.lastname};label='contact'},@{expression={'x'};label='personal email'}`
            -ExcludeProperty phone,d_phone,d_fax,person_id,keycode|Export-Csv $outpath -NoTypeInformation
        }

    elseif ($header -eq $clicknew)
        {
            $columns=(Get-Content "c:\users\sbrennan\documents\format-list\schema\Clicksnew.txt").split(",")
            $csv= import-csv -Path $path |select $columns|select *,@{expression={$_.keycode};label='Messenger ID'},`
            @{expression={$_.'First Name' +' ' +$_.'Last Name'};label='contact'},@{expression={'x'};label='personal email'}`
            -ExcludeProperty link,keycode,'click count',salutation,tag,'unsubscribe from all' |export-csv $outpath -NoTypeInformation
        }

    else
        { write-host "No header match found! Please examine CSV file"}






#Firstname
#lastname
#address1
#address2
#address3
#city
#state
#zip 
#country
#company
#person id
#messsenger id
#email
#phone 
#main number
#fax
#contact
#personal email
}