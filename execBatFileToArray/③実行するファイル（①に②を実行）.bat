@echo off
rem https://jj-blues.com/cms/wantto-usearray/

setlocal enabledelayedexpansion
 
set n=0
 
for /f %%s in (�@���s�����������񃊃X�g.txt) do (
  set string[!n!]=%%s
  call �A�e������Ɏ��s�������������L�ڂ��Ă�������.bat %%s
)
 
endlocal

pause