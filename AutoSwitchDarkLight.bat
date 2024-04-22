@ECHO OFF

:: Set Static Rise&Set Time
set "sunrise=8"
set "sunset=18"

:: Get Current Time (Only the first 2 digits.)
set "now=%time:~0,2%"

:: Output Parameters
echo %now% , %sunrise% , %sunset%

:: Compare Current Time With Rise&Set Time.
if %now% GEQ %sunrise% (
    :: 8——24 o'clock
    if %now% LSS %sunset% (
        :: 8——18 o'clock
        echo 白天！
        Call :LightMode
    ) else (
        :: 18——24 o'clock
        echo 晚上！
        Call :DarkMode
    )
) else (
    :: 0——8 o'clock
    echo 凌晨！
    Call :DarkMode
)

:: Prompt user to restart Explorer
msg * 提示：是否继续执行操作？
set /p choice=请输入选项（Y/N）：
if /i "%choice%"=="Y" (
    call :execute_function
) else (
    echo 用户取消了操作。
)


echo 切换完成！
goto :eof


:: Reload Explorer
:ReloadExplorer
taskkill /f /im explorer.exe
start explorer.exe
goto:eof

:: Turn On Light Mode
:LightMode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
echo 已切换到Light Mode.
goto:eof

:: Turn On Dark Mode
:DarkMode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
echo 已切换到Dark Mode.
goto:eof

EXIT
                              