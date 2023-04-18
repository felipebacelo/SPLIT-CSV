function Split-CSV{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string]$FilePath,
        [Parameter()]
        [string]$Delimiter=',',
        [Parameter(Mandatory)]
        [string]$TargetFolder,
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [int]$NumberOfFiles
    )

    try{
        if(-not (Test-Path $TargetFolder)){
            New-Item -Path $TargetFolder -ItemType Directory
        }

        $csvData=Import-Csv -Path $FilePath -Delimiter $Delimiter

        $startRow=0

        $numberOfRowsPerFile=[Math]::Ceiling($csvData.count/$NumberOfFiles)

        $counter=1

        while($startRow -lt $csvData.Count){
            $csvData | Select-Object -Skip $startRow -First $numberOfRowsPerFile | Export-Csv -Path "$TargetFolder\$Name-$counter.csv" -NoTypeInformation -NoClobber
            $startRow+=$numberOfRowsPerFile
            $counter++
        }
    }catch{
        Write-Error $_.Exception.Message
    }
}

Split-CSV -FilePath "C:\Users\Data\filename.csv" -Delimiter ',' -TargetFolder "C:\Users\Data" -Name "filename-split" -NumberOfFiles 10