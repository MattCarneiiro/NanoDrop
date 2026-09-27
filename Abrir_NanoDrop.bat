@echo off
setlocal
title NanoDrop
color 0A
cd /d "%~dp0"

echo =========================================
echo       BEM-VINDO AO NANODROP
echo =========================================

where py >nul 2>nul
if %errorlevel%==0 (
    set "PYLAUNCHER=py"
) else (
    where python >nul 2>nul
    if %errorlevel%==0 (
        set "PYLAUNCHER=python"
    ) else (
        echo ERRO: Python nao foi encontrado no PATH.
        echo Instale o Python 3 em https://www.python.org/downloads/ e tente novamente.
        pause
        exit /b 1
    )
)

if not exist "venv\Scripts\python.exe" (
    echo Criando ambiente virtual em venv\ ...
    %PYLAUNCHER% -m venv venv
    if not exist "venv\Scripts\python.exe" (
        echo ERRO: Falha ao criar o ambiente virtual.
        pause
        exit /b 1
    )
)

echo Atualizando dependencias ^(yt-dlp sempre na ultima versao, essencial pro YouTube nao bloquear^)...
venv\Scripts\python.exe -m pip install --upgrade pip --quiet
venv\Scripts\python.exe -m pip install --upgrade -r requirements.txt --quiet
if errorlevel 1 (
    echo AVISO: Falha ao atualizar dependencias. Tentando abrir mesmo assim...
)

echo.
echo Tudo pronto! Abrindo o NanoDrop...
venv\Scripts\python.exe main.py

endlocal
