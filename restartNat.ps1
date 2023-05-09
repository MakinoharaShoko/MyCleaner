$wp = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-Not $wp.IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    $rawCmd = $MyInvocation.Line
    $rawArgs = $rawCmd.Substring($rawCmd.IndexOf('.ps1') + 4)
	# When run with file explorer context menu,
	# if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & 'D:\Restart-WinService.ps1'
	if ($rawCmd.StartsWith('if')) { $rawArgs = '' }
    Start-Process Powershell -Verb RunAs -ArgumentList "$PSCommandPath $rawArgs" 
}
else {
	net stop winnat
	net start winnat
}

