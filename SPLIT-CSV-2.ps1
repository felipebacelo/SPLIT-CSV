$InputFilename=Get-Content 'C:\Users\Data\filename.csv'

$OutputFilenamePattern='filename-split-'

$LineLimit=100

$line=0

$i=0

$file=0

$start=0

    while($line -le $InputFilename.Length) {
        if($i -eq $LineLimit -Or $line -eq $InputFilename.Length) {
            $file++
            $Filename = "$OutputFilenamePattern$file.csv"
            $InputFilename[$start..($line-1)] | Out-File $Filename -Force
            $start = $line;
            $i=0
            Write-Host "$Filename"
         }
        $i++;
        $line++
    }