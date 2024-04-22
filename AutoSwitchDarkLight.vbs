Dim currentHour, sunriseHour, sunsetHour
sunriseHour = 8
sunsetHour = 18
currentHour = Hour(Now)

Dim lightWallpaper, darkWallpaper, lightTheme, darkTheme,wallpaperPath
lightWallpaper = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
darkWallpaper = "C:\Windows\Web\Wallpaper\Windows\img19.jpg"
lightTheme = "C:\Windows\Resources\Themes\aero.theme"
darkTheme = "C:\Windows\Resources\Themes\dark.theme"

SetTheme ' 方法一，使用Win11默认主题
' SetColor ' 方法二，可自定义壁纸

IfRestartExplorer ' 是否重启资源管理器

' 方法一：设置主题
Sub SetTheme
    If currentHour >= sunsetHour Or currentHour < sunriseHour Then
        ' Dark Mode
        Dim objShell
        Set objShell = CreateObject("WScript.Shell")
        ' 执行命令
        objShell.Run "cmd /c start """" """ & darkTheme & """ & timeout /t 1 & taskkill /im ""systemsettings.exe"" /f", 0, True

        Set objShell = Nothing

    Else
        ' Light Mode
        Set objShell = CreateObject("WScript.Shell")

        ' 执行命令
        objShell.Run "cmd /c start """" """ & lightTheme & """ & timeout /t 1 & taskkill /im ""systemsettings.exe"" /f", 0, True

        Set objShell = Nothing
    End If
End Sub

' 方法二：分别设置主题颜色和壁纸
Sub SetColor
    If currentHour >= sunsetHour Or currentHour < sunriseHour Then
        ' Dark Mode
        Dim objShell
        Set objShell = CreateObject("WScript.Shell")
        ' 设置要修改的注册表项路径
        registryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        ' 修改 AppsUseLightTheme 注册表项
        objShell.RegWrite registryPath & "\AppsUseLightTheme", 0, "REG_DWORD"
        ' 修改 SystemUsesLightTheme 注册表项
        objShell.RegWrite registryPath & "\SystemUsesLightTheme", 0, "REG_DWORD"
        Set objShell = Nothing
        wallpaperPath = darkWallpaper

    Else
        ' Light Mode
        Set objShell = CreateObject("WScript.Shell")
        ' 设置要修改的注册表项路径
        registryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        ' 修改 AppsUseLightTheme 注册表项
        objShell.RegWrite registryPath & "\AppsUseLightTheme", 1, "REG_DWORD"
        ' 修改 SystemUsesLightTheme 注册表项
        objShell.RegWrite registryPath & "\SystemUsesLightTheme", 1, "REG_DWORD"
        Set objShell = Nothing
        wallpaperPath = lightWallpaper

    End If

    ' 设置壁纸
    Set objShell = CreateObject("WScript.Shell")
    objShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    objShell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True
    ' 释放对象
    Set objShell = Nothing
End Sub

' 弹出提示框询问是否重启资源管理器
Sub IfRestartExplorer
    Dim response
    response = MsgBox("注册表修改完毕，是否现在重启资源管理器？", vbYesNo, "自动切换Windows主题")
    If response = vbYes Then
        ' Restart Windows Explorer code goes here
        Set objShell = CreateObject("WScript.Shell")
        objShell.Run "taskkill /f /im explorer.exe", 0, True
        objShell.Run "explorer.exe", 0, False
    End If
End Sub