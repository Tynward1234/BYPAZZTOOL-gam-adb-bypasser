@echo off
msg * Welcome to BYPAZZTOOL-v0.1 by @greasychicken


msg * Checking for ADB software...
if not exist "%~dp0adb.exe" (
    msg * ADB not found. Please download and install ADB.
    exit

)


:choice
set /P c=Choose option[Google/Knox]?
if /I "%c%" EQU "google" goto :google
if /I "%c%" EQU "knox" goto :knox
goto :choice



:knox
msg * Enabling ADB debugging...
adb shell settings put global adb_enabled 1

msg * Rebooting device...
adb reboot

msg * Waiting on device.reboot...
timeout /t 35

msg * Bypassing Knox...
adb shell su 0 pm disable-user --user 0 com.sec.enterprise.knox.attestation
pause
exit


:google
msg * Enabling ADB debugging for bypass...
"%~dp0adb.exe" shell settings put global adb_enabled 1


msg * Bypassing google lock...
"%~dp0adb.exe" shell content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:i:1


msg * Removing previous owner's account...
"%~dp0adb.exe" shell pm clear com.android.providers.settings
"%~dp0adb.exe" shell am start -n com.android.settings/com.android.settings.Settings$DeviceAdminSettingsActivity

msg * google lock bypassed!
msg * Don't forget to add your own account to the device.
pause
exit