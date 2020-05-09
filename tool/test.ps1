#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

Write-Host 'The test assertions must be verified manually as there is no way to check that they actually opened anything.'
tool/build.ps1
pub run test --coverage=var
