@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

set "VENV_PYTHON=.venv-book\Scripts\python.exe"
set "JUPYTER=.venv-book\Scripts\jupyter.exe"

echo [SLP3] 正在准备本地电子书...

if exist "%VENV_PYTHON%" goto :install_dependencies

echo [SLP3] 首次启动：正在创建 Python 虚拟环境 .venv-book...
where py >nul 2>nul
if not errorlevel 1 (
    py -3 -m venv .venv-book
) else (
    where python >nul 2>nul
    if errorlevel 1 goto :python_not_found
    python -m venv .venv-book
)
if errorlevel 1 goto :venv_failed

:install_dependencies
if exist "%JUPYTER%" goto :start_book

echo [SLP3] 首次启动：正在安装项目依赖，请稍候...
"%VENV_PYTHON%" -m pip install -r requirements-book.txt
if errorlevel 1 goto :install_failed

:start_book
echo [SLP3] 电子书：http://localhost:3000/
echo [SLP3] 按 Ctrl+C 可停止服务。
echo.
"%JUPYTER%" book start
if errorlevel 1 goto :runtime_failed
goto :end

:python_not_found
echo.
echo [错误] 未找到 Python 3。请先安装 Python 3，并在安装时勾选“Add Python to PATH”。
goto :failed

:venv_failed
echo.
echo [错误] 无法创建虚拟环境 .venv-book。
goto :failed

:install_failed
echo.
echo [错误] 依赖安装失败，请检查网络连接和上方错误信息。
goto :failed

:runtime_failed
echo.
echo [错误] 本地电子书启动失败，请检查上方错误信息。

:failed
echo.
pause
exit /b 1

:end
endlocal
