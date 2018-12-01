#Download All Ignite 2018 Videos 
# Data and AI
# https://www.youtube.com/watch?v=gLdi3iwp0WU&list=PLQXpv_NQsPIDcHZJu7B1mzZedq9DlIeKa

$playlistURL = "https://www.youtube.com/watch?v=gLdi3iwp0WU&list=PLQXpv_NQsPIDcHZJu7B1mzZedq9DlIeKa"
$file = "url-list.csv"

<#$playlist= (invoke-WebRequest -uri $Playlisturl).Links | ? {$_.HREF -like "/watch*"} | `
? innerText -notmatch ".[0-9]:[0-9]." | ? {$_.innerText.Length -gt 3} | Select innerText, `
@{Name="URL";Expression={'http://www.youtube.com' + $_.href}} | ? innerText -notlike "*Play all*"#>

$playlist= (invoke-WebRequest -uri $Playlisturl).Links | ? {$_.HREF -like "/watch*"} | `
? innerText -notmatch ".[0-9]:[0-9]." | ? {$_.innerText.Length -gt 3} | Select innerText, `
@{Name="URL";Expression={'http://www.youtube.com' + $_.href}} | ? innerText -notlike "*Play all*"

$arrURLs = @()


ForEach ($video in $playlist) {

    #HTML Link
    $title = $video.innerText.Replace("Microsoft Ignite","").Trim()
    $obj = New-Object PSObject
    $obj | Add-Member NoteProperty Title $title
    $obj | Add-Member NoteProperty URL $video.URL

    $arrURLs += $obj

    #if ($title.Length > 10)
    {
        #$alink = $video.URL + " : " + $title
        
    }
    #$alink = "<a href='"+ $video.URL + "'>" + $video.innerText.Replace("Microsoft Ignite","").Trim() +"</a>"
    
    #Write-Host $alink
    #$video.URL + " : " + $video.innerText 
    <#Write-Host $video.innerText
    
    #>
}

#Write to CSV
$arrURLs | Export-Csv -Path $file -NoTypeInformation -Force
Invoke-Item $file #to Open
Write-Host "Complete writing to the file " $file

