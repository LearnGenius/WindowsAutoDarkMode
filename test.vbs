Dim objFSO, appDataFolder, targetFolder

' �����ļ�ϵͳ����
Set objFSO = CreateObject("Scripting.FileSystemObject")

' ��ȡ��ǰ�û��� AppData Ŀ¼·��
appDataFolder = objFSO.GetSpecialFolder(2) ' 2 ��ʾ AppData Ŀ¼

' ����Ŀ���ļ���·��
targetFolder = appDataFolder & "\AutoSwitchDarkLight"
MsgBox targetFolder

' ���Ŀ���ļ����Ƿ���ڣ�����������򴴽���
If Not objFSO.FolderExists(targetFolder) Then
    objFSO.CreateFolder(targetFolder)
    MsgBox "�ļ����ѳɹ������������ļ��гɹ�"
End If

' �ͷ��ļ�ϵͳ����
Set objFSO = Nothing