<#
Example of powershell using .NET classes to build a GUI
#>
[reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

$frm = New-Object Windows.Forms.Form

$frm.text="my bofi"
$frm.left=0
$frm.top=30
$frm.width=600
$frm.height=480

$top = 0

$lbl1 = New-Object Windows.Forms.Label
$lbl1.top = $top
$lbl1.width = 200
$lbl1.text = "What is your name?"
$frm.controls.add($lbl1)
$top += $lbl1.height + 4

$txt1 = New-Object Windows.Forms.Textbox
$txt1.top = $top
$txt1.width = 200
$frm.controls.add($txt1)
$top += $txt1.height + 4

$btn1 = New-Object Windows.Forms.Button
$btn1.top = $top
$btn1.text = "Push Me"
$frm.controls.add($btn1)
$top += $btn1.height + 4

$lbl2 = New-Object Windows.Forms.Label
$lbl2.top = $top
$lbl2.width = 400
$lbl2.text = "Hello"
$frm.controls.add($lbl2)
$top += $lbl2.height + 4

$btn1.add_click({
    $now = [DateTime]::get_Now().ToString("yyy-MM-dd HH:mm:ss")
    $name = $txt1.text
    $lbl2.text = "Hola $name, the time is $now"
})

$frm.ShowDialog()
