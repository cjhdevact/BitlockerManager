::=========================
::BitLocker 管理器 - 2024-04-13 11:19
::版权所有(C) 2024 CJH。保留所有权利。
::=========================
@echo off
cd /d %~dp0

fltmc 1>nul 2>nul&& goto :warnpg
set parameters=
:parameter
@if not "%~1"=="" ( set parameters=%parameters% %~1& shift /1& goto :parameter)
set parameters="%parameters:~1%"
echo 正在获取管理员权限...
echo.
echo 如果当前窗口无限循环出现，或者未成功获取管理员权限，请注销当前用户或重启电脑，
echo 然后以管理员用户账号运行或手动以管理员身份运行。
mshta vbscript:createobject("shell.application").shellexecute("%~dpnx0",%parameters%,"","runas",1)(window.close)&exit
cd /d %~dp0

:warnpg
cls
title Bitlocker 管理器 - 功能警告
color 4f
echo.
echo   =================================================================
echo                      BitLocker 管理器 - 功能警告
echo   =================================================================
echo.
echo        不正确使用本程序可能会造成你的重要数据丢失。对于本程序所造成的
echo    数据丢失或错误以及其带来的损失，本程序作者概不负责，后果自负。
echo        建议首次运行程序首先查看 BitLocker 状态，另外建议非必要不要
echo    启用 BitLocker ，以免当系统损坏时没有恢复密钥无法恢复数据。如果启
echo    用了建议先解锁再解密。
echo        请在使用前弹出任何的外部存储设备（如U盘，移动硬盘，DVD等）！
echo.
echo   =================================================================
echo.
echo 你是否已知晓以上风险并自愿承担其带来的后果？
echo.
choice /C AD /N /M "  已知晓并同意以上内容（A）不同意并退出本程序（D）："
if errorlevel 2 exit
if errorlevel 1 goto welpg
:welpg
cls
title BitLocker 管理器 - 当前用户：%username%
color 1F
echo ========================================================
echo     BitLocker 管理器 - 当前用户：%username%
echo ========================================================
echo 请确保使用管理员权限运行该程序！
echo 请在使用前弹出任何的外部存储设备（如U盘，移动硬盘，DVD等）！
echo ========================================================
echo 请选择你的操作：
echo.
echo         1  查看 BitLocker 状态
echo.
echo         2  解密所有被加密的分区
echo         3  解密一个指定的分区
echo         4  解锁一个指定的分区
echo.
echo         5  让所有加密、解密或擦除可用空间操作继续
echo         6  让所有加密、解密或擦除可用空间操作停止
echo.
echo         7  加密所有分区
echo         8  锁定所有分区
echo         9  加密一个指定的分区
echo        10  锁定一个指定的分区
echo.
echo        11  BitLocker 命令行（高级）
echo.
echo        12  退出
echo ========================================================
echo.
set /p chooice=请输入对应的数字以执行相应的操作：
if "%chooice%" == "1" goto bdlst
if "%chooice%" == "2" goto uebdla
if "%chooice%" == "3" goto uebdl
if "%chooice%" == "4" goto ulbdl
if "%chooice%" == "5" goto rebdl
if "%chooice%" == "6" goto pabdl
if "%chooice%" == "7" goto ebdla
if "%chooice%" == "8" goto lbdla
if "%chooice%" == "9" goto ebdl
if "%chooice%" == "10" goto lbdl
if "%chooice%" == "11" goto blcmd
if "%chooice%" == "12" exit
echo.
echo 无效的选项，任意键返回。 & pause >nul
cls
goto welpg

:bdlst
cls
echo ========================================================
echo.
echo     当前 BitLocker 状态
echo.
echo ========================================================
manage-bde -status
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:uebdla
cls
echo ========================================================
echo.
echo     解密所有被加密的分区
echo.
echo ========================================================
choice /C YN /M "确定要解密所有被加密的分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
echo 如果被解密的分区存在你自定义的密码，请正确输入，你无法查看你输入的内容。
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -off "%%c:"
)
echo.
echo 使用 manage-bde -status 查看解密进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:uebdl
cls
echo ========================================================
echo.
echo     解密一个指定的分区
echo.
echo ========================================================
choice /C YN /M "确定要解密一个指定的分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uedr=请输入要解密的分区（如C:）：
echo.
echo 如果这个分区存在你自定义的密码，请正确输入，你无法查看你输入的内容。
echo.
manage-bde -off "%uedr%"
echo.
echo 使用 manage-bde -status 查看解密进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:ulbdl
cls
echo ========================================================
echo.
echo     解锁一个指定的分区
echo.
echo ========================================================
choice /C YN /M "确定要解锁一个指定的分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uldr=请输入要解锁的分区（如C:）：
set /p ulk=请输入要解锁的分区对应的恢复密钥：
echo.
manage-bde -unlock %uldr% -RecoveryPassword %ulk%
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:rebdl
cls
echo ========================================================
echo.
echo     让所有加密、解密或擦除可用空间操作继续
echo.
echo ========================================================
choice /C YN /M "确定要让所有加密、解密或擦除可用空间操作继续？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -resume "%%c:"
)
echo.
echo 使用 manage-bde -status 查看进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:pabdl
cls
echo ========================================================
echo.
echo    让所有加密、解密或擦除可用空间操作停止
echo.
echo ========================================================
choice /C YN /M "确定要让所有加密、解密或擦除可用空间操作停止？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -pause "%%c:"
)
echo.
echo 使用 manage-bde -status 查看进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:ebdla
cls
echo ========================================================
echo.
echo     加密所有分区
echo.
echo ========================================================
choice /C YN /M "确定要加密所有分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p kpath=请输入要保存加密恢复密钥位置：
echo.
if not exist "%kpath%" echo 输入的路径无效，已恢复默认路径（%userprofile%\Desktop\BitlockerRecoveryKeyBak） & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak
if not exist "%kpath%" if not exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak"
if not exist "%kpath%" if exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF" & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -on "%%c:" -RecoveryKey "%kpath%" -password
)
echo.
echo 使用 manage-bde -status 查看加密进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:lbdla
cls
echo ========================================================
echo.
echo     锁定所有分区
echo.
echo ========================================================
choice /C YN /M "确定要锁定所有分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -lock "%%c:"
)
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:ebdl
cls
echo ========================================================
echo.
echo     加密一个指定的分区
echo.
echo ========================================================
choice /C YN /M "确定要加密一个指定的分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uedr=请输入要加密的分区（如C:）：
set /p kpath=请输入要保存加密恢复密钥位置：
echo.
if not exist "%kpath%" echo 输入的路径无效，已恢复默认路径（%userprofile%\Desktop\BitlockerRecoveryKeyBak） & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak
if not exist "%kpath%" if not exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak"
if not exist "%kpath%" if exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF" & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF
echo.
manage-bde -on "%uedr%" -RecoveryKey "%kpath%" -password
echo.
echo 使用 manage-bde -status 查看加密进度。
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:lbdl
cls
echo ========================================================
echo.
echo     锁定一个指定的分区
echo.
echo ========================================================
choice /C YN /M "确定要锁定一个指定的分区？[是(Y)/否(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uldr=请输入要锁定的分区（如C:）：
echo.
manage-bde -lock %uldr%
echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg

:blcmd
cls
echo.
cmd.exe /k "title BitLocker 管理器 - 当前用户：%username% & manage-bde -? & echo. & echo ======================================================== & echo 输入 EXIT 退出命令行。 & echo ======================================================== & echo."

echo.
echo ========================================================
echo.
echo 任意键返回... & pause >nul
cls
goto welpg