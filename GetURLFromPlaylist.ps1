
#Download All Build Videos 
$playlistURL = "https://www.youtube.com/watch?v=G9615XmUfas&list=PLlrxD0HtieHg7uB3_amVXvaRgxIcXLtYD"
$file = "url-list.csv"

$playlist = ((Invoke-WebRequest $playlistURL).Links | Where {$_.class -match "playlist-video"}).href 

$arrURLs = @()
#$arrURLs = "URL"
ForEach ($video in $Playlist) {

	$s = "https://www.youtube.com"+ $video
    $s = $s.Substring(0, $s.IndexOf('&'))
    
    #$arrURLs.Add($s)
    $obj = New-Object PSObject
    $obj | Add-Member NoteProperty URL $s

    $arrURLs += $obj
    
    #Write-Output($s) 
}

#Write to CSV
$arrURLs | Export-Csv -Path $file -NoTypeInformation -Force
#Invoke-Item $file #to Open
Write-Host "Complete writing to the file " $file

<#Then read from the Same CSV to download those URLs

To Download we can use 
https://rg3.github.io/youtube-dl/download.html

Simple commad would be 

Let's say you have downloaded it to C:\Downloads\youtube-dl.exe
Then the command would look like, 

> youtube-dl.exe "https://www.youtube.com/watch?v=t1iaFY66bDY"
#>

#PART 2: Read from CSV and download...
$ydlPath = "C:\users\blahblah\downloads\youtube-dl.exe"
Import-Csv $file | ForEach-Object {      
    $script = $ydlPath + " " + $_.URL
    Invoke-Expression $script
    Write-Host $script
}


