part of '../io.dart';

/// Value indicating whether the process is running inside Windows Subsystem for Linux.
@visibleForTesting
Future<bool> get isWindowsSubsystemForLinux async {
  if (!Platform.isLinux) return false;
  if (Platform.operatingSystemVersion.toLowerCase().contains('microsoft')) return true;
  try { return (await File('/proc/version').readAsString()).toLowerCase().contains('microsoft'); }
  on FileSystemException { return false; }
}

/// Resolves the specified WSL [path] to a Windows path.
@visibleForTesting
Future<String> resolveWslPath(String path) async {
  final result = await Process.run('wslpath', ['-w', path], stdoutEncoding: utf8);
  return result.stdout.trim();
}
