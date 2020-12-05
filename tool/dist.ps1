#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)
dart compile exe --output=var/open_cli.exe bin/open_cli.dart
