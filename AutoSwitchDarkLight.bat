@ECHO OFF

REM Set Static Rise&Set Time
set "sunrise=8"
set "sunset=18"

REM Get Current Time (Only the first 2 digits.)
set "now=%time:~0,2%"

REM Output Parameters
echo %now% , %sunrise% , %sunset%

REM Compare Current Time With Rise&Set Time.
if %now% GEQ %sunrise% (
    REM 8����24 o'clock
    if %now% LSS %sunset% (
        REM 8����18 o'clock
        echo ���죡
        Call :LightMode
    ) else (
        REM 18����24 o'clock
        echo ���ϣ�
        Call :DarkMode
    )
) else (
    REM 0����8 o'clock
    echo �賿��
    Call :DarkMode
)

Call :ReloadExplorer

echo �л���ɣ�
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
echo ���л���Light Mode.
goto:eof

REM Turn On Dark Mode
:DarkMode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
echo ���л���Dark Mode.
goto:eof

EXIT
                              