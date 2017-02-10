Function Format-BR ($excelFileName)
{
    $date = get-date (get-date).AddDays(-1) -UFormat "%m%d"
    $excelFile = "$excelFilename" #"C:\users\sbrennan\downloads\" + $excelFileName + ".xls"
    $excel = New-Object -ComObject Excel.Application
    $workbook = $excel.workbooks.open($excelFile)
    $excel.visible = $true # switch to make excel visible 
    #$excel.Visible = $false # switch to make excel invisible
    $excel.DisplayAlerts = $false
    $worksheet = $workbook.sheets.Item($Filename.TrimEnd(".csv"))
    $worksheet.Range("A1:P1").cells.delete()
    $lastrow = $worksheet.usedRange.Rows.Count
    $worksheet.Range("A1:A1").cells="Home Address 1"
    $worksheet.Range("M1:M1").cells="Phone"
    $worksheet.Range("N1:N1").cells="Fax Phone"
    $worksheet.Range("Q1:Q1").Cells="contact"
    $worksheet.Range("Q2:Q" + $lastrow).Cells="=b2&"" ""&c2"
    $worksheet.Range("R1:R1").cells="Personal Email"
    $worksheet.Range("R2:R" + $lastrow).Cells="x"
    #$worksheet.Range("C2:C"+$lastrow).Sort($worksheet.Range("c2:C" + $lastrow)) #not working at this time, only sorts the row does not expand the selection
    $worksheet.Range("A2:R"+$lastrow).Sort($worksheet.Range("c2:C" + $lastrow)) #this sorts correctly, almost had it right the first time!
    $worksheet.SaveAs("\\wccldfps\sbrennan\act lists\Brochure Requests\WCR BR"+" "+$date+".csv", 6)
    #$excel.quit() # we don't want to actually quit out of excel yet becuase we need to check for duplicates and note them down. Eventually it would be nice to solve this
   
}
Format-BR -excelFileName $path