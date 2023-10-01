@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
REM BFCPEICON=C:\Users\Learn\Downloads\nature-icon-37198-Windows.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=1
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=AutoSwitchDarkLight
REM BFCPEVERDESC=A simple theme switch tool
REM BFCPEVERCOMPANY=红头Lee
REM BFCPEVERCOPYRIGHT=LeonYew
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=25
REM BFCPEWINDOWWIDTH=80
REM BFCPEWTITLE=AutoSwitchDarkLight
REM BFCPEOPTIONEND

REM Set Static Rise&Set Time
set "sunrise=8"
set "sunset=18"

REM Get Current Time (Only the first 2 digits.)
set "now=%time:~0,2%"

REM Output Parameters
echo %now% , %sunrise% , %sunset%

REM Compare Current Time With Rise&Set Time.
if %now% GEQ %sunrise% (
    REM 8——24 o'clock
    if %now% LSS %sunset% (
        REM 8——18 o'clock
        echo 白天！
        Call :LightMode
    ) else (
        REM 18——24 o'clock
        echo 晚上！
        Call :DarkMode
    )
) else (
    REM 0——8 o'clock
    echo 凌晨！
    Call :DarkMode
)

Call :ReloadExplorer

echo 切换完成！
goto :eof


REM Reload Explorer
:ReloadExplorer
taskkill /f /im explorer.exe
start explorer.exe
goto:eof

REM Turn On Light Mode
:LightMode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
echo 已切换到Light Mode.
goto:eof

REM Turn On Dark Mode
:DarkMode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
echo 已切换到Dark Mode.
goto:eof

EXIT
                              