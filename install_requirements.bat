@echo off
setlocal enabledelayedexpansion
title Voidcraft - Environment Setup
cd /d "%~dp0"

:: 1. Locate Python executable (prefer py launcher, then python)
set "PY="
where py >nul 2>nul && set "PY=py"
if not defined PY (
    where python >nul 2>nul && set "PY=python"
)

if not defined PY (
    echo [ERROR] Python was not found in your PATH.
    echo Please install Python 64-bit and ensure "Add python.exe to PATH" is checked.
    pause
    exit /b 1
)

echo [INFO] Detected Python runtime:
%PY% --version
echo.

:: 2. Ensure Scripts directory is on local PATH for this session
for /f "tokens=*" %%i in ('%PY% -c "import sysconfig; print(sysconfig.get_path('scripts'))"') do set "PY_SCRIPTS=%%i"
if defined PY_SCRIPTS set "PATH=%PY_SCRIPTS%;%PATH%"

:: 3. Update tooling while preserving PyTorch compatibility (setuptools<82)
echo [INFO] Ensuring pip, wheel, and compatible setuptools...
%PY% -m pip install --upgrade pip wheel "setuptools<82"
if errorlevel 1 goto :fail
echo.

:: 4. Verify requirements.txt is clean
findstr /i "@echo" requirements.txt >nul 2>nul
if %errorlevel%==0 (
    echo [WARNING] Detected batch script content inside requirements.txt. Overwriting with clean package specifiers...
    (
        echo pygame-ce^>=2.5.0
        echo numpy^>=1.26.0
        echo PyOpenGL^>=3.1.7
        echo PyOpenGL_accelerate^>=3.1.7
        echo scipy^>=1.12.0
        echo psutil^>=5.9.0
        echo flask^>=3.0.0
        echo opencv-python^>=4.9.0
        echo segno^>=1.6.0
    ) > requirements.txt
)

:: 5. Install dependencies
echo [INFO] Installing Voidcraft dependencies...
%PY% -m pip install -r requirements.txt
if errorlevel 1 goto :fail
echo.

:: 6. Verify Tkinter GUI availability
echo [INFO] Verifying Tkinter installation...
%PY% -c "import tkinter" >nul 2>nul
if errorlevel 1 (
    echo [WARNING] Tkinter is not installed or enabled in this Python runtime.
    echo Launcher GUI will fail. Re-run your Python installer, click "Modify", and check "tcl/tk and IDLE".
    echo.
)

echo [SUCCESS] Environment ready for Voidcraft.
pause
exit /b 0

:fail
echo.
echo [ERROR] Dependency installation encountered a failure.
pause
exit /b 1