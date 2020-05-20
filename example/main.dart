import "package:open/open.dart";

/// Demonstrates the usage of the `open()` function.
Future<void> main() async {
	// Open a URL in the default browser.
	await open("https://belin.io");

	// Open a URL in the given browser.
	await open("https://belin.io", application: "firefox");

	// Open a URL in the given browser, using the specified arguments.
	await open("https://belin.io",
		application: "chrome",
		arguments: ["--incognito"]
	);

	// Open an image in the default viewer
	// and wait for the opened application to quit.
	await open("funny.gif", wait: true);
}
