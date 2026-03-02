@echo off
:: ============================================================
:: K-Trader 자동 시작 스크립트 (Windows 작업 스케줄러용)
:: ============================================================

set TRADER_EXE=C:\Users\Administrator\AppData\Local\Programs\K-Trader\K-Trader.exe
set LOG=C:\Users\Administrator\Desktop\start_trader.log

echo [%date% %time%] ===== 스케줄러 실행 ===== >> "%LOG%"
echo [%date% %time%] ===== 스케줄러 실행 =====

:: ── EXE 파일 존재 여부 확인 ───────────────────────────────────
if not exist "%TRADER_EXE%" (
    echo [%date% %time%] 오류: K-Trader.exe 를 찾을 수 없음 >> "%LOG%"
    echo [%date% %time%] 경로: %TRADER_EXE% >> "%LOG%"
    echo 오류: K-Trader.exe 를 찾을 수 없습니다.
    echo 경로: %TRADER_EXE%
    pause
    exit /B 1
)
echo [%date% %time%] K-Trader.exe 확인 완료 >> "%LOG%"
echo K-Trader.exe 확인 완료

:: ── 이미 실행 중인지 확인 ─────────────────────────────────────
tasklist /FI "IMAGENAME eq K-Trader.exe" 2>NUL | find /I "K-Trader.exe" >NUL
if %ERRORLEVEL%==0 (
    echo [%date% %time%] K-Trader 이미 실행 중 - 스킵 >> "%LOG%"
    echo K-Trader 이미 실행 중 - 스킵
    pause
    exit /B 0
)

:: ── 실행 중이 아니면 시작 ─────────────────────────────────────
echo [%date% %time%] K-Trader 시작 시도 >> "%LOG%"
echo K-Trader 시작 시도 중...
start "" "%TRADER_EXE%"
echo [%date% %time%] K-Trader 시작 명령 완료 >> "%LOG%"
echo K-Trader 시작 완료

pause
exit /B 0
