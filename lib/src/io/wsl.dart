part of '../io.dart';

/// Value indicating whether the process is running inside Windows Subsystem for Linux.
Future<bool> get isWindowsSubsystemForLinux async {
  if (!Platform.isLinux) return false;
  if (Platform.operatingSystemVersion.toLowerCase().contains('microsoft')) return true;
  try { return (await File('/proc/version').readAsString()).toLowerCase().contains('microsoft'); }
  on FileSystemException { return false; }
}

/// Resolves the specified WSL [path] to a Windows path.
Future<String> resolveWslPath(String path) async {
  assert(path.isNotEmpty);
  final result = await Process.run('wslpath', ['-w', path], stdoutEncoding: utf8);
  return result.stdout.trim();
}
