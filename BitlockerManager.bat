::=========================
::BitLocker ������ - 2024-04-13 11:19
::��Ȩ����(C) 2024 CJH����������Ȩ����
::=========================
@echo off
cd /d %~dp0

fltmc 1>nul 2>nul&& goto :warnpg
set parameters=
:parameter
@if not "%~1"=="" ( set parameters=%parameters% %~1& shift /1& goto :parameter)
set parameters="%parameters:~1%"
echo ���ڻ�ȡ����ԱȨ��...
echo.
echo �����ǰ��������ѭ�����֣�����δ�ɹ���ȡ����ԱȨ�ޣ���ע����ǰ�û����������ԣ�
echo Ȼ���Թ���Ա�û��˺����л��ֶ��Թ���Ա������С�
mshta vbscript:createobject("shell.application").shellexecute("%~dpnx0",%parameters%,"","runas",1)(window.close)&exit
cd /d %~dp0

:warnpg
cls
title Bitlocker ������ - ���ܾ���
color 4f
echo.
echo   =================================================================
echo                      BitLocker ������ - ���ܾ���
echo   =================================================================
echo.
echo        ����ȷʹ�ñ�������ܻ���������Ҫ���ݶ�ʧ�����ڱ���������ɵ�
echo    ���ݶ�ʧ������Լ����������ʧ�����������߸Ų����𣬺���Ը���
echo        �����״����г������Ȳ鿴 BitLocker ״̬�����⽨��Ǳ�Ҫ��Ҫ
echo    ���� BitLocker �����⵱ϵͳ��ʱû�лָ���Կ�޷��ָ����ݡ������
echo    ���˽����Ƚ����ٽ��ܡ�
echo        ����ʹ��ǰ�����κε��ⲿ�洢�豸����U�̣��ƶ�Ӳ�̣�DVD�ȣ���
echo.
echo   =================================================================
echo.
echo ���Ƿ���֪�����Ϸ��ղ���Ը�е�������ĺ����
echo.
choice /C AD /N /M "  ��֪����ͬ���������ݣ�A����ͬ�Ⲣ�˳�������D����"
if errorlevel 2 exit
if errorlevel 1 goto welpg
:welpg
cls
title BitLocker ������ - ��ǰ�û���%username%
color 1F
echo ========================================================
echo     BitLocker ������ - ��ǰ�û���%username%
echo ========================================================
echo ��ȷ��ʹ�ù���ԱȨ�����иó���
echo ����ʹ��ǰ�����κε��ⲿ�洢�豸����U�̣��ƶ�Ӳ�̣�DVD�ȣ���
echo ========================================================
echo ��ѡ����Ĳ�����
echo.
echo         1  �鿴 BitLocker ״̬
echo.
echo         2  �������б����ܵķ���
echo         3  ����һ��ָ���ķ���
echo         4  ����һ��ָ���ķ���
echo.
echo         5  �����м��ܡ����ܻ�������ÿռ��������
echo         6  �����м��ܡ����ܻ�������ÿռ����ֹͣ
echo.
echo         7  �������з���
echo         8  �������з���
echo         9  ����һ��ָ���ķ���
echo        10  ����һ��ָ���ķ���
echo.
echo        11  BitLocker �����У��߼���
echo.
echo        12  �˳�
echo ========================================================
echo.
set /p chooice=�������Ӧ��������ִ����Ӧ�Ĳ�����
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
echo ��Ч��ѡ���������ء� & pause >nul
cls
goto welpg

:bdlst
cls
echo ========================================================
echo.
echo     ��ǰ BitLocker ״̬
echo.
echo ========================================================
manage-bde -status
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:uebdla
cls
echo ========================================================
echo.
echo     �������б����ܵķ���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ�������б����ܵķ�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
echo ��������ܵķ����������Զ�������룬����ȷ���룬���޷��鿴����������ݡ�
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -off "%%c:"
)
echo.
echo ʹ�� manage-bde -status �鿴���ܽ��ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:uebdl
cls
echo ========================================================
echo.
echo     ����һ��ָ���ķ���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ����һ��ָ���ķ�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uedr=������Ҫ���ܵķ�������C:����
echo.
echo �����������������Զ�������룬����ȷ���룬���޷��鿴����������ݡ�
echo.
manage-bde -off "%uedr%"
echo.
echo ʹ�� manage-bde -status �鿴���ܽ��ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:ulbdl
cls
echo ========================================================
echo.
echo     ����һ��ָ���ķ���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ����һ��ָ���ķ�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uldr=������Ҫ�����ķ�������C:����
set /p ulk=������Ҫ�����ķ�����Ӧ�Ļָ���Կ��
echo.
manage-bde -unlock %uldr% -RecoveryPassword %ulk%
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:rebdl
cls
echo ========================================================
echo.
echo     �����м��ܡ����ܻ�������ÿռ��������
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ�����м��ܡ����ܻ�������ÿռ����������[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -resume "%%c:"
)
echo.
echo ʹ�� manage-bde -status �鿴���ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:pabdl
cls
echo ========================================================
echo.
echo    �����м��ܡ����ܻ�������ÿռ����ֹͣ
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ�����м��ܡ����ܻ�������ÿռ����ֹͣ��[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -pause "%%c:"
)
echo.
echo ʹ�� manage-bde -status �鿴���ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:ebdla
cls
echo ========================================================
echo.
echo     �������з���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ�������з�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p kpath=������Ҫ������ָܻ���Կλ�ã�
echo.
if not exist "%kpath%" echo �����·����Ч���ѻָ�Ĭ��·����%userprofile%\Desktop\BitlockerRecoveryKeyBak�� & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak
if not exist "%kpath%" if not exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak"
if not exist "%kpath%" if exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF" & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -on "%%c:" -RecoveryKey "%kpath%" -password
)
echo.
echo ʹ�� manage-bde -status �鿴���ܽ��ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:lbdla
cls
echo ========================================================
echo.
echo     �������з���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ�������з�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
for %%c in (C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
    if exist "%%c:" manage-bde -lock "%%c:"
)
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:ebdl
cls
echo ========================================================
echo.
echo     ����һ��ָ���ķ���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ����һ��ָ���ķ�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uedr=������Ҫ���ܵķ�������C:����
set /p kpath=������Ҫ������ָܻ���Կλ�ã�
echo.
if not exist "%kpath%" echo �����·����Ч���ѻָ�Ĭ��·����%userprofile%\Desktop\BitlockerRecoveryKeyBak�� & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak
if not exist "%kpath%" if not exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak"
if not exist "%kpath%" if exist "%userprofile%\Desktop\BitlockerRecoveryKeyBak" md "%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF" & set kpath=%userprofile%\Desktop\BitlockerRecoveryKeyBak_TempF
echo.
manage-bde -on "%uedr%" -RecoveryKey "%kpath%" -password
echo.
echo ʹ�� manage-bde -status �鿴���ܽ��ȡ�
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:lbdl
cls
echo ========================================================
echo.
echo     ����һ��ָ���ķ���
echo.
echo ========================================================
choice /C YN /M "ȷ��Ҫ����һ��ָ���ķ�����[��(Y)/��(N)]"
if errorlevel 2 cls & goto welpg
echo.
set /p uldr=������Ҫ�����ķ�������C:����
echo.
manage-bde -lock %uldr%
echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg

:blcmd
cls
echo.
cmd.exe /k "title BitLocker ������ - ��ǰ�û���%username% & manage-bde -? & echo. & echo ======================================================== & echo ���� EXIT �˳������С� & echo ======================================================== & echo."

echo.
echo ========================================================
echo.
echo ���������... & pause >nul
cls
goto welpg