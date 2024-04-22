Dim currentHour, sunriseHour, sunsetHour
sunriseHour = 8
sunsetHour = 18
currentHour = Hour(Now)

Dim lightWallpaper, darkWallpaper, lightTheme, darkTheme,wallpaperPath
lightWallpaper = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
darkWallpaper = "C:\Windows\Web\Wallpaper\Windows\img19.jpg"
lightTheme = "C:\Windows\Resources\Themes\aero.theme"
darkTheme = "C:\Windows\Resources\Themes\dark.theme"

SetTheme ' ����һ��ʹ��Win11Ĭ������
' SetColor ' �����������Զ����ֽ

IfRestartExplorer ' �Ƿ�������Դ������

' ����һ����������
Sub SetTheme
    If currentHour >= sunsetHour Or currentHour < sunriseHour Then
        ' Dark Mode
        Dim objShell
        Set objShell = CreateObject("WScript.Shell")
        ' ִ������
        objShell.Run "cmd /c start """" """ & darkTheme & """ & timeout /t 1 & taskkill /im ""systemsettings.exe"" /f", 0, True

        Set objShell = Nothing

    Else
        ' Light Mode
        Set objShell = CreateObject("WScript.Shell")

        ' ִ������
        objShell.Run "cmd /c start """" """ & lightTheme & """ & timeout /t 1 & taskkill /im ""systemsettings.exe"" /f", 0, True

        Set objShell = Nothing
    End If
End Sub

' ���������ֱ�����������ɫ�ͱ�ֽ
Sub SetColor
    If currentHour >= sunsetHour Or currentHour < sunriseHour Then
        ' Dark Mode
        Dim objShell
        Set objShell = CreateObject("WScript.Shell")
        ' ����Ҫ�޸ĵ�ע�����·��
        registryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        ' �޸� AppsUseLightTheme ע�����
        objShell.RegWrite registryPath & "\AppsUseLightTheme", 0, "REG_DWORD"
        ' �޸� SystemUsesLightTheme ע�����
        objShell.RegWrite registryPath & "\SystemUsesLightTheme", 0, "REG_DWORD"
        Set objShell = Nothing
        wallpaperPath = darkWallpaper

    Else
        ' Light Mode
        Set objShell = CreateObject("WScript.Shell")
        ' ����Ҫ�޸ĵ�ע�����·��
        registryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        ' �޸� AppsUseLightTheme ע�����
        objShell.RegWrite registryPath & "\AppsUseLightTheme", 1, "REG_DWORD"
        ' �޸� SystemUsesLightTheme ע�����
        objShell.RegWrite registryPath & "\SystemUsesLightTheme", 1, "REG_DWORD"
        Set objShell = Nothing
        wallpaperPath = lightWallpaper

    End If

    ' ���ñ�ֽ
    Set objShell = CreateObject("WScript.Shell")
    objShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    objShell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True
    ' �ͷŶ���
    Set objShell = Nothing
End Sub

' ������ʾ��ѯ���Ƿ�������Դ������
Sub IfRestartExplorer
    Dim response
    response = MsgBox("ע����޸���ϣ��Ƿ�����������Դ��������", vbYesNo, "�Զ��л�Windows����")
    If response = vbYes Then
        ' Restart Windows Explorer code goes here
        Set objShell = CreateObject("WScript.Shell")
        objShell.Run "taskkill /f /im explorer.exe", 0, True
        objShell.Run "explorer.exe", 0, False
    End If
End Sub