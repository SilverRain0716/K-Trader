@echo off
set TRADER_EXE=C:\Users\Administrator\AppData\Local\Programs\K-Trader\K-Trader.exe
set LOG=C:\Users\Administrator\Desktop\start_trader.log

echo [%date% %time%] START >> "%LOG%"
echo [%date% %time%] START

if not exist "%TRADER_EXE%" (
    echo [%date% %time%] ERROR: K-Trader.exe not found >> "%LOG%"
    echo ERROR: K-Trader.exe not found at %TRADER_EXE%
    pause
    exit /B 1
)
echo [%date% %time%] K-Trader.exe found >> "%LOG%"
echo K-Trader.exe found

tasklist /FI "IMAGENAME eq K-Trader.exe" 2>NUL | find /I "K-Trader.exe" >NUL
if %ERRORLEVEL%==0 (
    echo [%date% %time%] Already running - skip >> "%LOG%"
    echo Already running - skip
    pause
    exit /B 0
)

echo [%date% %time%] Starting K-Trader... >> "%LOG%"
echo Starting K-Trader...
start "" "%TRADER_EXE%"
echo [%date% %time%] Done >> "%LOG%"
echo Done

pause
exit /B 0
