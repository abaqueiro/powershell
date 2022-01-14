<#
.SYNOPSIS
Says hello to anyone who runs this script

.DESCRIPTION
The e001-hello-help prints out hello, how are you to the screen

.PARAMETER name
Specifies the name of the person running the scritp

.INPUTS
None

.OUTPUTS
Writes two string objects to the output

.EXAMPLE
.\e001-hello-help.ps1

.EXAMPLE
.\e001-hello-help.ps1 -Name Poncho

#>
<#
    reference about parameters in powershell
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2
#>
param (
    [Parameter(Position=0)] # Position=0 makes the -name optional
    [string]
    $name
)
write-host "hola $name" -nonewline # comment until end of line, look PS replaces variable value in the string
<#
    comment block
    come in this flavor
    they can have as many lines as you want
#>
write-host ", how are you today?"
