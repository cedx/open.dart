part of '../io.dart';

/// Opens the specified [target].
/// Returns the spawned child process.
Future<io.Process> open(String target, {String application, Iterable<String> arguments, bool background = false, bool wait = false}) async {
  assert(target.isNotEmpty);

  String command;
  final commandArgs = <String>[];
  final isWsl = await Platform.isWindowsSubsystemForLinux;
  var mode = io.ProcessStartMode.normal;

  if (io.Platform.isMacOS) {
    command = 'open';
    if (wait) commandArgs.add('--wait-apps');
    if (background) commandArgs.add('--background');
    if (application != null) commandArgs..add('-a')..add(application);
    commandArgs.add(target);
    if (arguments != null) commandArgs..add('--args')..addAll(arguments);
  }
  else if (io.Platform.isWindows || isWsl) {
    command = 'cmd.exe';
    commandArgs.addAll(['/c', 'start', '', '/b']);
    if (wait) commandArgs.add('/wait');
    if (application != null) commandArgs.add(isWsl && application.startsWith('/mnt/') ? await Platform.resolveWslPath(application) : application);
    if (arguments != null) commandArgs.addAll(arguments);
    commandArgs.add(target.replaceAll('&', '^&'));
  }
  else {
    final packageUri = await Isolate.resolvePackageUri(Uri.parse('package:open/'));
    command = application ?? (!io.Platform.isAndroid && !io.Platform.isIOS ? packageUri.resolve('../bin/xdg-open').toFilePath() : 'xdg-open');
    if (arguments != null) commandArgs.addAll(arguments);
    if (!wait) mode = io.ProcessStartMode.detached;
    commandArgs.add(target);
  }

  final process = await io.Process.start(command, commandArgs, mode: mode);
  return !wait ? process : Future(() async {
    final exitCode = await process.exitCode;
    if (exitCode != 0) throw io.ProcessException(command, commandArgs, 'Exited with code $exitCode.');
    return process;
  });
}
