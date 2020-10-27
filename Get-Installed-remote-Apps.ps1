## Here just create a txt list of your hostnames, or IP's, then name it PCs.txt, or if you have your own name, 
##change it to match below.
$PCs = Get-Item -Path .\PCs.txt 
## I wrote this for an environment with Windows 7 and Windows 10 PCs, this will work for either.
## Change "Domain" to match your domain. 
##First line attempts to force WSMan to allow PSSessions and enable WinRM so you can access Registry or WMI.
Foreach($PC in $PCs){Set-Item wsman:\$._\client\trustedhosts * | Enter-PSSession -ComputerName $._ -Credential $env:USERNAME\Domain | Invoke-Command .\winrm.exe -ArgumentList /quickconfig:Y:}
ForEach($PC in $PCs){Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Export-CSV -NoTypeInformation -Path .\PCapplist.csv}
ForEach($PC in $PCs){Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Export-CSV -NoTypeInformation -Path .\PCapplist.csv}
Foreach($PC in $PCs){Get-WmiObject -ComputerName $._ -Class Win32_Computersystem | Select-Object Name | Export-Csv -Path .\PCapplist.csv -Append -force}