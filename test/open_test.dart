import 'dart:io';
import 'package:open/open.dart';
import 'package:test/test.dart';

/// Tests the features of the [open] function.
void main() => group('open()', () {
  test('should open files in the default application', () async {
    await open('test/open_test.dart');
  });

  test('should wait for the application to close', () async {
    await open('https://belin.io', wait: true);
  });

  test('should open URLs in the default application', () async {
    await open('https://belin.io');
  });

  test('should open URLs in the given application', () async {
    await open('https://belin.io', application: 'firefox');
  });

  test('should open URLs in the given application with arguments', () async {
    final chromeApp = Platform.isMacOS ? 'google chrome' : (Platform.isWindows ? 'chrome' : 'google-chrome');
    await open('https://belin.io', application: chromeApp, arguments: ['--incognito']);
  });
});
