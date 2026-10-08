@echo off
setlocal

set SSH_USR=username

set LAB_DIR=~/i220/submit
set CS_DIR=~/cs220

if "%~1"=="" (
    echo Please provide a lab name. FORMAT: %~n0 ^[LabName ^(ex: lab4, lab2^)^] ^[-ng ^(OPTIONAL: Skips committing to github^)^]
    pause
    exit /b 1
)
set GITCOMMIT=1
if /i "%~2"=="-ng" set GITCOMMIT=0
ssh %SSH_USR%@remote.cs.binghamton.edu "cd %CS_DIR% && git pull && cd %LAB_DIR% && git pull && cp -r ~/cs220/*/%~1/%~1-sol . && cd %~1-sol && if [ %GITCOMMIT% -eq 1 ]; then git add . && if git diff --cached --quiet; then echo 'Nothing new to commit.'; else git commit -m 'started %~1'; fi && git push; fi"
if errorlevel 1 (
    echo Remote step failed.
    pause
    exit /b 1
)
pause
