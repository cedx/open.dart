part of '../open.dart';

/// Value indicating whether the process is running inside Windows Subsystem for Linux.
Future<bool> get isWindowsSubsystemForLinux async {
  if (!Platform.isLinux) return false;
  if (Platform.operatingSystemVersion.toLowerCase().contains('microsoft')) return true;
  try { return (await File('/proc/version').readAsString()).toLowerCase().contains('microsoft'); }
  on FileSystemException { return false; }
}
