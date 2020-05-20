import "dart:io" as io;
import "package:open/open.dart";
import "package:test/test.dart";

/// Tests the features of the [open] function.
void main() => group("open()", () {
	final googleChrome = io.Platform.isMacOS ? "google chrome" : (io.Platform.isWindows ? "chrome" : "google-chrome");
	const googleChromeWsl = "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe";

	bool isWsl;
	setUpAll(() async => isWsl ??= await Platform.isWindowsSubsystemForLinux);

	test("should open files in the default application", () async {
		await open("test/open_test.dart");
	});

	test("should open URLs in the default application", () async {
		await open("https://belin.io");
	});

	test("should open URLs in the given application", () async {
		await open("https://belin.io", application: "firefox");
	});

	test("should open URLs in the given application with arguments", () async {
		await open("https://belin.io", application: googleChrome, arguments: ["--incognito"]);
	});

	test("should wait for the given application to close", () async {
		await open("https://belin.io", application: googleChrome, wait: true);
	}, timeout: Timeout.none);

	test("should open URLs in the specified application by using a given WSL path", () async {
		if (isWsl) await open("https://belin.io", application: googleChromeWsl);
	});

	test("should open URLs in the specified application with arguments by using a given WSL path", () async {
		if (isWsl) await open("https://belin.io", application: googleChromeWsl, arguments: ["--incognito"]);
	});
});
