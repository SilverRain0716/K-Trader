@echo off
setlocal

echo [1/5] Finding Python 3.10 32-bit...
py -3.10-32 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON=py -3.10-32
    goto :build
)
python --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON=python
    goto :build
)
echo ERROR: Python not found
pause
exit /b 1

:build
echo OK: %PYTHON%

echo [2/5] Installing dependencies...
%PYTHON% -m pip install -r requirements.txt -q
%PYTHON% -m pip install pyinstaller -q
if %errorlevel% neq 0 ( echo ERROR: pip install failed & pause & exit /b 1 )
echo OK

echo [3/5] Building K-Trader.exe...
%PYTHON% -m PyInstaller --noconfirm --clean --onedir --windowed ^
    --name "K-Trader" ^
    --icon "assets\K-Trader.ico" ^
    --add-data "src;src" ^
    --hidden-import "PyQt5.QtWidgets" ^
    --hidden-import "PyQt5.QAxContainer" ^
    --hidden-import "PyQt5.QtCore" ^
    --hidden-import "PyQt5.QtGui" ^
    --hidden-import "src.engine" ^
    --hidden-import "src.ui_dashboard" ^
    --hidden-import "src.setup_wizard" ^
    --hidden-import "src.config_manager" ^
    --hidden-import "src.notifications" ^
    --hidden-import "src.database" ^
    --hidden-import "src.market_calendar" ^
    --hidden-import "src.ipc" ^
    --hidden-import "src.utils" ^
    --hidden-import "src.styles" ^
    --hidden-import "src.web_monitor" ^
    --hidden-import "src.backtest" ^
    --hidden-import "cryptography" ^
    --hidden-import "cryptography.fernet" ^
    --hidden-import "requests" ^
    --hidden-import "flask" ^
    main.py
if %errorlevel% neq 0 ( echo ERROR: K-Trader build failed & pause & exit /b 1 )
echo OK

echo [4/5] Building Setup Wizard...
%PYTHON% -m PyInstaller --noconfirm --clean --onefile --windowed ^
    --name "K-Trader Setup Wizard" ^
    --icon "assets\K-Trader.ico" ^
    --hidden-import "PyQt5.QtWidgets" ^
    --hidden-import "PyQt5.QtCore" ^
    --hidden-import "PyQt5.QtGui" ^
    --hidden-import "requests" ^
    src\setup_wizard.py
if %errorlevel% neq 0 ( echo ERROR: Setup Wizard build failed & pause & exit /b 1 )
echo OK

echo [5/5] Setting up dist folders...
if not exist "dist\K-Trader\config"  mkdir "dist\K-Trader\config"
if not exist "dist\K-Trader\data"    mkdir "dist\K-Trader\data"
if not exist "dist\K-Trader\logs"    mkdir "dist\K-Trader\logs"
if not exist "dist\K-Trader\reports" mkdir "dist\K-Trader\reports"
if not exist "dist\K-Trader\docs"    mkdir "dist\K-Trader\docs"
if exist "docs\K-Trader_Guide.pdf" copy /Y "docs\K-Trader_Guide.pdf" "dist\K-Trader\docs\" >nul
echo OK

echo.
echo =============================================
echo  Build Complete!
echo  K-Trader.exe    : dist\K-Trader\K-Trader.exe
echo  Setup Wizard    : dist\K-Trader Setup Wizard.exe
echo  Next: Compile installer.iss with Inno Setup
echo =============================================
pause
