#contorller script
param($filename,$marketer)
$path = $env:USERPROFILE + "\downloads\"+ $filename

do{
$header = .\Get-Headers.ps1
}
until ($header)

Try{
if ($header -eq "person_id,salutation,firstname,mi,lastname,title,company,address1,address2,address3,city,state,zip,country,keycode,phone,d_phone,fax,d_fax,p_fax,email,department,dear")
    {
        write-host 'Mist'
        Invoke-Expression -Command .\format-mist.ps1
        }

    Elseif ($header -eq "Link,Email,Click Count,First Name,Last Name,state,company,city,phone,country,title,keycode,Salutation,TAG,Unsubscribe from All")
            {
                Write-host 'Clickthrough'
                Invoke-Expression -Command .\format-clickthroughs.ps1
                }
}
Finally
    {
        Write-Output 'Headers do not match. New list type?'

        }
    
