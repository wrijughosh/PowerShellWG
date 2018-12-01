#Download All Ignite 2018 Videos 
# Data and AI
# https://www.youtube.com/watch?v=gLdi3iwp0WU&list=PLQXpv_NQsPIDcHZJu7B1mzZedq9DlIeKa

#Infrastructure in Azure
#https://www.youtube.com/watch?v=oClYveF6x4c&list=PLQXpv_NQsPIAUAtjYJ6Q61JdM2PkmrtxZ

#IOT
#https://www.youtube.com/watch?v=UdnnRnrgm-E&list=PLQXpv_NQsPIDAvshH3mpIDvYmvQON6ziO

$playlistURL = "https://www.youtube.com/watch?v=UdnnRnrgm-E&list=PLQXpv_NQsPIDAvshH3mpIDvYmvQON6ziO"
$file = "msignite2018.csv"

$playlist= (invoke-WebRequest -uri $Playlisturl).Links | ? {$_.HREF -like "/watch*"} | `
? innerText -notmatch ".[0-9]:[0-9]." | ? {$_.innerText.Length -gt 3} | Select innerText, `
@{Name="URL";Expression={'http://www.youtube.com' + $_.href}} | ? innerText -notlike "*Play all*"

$arrURLs = @()

ForEach ($video in $playlist) {

    #HTML Link
    $title = $video.innerText.Replace("Microsoft Ignite","").Trim() #Cleanup
    $obj = New-Object PSObject
    $obj | Add-Member NoteProperty Title $title
    $obj | Add-Member NoteProperty URL $video.URL

    $arrURLs += $obj    
}

#Write to CSV
$arrURLs | Export-Csv -Path $file -NoTypeInformation -Force
Invoke-Item $file #to Open
Write-Host "Complete writing to the file " $file

