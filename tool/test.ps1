#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

Write-Host "The test assertions must be verified manually as there is no way to check that they actually opened anything."
pub run build_runner build --delete-conflicting-outputs
pub run test --coverage=var
