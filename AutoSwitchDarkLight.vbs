Dim currentHour, sunriseHour, sunsetHour
sunriseHour = 8
sunsetHour = 18
currentHour = Hour(Now)

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

End If

Dim response
response = MsgBox("ע����޸���ϣ��Ƿ�����������Դ��������", vbYesNo, "�Զ��л�Windows����")
If response = vbYes Then
    ' Restart Windows Explorer code goes here
    Set objShell = CreateObject("WScript.Shell")
    objShell.Run "taskkill /f /im explorer.exe", 0, True
    objShell.Run "explorer.exe", 0, False
End If