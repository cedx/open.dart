@echo off
set BASE_DIR=%~dp0
dart "%BASE_DIR:~0,-1%\open_cli.dart" %*
