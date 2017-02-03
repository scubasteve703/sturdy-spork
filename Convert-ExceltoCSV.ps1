Function ExportWSToCSV ($excelFileName, $csvLoc)
{
    $excelFile = "C:\users\sbrennan\downloads\" + $excelFileName + ".xlsx"
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $wb = $E.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $n = $excelFileName + "_" + $ws.Name
        $ws.SaveAs($csvLoc + $n + ".csv", 6)
    }
    $E.Quit()
    Stop-Process -Name excel
}
#ExportWSToCSV -excelFileName "file" -csvLoc "C:\users\sbrennan\downloads\"
