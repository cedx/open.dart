part of '../io.dart';

/// Opens the specified [target].
/// Returns the spawned child process.
Future<Process> open(String target, {String application, List<String> arguments, bool background = false, bool wait = false}) async {
  String command;
  final commandArgs = <String>[];
  final isWsl = Platform.isLinux && await isWindowsSubsystemForLinux;
  var mode = ProcessStartMode.normal;

  if (Platform.isMacOS) {
    command = 'open';
    if (wait) commandArgs.add('--wait-apps');
    if (background) commandArgs.add('--background');
    if (application != null) commandArgs..add('-a')..add(application);
    commandArgs.add(target);
    if (arguments != null) commandArgs..add('--args')..addAll(arguments);
  }
  else if (Platform.isWindows || isWsl) {
    command = isWsl ? 'cmd.exe' : 'cmd';
    commandArgs.addAll(['/c', 'start', '""', '/b']);
    if (wait) commandArgs.add('/wait');
    if (application != null) commandArgs.add(isWsl && application.startsWith('/mnt/') ? await resolveWslPath(application) : application);
    if (arguments != null) commandArgs.addAll(arguments);
    commandArgs.add(target.replaceAll('&', '^&'));
  }
  else {
    command = application ?? 'xdg-open';
    if (arguments != null) commandArgs.addAll(arguments);
    if (!wait) mode = ProcessStartMode.detached;
    commandArgs.add(target);
  }

  final process = await Process.start(command, commandArgs, mode: mode);
  return !wait ? process : Future(() async {
    final exitCode = await process.exitCode;
    if (exitCode > 0) throw ProcessException(command, commandArgs, 'Exited with code $exitCode.');
    return process;
  });
}
