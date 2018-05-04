
#Read from CSV
Import-Csv D:\GithubProj\PowerShellWG\meetup\VM-Input.csv |`
    ForEach-Object {
        
        
        Write-Host $_.VMName, $_.RGName, $_.Location

        #call another PowerShell
        $ScriptToRun = $PSScriptRoot+"\CreateVM-parameter.ps1" + " -VMName " + $_.VMName + " -RGName " + $_.RGName + " -Location " +$_.Location
        
        Invoke-Expression $ScriptToRun
    }