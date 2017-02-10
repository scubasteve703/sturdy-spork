#contorller script
param($filename,$marketer)
$path = $env:USERPROFILE + "\downloads\"+ $filename

if ($filename -match  '[a-zA-Z]+(.xls)'){
    Do{
    $filename =  .\Convert-ExceltoCSV.ps1
    }
    Until($filename)
    $path = $env:USERPROFILE + "\downloads\"+ $filename

   
}

do{
$header = .\Get-Headers.ps1
}
until ($header)
Try{
if ($header -eq "person_id,salutation,firstname,mi,lastname,title,company,address1,address2,address3,city,state,zip,country,keycode,phone,d_phone,fax,d_fax,p_fax,email,department,dear")
    {
        Invoke-Expression -Command .\format-mist.ps1
        }

    Elseif ($header -eq "Link,Email,Click Count,First Name,Last Name,state,company,city,phone,country,title,keycode,Salutation,TAG,Unsubscribe from All")
            {
                Invoke-Expression -Command .\format-clickthroughs.ps1
                }

                Elseif ($header -eq "Links Clicked,Times Clicked,First Name,Last Name,state,company,city,phone,country,title,keycode,Salutation,TAG")
                    {
                        Invoke-Expression -Command .\Format-Clickthroughs.ps1
                        }

                        Elseif ($header -eq "Link,Email,Opened Count,First Name,Last Name,state,company,city,phone,country,title,keycode,Salutation,TAG,Unsubscribe from All ")
                            {
                                Invoke-Expression -Command .\Format-Clickthroughs.ps1
                                }

                                Elseif ($header -match "(World Congress Brochure Inquiries for ACT - )[0-9](\/)[0-9]\2[0-9]{4}( - )[0-9]\2[0-9]\2[0-9]{4},,,,,,,,,,,,,,,")
                                    {
                       
                                        Invoke-Expression -Command .\Format-BR.ps1
                        
                                        }

                                        Elseif ($header -eq "REG_ID,SALUTATION,FIRSTNAME,MIDDLENAME,LASTNAME,TITLE,COMPANY,ADDRESS1,ADDRESS2,ADDRESS3,DEPARTMENT,CITY,STATE,ZIP,COUNTRY,PHONE,D_PHONE,PHONEEXT,FAX,D_FAX,EMAIL,PERSON_ID,DEAR,TICKETTYPE,TICKETSUBT,AMTPD,AMTDUE,TRANSFER,HASBADGE,GUESTS,HOSTREG_ID,KEYCODE,SALE_ID,CONF_ID,CREATED,CREATEDBY,CANCELLED,NOSHOW,PNS,PROD1,PROD2,PROD3,PROD4,PROD5,REG_ID_A,NOT_USED,WRK0A,WRK0B,WRK0C,WRK0Z")
                                            {
                                                Invoke-Expression -Command .\Format-AltMist.ps1

                                                }

}

Finally
    {
        Write-Output 'Headers do not match. New list type?'
        Write-Output $header
        }
    
