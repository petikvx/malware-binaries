On Error Resume Next
MsgBox "This freeware will help you to delete the I-Worm.Anthrax",vbinformation,"Remove Petik Tool (I-Worm.Anthrax)"
Set ws=CreateObject("WScript.Shell")
Set fso=CreateObject("Scripting.FileSystemObject")
Set win=fso.GetSpecialFolder(0)
Set sys=fso.GetSpecialFolder(1)

ws.RegDelete ("HKLM\Software\Microsoft\Windows\CurrentVersion\Run\Microsoft System")
If fso.FileExists(sys&"\MsSys32.exe") Then
fso.DeleteFile(sys&"\MsSys32.exe")
MsgBox "Your computer is infected by I-Worm.Anthrax",vbcritical,"Remove Petik Tool (I-Worm.Anthrax)"
Else
MsgBox "Your computer doesn't have I-Worm.Anthrax",vbinformation,"Remove Petik Tool (I-Worm.Anthrax)"
wscript.quit
End If


desk=ws.RegRead ("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Desktop")
If fso.FileExists(desk&"\Anthrax_Info.url") Then
fso.DeleteFile(desk&"\Anthrax_Info.url")
End If
If fso.FileExists("C:\Anthrax_Info.url") Then
fso.DeleteFile("C:\Anthrax_Info.url")
End If


MsgBox "Your computer is now clean. Have a nice day.",vbinformation,"Remove Petik Tool (I-Worm.Anthrax)"