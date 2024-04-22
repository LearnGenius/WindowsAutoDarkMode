Dim objFSO, appDataFolder, targetFolder

' 创建文件系统对象
Set objFSO = CreateObject("Scripting.FileSystemObject")

' 获取当前用户的 AppData 目录路径
appDataFolder = objFSO.GetSpecialFolder(2) ' 2 表示 AppData 目录

' 构造目标文件夹路径
targetFolder = appDataFolder & "\AutoSwitchDarkLight"
MsgBox targetFolder

' 检查目标文件夹是否存在，如果不存在则创建它
If Not objFSO.FolderExists(targetFolder) Then
    objFSO.CreateFolder(targetFolder)
    MsgBox "文件夹已成功创建：创建文件夹成功"
End If

' 释放文件系统对象
Set objFSO = Nothing