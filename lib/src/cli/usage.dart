part of '../cli.dart';

/// The usage information.
final String usage = (StringBuffer()
  ..writeln('Open whatever you want, such as URLs, files or executables, regardless of the platform you use.')
  ..writeln()
  ..writeln('Usage: open_cli [options]')..writeln()
  ..writeln('Options:')
  ..write(argParser.usage))
  .toString();
