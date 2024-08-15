# This is an example of using powershell PSSessions to copy files to remote machines
# serverlist is read from a txt file
$servers = Get-Content .\servers.txt

$envs = @{
'Q'='C:\inetpub\wwwroot\site-a.qa.domain\.well-known'
'U'='C:\inetpub\wwwroot\site-a.uat.domain\.well-known'
'S'='C:\inetpub\wwwroot\site-a.stg.domain\.well-known'
}

if ( $null -eq $cred ){
    $cred = Get-Credential
}

# open sessions
if ( $null -eq $sessions ){
    $sessions = @{}
}
foreach ($server in $servers){
    # open session
    if ( $null -eq $sessions[$server] ){
        write-host "Openning session with $server ..."
        $ses = New-PSSession -ComputerName $server -Credential $cred
        $sessions[$server] = $ses
        Write-Host "[ OK ]"
    }
}

# copy file
$filePath = 'apple-app-site-association'
foreach ($server in $servers){
    write-host -ForegroundColor Yellow "$server"

    $envLetter = $server.Substring(0,1)
    $destinationDir = $envs[$envLetter]
    if ( $null -eq $destinationDir ){
        Write-Host -ForegroundColor Red "ERROR: Unable to calculate destinationDir"
        continue
    } else {
        Write-Host "Destination dir: $destinationDir"
    }
    $destinationFilePath = "$destinationDir\$filePath"
    # copy file
    Copy-Item $filePath -ToSession $sessions[ $server ] -Destination $destinationFilePath

    # show info for confirmation
    $sb = { dir "$using:destinationFilePath" }
    Invoke-Command -Session $sessions[ $server ] -ScriptBlock $sb

    Write-Host ''
}
# remove sessions
Get-PSSession | Remove-PSSession