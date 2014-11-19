function delninja
{
    $name = $args[0]
    $port = $args[1]
    $location = $args[2]
    Write-Host ('removing {0}' -f $name)

    Remove-PrinterPort -Name $name *> $null
    Remove-Printer -Name $name *> $null
}

Add-PrinterDriver -Name 'HP LaserJet 9050 PS Class Driver'

$content = Get-Content printers.conf
$search = $args[0]

if ($search -eq $null) {
    $search = ''
}

foreach ($line in $content) {
    $arr = $line -split '\s+', 3
    $printername = $arr[0]
    $printerport = $arr[1]
    $printerloc = $arr[2]

    if ($printername.ToLower().StartsWith($search.ToLower())) {
        delninja $printername $printerport $printerloc
    }
}
