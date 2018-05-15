
#Download All Build Videos 
$playlistURL = "https://www.youtube.com/watch?v=G9615XmUfas&list=PLlrxD0HtieHg7uB3_amVXvaRgxIcXLtYD"
$file = "url-list.csv"

$playlist = ((Invoke-WebRequest $playlistURL).Links | Where {$_.class -match "playlist-video"}).href 

$arrURLs = @()

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

