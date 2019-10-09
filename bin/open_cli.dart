#!/usr/bin/env dart

// ignore_for_file: avoid_print
import 'dart:io';
import 'package:open/open.dart';
import 'package:open/src/cli.dart';
import 'package:open/src/version.dart';

/// Application entry point.
Future<void> main(List<String> args) async {
  // Parse the command line arguments.
  Options options;

  try {
    options = parseOptions(args);
    if (options.help) {
      print(usage);
      return;
    }

    if (options.version) {
      print(packageVersion);
      return;
    }

    if (options.rest.isEmpty) throw const FormatException('A target must be provided.');
  }

  on FormatException {
    print(usage);
    exitCode = 64;
    return;
  }

  // Run the program.
  try {
    await open(
      options.rest.first,
      application: options.application,
      arguments: args.skipWhile((arg) => arg != '--').skip(1).toList(),
      background: options.background,
      wait: options.wait
    );
  }

  on Exception catch (err) {
    print(err);
    exitCode = 1;
  }
}
