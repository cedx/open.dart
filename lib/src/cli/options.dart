part of '../cli.dart';

/// The parsed command line arguments.
@CliOptions()
class Options {

  /// Creates a new options object.
  Options({this.application, this.background, this.help, this.rest, this.version, this.wait});

  /// The application to open the target with.
  @CliOption(abbr: 'a', help: 'The application to open the target with.')
  final String application;

  /// Value indicating whether to not bring the app to the foreground (macOS only).
  @CliOption(abbr: 'b', help: 'Do not bring the application to the foreground (macOS only).', negatable: false)
  final bool background;

  /// Value indicating whether to output usage information.
  @CliOption(abbr: 'h', help: 'Output usage information.', negatable: false)
  final bool help;

  /// The remaining command-line arguments that were not parsed as options or flags.
  final List<String> rest;

  /// Value indicating whether to output the version number.
  @CliOption(abbr: 'v', help: 'Output the version number.', negatable: false)
  final bool version;

  /// Value indicating whether to wait for the opened application to exit.
  @CliOption(abbr: 'w', help: 'Wait for the opened application to exit.', negatable: false)
  final bool wait;
}
