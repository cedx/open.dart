# Application programming interface
This package provides a single function, `open()`, allowing to open a document or URL:

```dart
import "package:open/open.dart";

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
```

The function returns a `Future` for the spawned child process, an instance of the `Process` class.  
You would normally not need to use this for anything, but it can be useful if you'd like to perform operations directly on the spawned process.

?> The function uses the command `start` on Windows, `open` on macOS and `xdg-open` on other platforms.

## Options
The behavior of the `open()` function can be customized using the following optional named parameters.

### String **application**
Specify the application to open the target with.

The application name is platform dependent. For example, Goole Chrome is `chrome` on Windows, `google-chrome` on Linux and `google chrome` on macOS.

You may also pass in the application's full path. For example on Windows Subsystem for Linux, this can be `"/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"`.

```dart
await open("https://belin.io", application: "firefox");
```

### List&lt;String&gt; **arguments**
Specify the arguments to pass when using a custom `application` option.

```dart
await open("https://belin.io", application: "chrome", arguments: ["--incognito"]);
```

### bool **background**
Do not bring the application to the foreground (macOS only).

```dart
await open("spreadsheet.xlsx", background: true);
```

### bool **wait**
Wait for the opened application to exit before completing the `Future`. If `false`, it's completed immediately after opening the application.

```dart
await open("funny.gif", wait: true);
```

?> On Windows, you have to explicitly specify the `application` option for it to be able to wait.
