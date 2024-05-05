Clear-Host
Write-Host 'This program is a demostration of running and interact with a process' -ForegroundColor Cyan
Write-Host 'using powershell' -ForegroundColor Cyan
Write-Host ''
Write-Host 'You have to choose between 3 modes of operation:'
Write-Host '1 - normal ping command'
Write-Host '2 - Ping non existend domain'
Write-Host '3 - Incorrect command'
Write-Host ''

$ps_info = New-Object System.Diagnostics.ProcessStartInfo
$ps_info.FileName = "ping"
$ps_info.Arguments = "8.8.8.8"
$ps_info.UseShellExecute = $false
$ps_info.CreateNoWindow = $true
$ps_info.RedirectStandardOutput = $true
$ps_info.RedirectStandardError = $true

$mode = Read-Host -Prompt 'Type the number of the mode you want to test'
switch -Exact ($mode){
    1 { Break }
    2 {
        $ps_info.Arguments = "googlita.com"
        Break 
    }
    3 {
        $ps_info.FileName = "pinga"
        Break
    }
    Default {
        Write-Host -f Red "Incorrect selection: $mode"
        Return
    }
}

Write-Host "OK, working in mode mode #$mode"

$ps = New-Object System.Diagnostics.Process
$ps.StartInfo = $ps_info
$started = $false
try {
    $r = $ps.Start()
    $started = $true
} catch {
    $ex = $_
    Write-Host "ERROR starting process:"$ex.Exception.Message
}
if ( $started -eq $true ){
    Write-Host -NoNewline "Process running "
    # wait for process to exit
    while ( $ps.HasExited -eq $false ){
        Start-Sleep -Seconds 1
        Write-Host -NoNewline "."
    }
    Write-Host ""
    Write-Host "Process finished."

    $std_out = $ps.StandardOutput.ReadToEnd()
    $std_err = $ps.StandardError.ReadToEnd()
    Write-Host ''
    Write-Host -NoNewline "ExitCode: " -ForegroundColor Green
    Write-Host $ps.ExitCode -for
    Write-Host ''
    Write-Host "STD_OUT ("$std_out.Length" bytes ):" -ForegroundColor Yellow
    Write-Host $std_out
    Write-Host "STD_ERR ("$std_err.Length" bytes ):" -ForegroundColor Yellow
    Write-Host $std_err
    Write-Host '================='
}