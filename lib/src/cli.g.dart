// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cli.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

Options _$parseOptionsResult(ArgResults result) => Options(
    application: result['application'] as String,
    background: result['background'] as bool,
    help: result['help'] as bool,
    rest: result.rest,
    version: result['version'] as bool,
    wait: result['wait'] as bool);

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addOption('application',
      abbr: 'a', help: 'The application to open the target with.')
  ..addFlag('background',
      abbr: 'b',
      help: 'Do not bring the application to the foreground (macOS).',
      negatable: false)
  ..addFlag('help',
      abbr: 'h', help: 'Output usage information.', negatable: false)
  ..addFlag('version',
      abbr: 'v', help: 'Output the version number.', negatable: false)
  ..addFlag('wait',
      abbr: 'w',
      help: 'Wait for the opened application to exit.',
      negatable: false);

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
