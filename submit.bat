@echo off
setlocal


set OUT_DIR=C:\Users\user\Downloads\labs
set SSH_USR=username


set IN_DIR=~/i220/submit/%~1-sol
set ZIP_DIR=~/cs220/bin/do-zip.sh
if "%~1"=="" (
    echo Please provide a lab name. FORMAT: %~nx0 ^[LabName ^(ex: lab4, lab2^)^] ^[-ng ^(OPTIONAL: Skips committing to github^)^] ^[-nz ^(OPTIONAL: Skips rezipping^)^]
    pause
    exit /b 1
)
set GITCOMMIT=1
set NOZIP=0
if /i "%~2"=="-nz" set NOZIP=1
if /i "%~3"=="-nz" set NOZIP=1
if /i "%~2"=="-ng" set GITCOMMIT=0
if /i "%~3"=="-ng" set GITCOMMIT=0
ssh %SSH_USR%@remote.cs.binghamton.edu "cd %IN_DIR% && MADE=0 && if [ ! -f README.md ]; then cp ../README.md.tmpl README.md && sed -i '1s|.*|#    %~1|' README.md && MADE=1; fi && if [ %GITCOMMIT% -eq 1 ]; then git add . && if git diff --cached --quiet; then echo 'Nothing new to commit.'; else git commit -m 'completed %~1'; fi && git push; fi && cd ../ && if [ $MADE -eq 1 ] || [ %NOZIP% -eq 0 ] || [ ! -f %IN_DIR%.zip ]; then %ZIP_DIR% %~1-sol; fi"
if errorlevel 1 (
    echo Remote zip step failed.
    pause
    exit /b 1
)
if not exist "%OUT_DIR%\" mkdir "%OUT_DIR%"
scp %SSH_USR%@remote.cs.binghamton.edu:%IN_DIR%.zip "%OUT_DIR%"
pause
