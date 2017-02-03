$csv=""
$folder = "c:\users\sbrennan\downloads\"
$filename = Read-Host -Prompt "enter filename:"
#$producer = Read-host -Prompt "enter name of producer:"
$path = $folder + $filename
$date = get-date (get-date).AddDays(-1) -UFormat "%m%d"
$outpath= "\\wccldfps\sbrennan\act lists\Brochure Requests\WCR BR"+" "+$date+".csv"
$csv = import-csv -path $path
$csv |
Select-Object *, `
@{expression={$_.'Conference Code'};label='Home Address 1'},`
@{expression={$_.'Direct Phone'};label='Phone'},`
@{expression={$_.'Direct Fax'};label='fax'},`
@{expression={$_.'First Name' +' '+$_.'Last Name'};label='contact'},`
@{expression={'x'};label='personal email'}`
-ExcludeProperty 'conference code', 'direct phone', 'direct fax',date |
Sort-Object -Property 'last name' |
Export-Csv -Path $outpath -NoTypeInformation
$csv.count
ii $outpath