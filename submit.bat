@echo off
setlocal


set OUT_DIR=C:\Users\user\Downloads\labs
set SSH_USR=user
set IN_DIR=~/i220/submit/%~1-sol
set ZIP_DIR=~/cs220/bin/do-zip.sh


if "%~1"=="" (
    echo Please provide a lab name. FORMAT: %~nx0 ^[LabName ^(ex: lab4, lab2^)^] ^[-g ^(OPTIONAL: commits to github^)^] ^[-nz ^(OPTIONAL: Skips rezipping^)^]
    pause
    exit /b 1
)
set GITCOMMIT=0
set NOZIP=0
if /i "%~2"=="-nz" set NOZIP=1
if /i "%~3"=="-nz" set NOZIP=1
if /i "%~2"=="-g" set GITCOMMIT=1
if /i "%~3"=="-g" set GITCOMMIT=1
ssh %SSH_USR%@remote.cs.binghamton.edu "cd %IN_DIR% && MADE=0 && if [ ! -f README.md ]; then cp ../README.md.tmpl README.md && sed -i '1s|.*|#    %~1|' README.md && MADE=1; fi && if [ %GITCOMMIT% -eq 1 ]; then git add . && { git diff --cached --quiet || git commit -m 'completed %~1'; } && git push; fi && cd ../ && if [ $MADE -eq 1 ] || [ %NOZIP% -eq 0 ] || [ ! -f %IN_DIR%.zip ]; then %ZIP_DIR% %~1-sol; fi"
if errorlevel 1 (
    echo Remote zip step failed.
    pause
    exit /b 1
)
if not exist "%OUT_DIR%\" mkdir "%OUT_DIR%"
scp %SSH_USR%@remote.cs.binghamton.edu:%IN_DIR%.zip "%OUT_DIR%"
pause
