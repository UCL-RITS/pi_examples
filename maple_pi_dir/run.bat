@echo off
set INSTALL_DIR="C:\Program Files (x86)\Maple 8\bin.win"
set N="%1"
if not "%~1"=="" goto go
set N=1000000
:go
%INSTALL_DIR%\cmaple8.exe -q -c "n:=%N%:" run.mpl
