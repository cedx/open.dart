#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

$appdata = [Environment]::GetFolderPath([Environment+SpecialFolder]::ApplicationData)
$rcedit = [Environment]::Is64BitOperatingSystem ? "rcedit-x64" : "rcedit"
$version = (Select-String "version: (\d+(\.\d+){2})" pubspec.yaml).Matches.Groups[1].Value

dart compile exe --output=var/open_cli.exe bin/open_cli.dart
& "$appdata/npm/node_modules/rcedit/bin/$rcedit.exe" var/open_cli.exe `
	--set-icon docs/favicon.ico `
	--set-file-version "$version" `
	--set-product-version "$version" `
	--set-version-string CompanyName "Belin.io" `
	--set-version-string FileDescription "Open.dart $version" `
	--set-version-string LegalCopyright "Copyright (c) 2019 - 2021 Cédric Belin" `
	--set-version-string OriginalFilename "open_cli.exe" `
	--set-version-string ProductName "Open.dart"
