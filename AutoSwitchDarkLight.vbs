Dim currentHour, sunriseHour, sunsetHour
sunriseHour = 8
sunsetHour = 18
currentHour = Hour(Now)

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

End If

Dim response
response = MsgBox("注册表修改完毕，是否现在重启资源管理器？", vbYesNo, "自动切换Windows主题")
If response = vbYes Then
    ' Restart Windows Explorer code goes here
    Set objShell = CreateObject("WScript.Shell")
    objShell.Run "taskkill /f /im explorer.exe", 0, True
    objShell.Run "explorer.exe", 0, False
End If