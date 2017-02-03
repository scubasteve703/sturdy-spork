function Get-Headers ($path)
{
    $header = Get-Content $path |select -first 1

    return $header
}

Get-Headers $path