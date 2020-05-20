// ignore_for_file: avoid_classes_with_only_static_members
part of "../io.dart";

/// Information about the environment in which the current program is running.
abstract class Platform {

	/// Value indicating whether the process is running inside Docker.
	static bool _isDocker;

	/// Value indicating whether the process is running inside Windows Subsystem for Linux.
	static bool _isWindowsSubsystemForLinux;

	/// Value indicating whether the process is running inside Docker.
	static Future<bool> get isDocker async {
		if (_isDocker == null) {
			if (io.File("/.dockerenv").existsSync()) _isDocker = true;
			else
				try { _isDocker = (await io.File("/proc/self/cgroup").readAsString()).contains("docker"); }
				on io.FileSystemException { _isDocker = false; }
		}

		return _isDocker;
	}

	/// Value indicating whether the process is running inside Windows Subsystem for Linux.
	static Future<bool> get isWindowsSubsystemForLinux async {
		if (_isWindowsSubsystemForLinux == null) {
			if (!io.Platform.isLinux) _isWindowsSubsystemForLinux = false;
			else if (io.Platform.operatingSystemVersion.toLowerCase().contains("microsoft")) _isWindowsSubsystemForLinux = !(await isDocker);
			else
				try { _isWindowsSubsystemForLinux = (await io.File("/proc/version").readAsString()).toLowerCase().contains("microsoft") && !(await isDocker); }
				on io.FileSystemException { _isWindowsSubsystemForLinux = false; }
		}

		return _isWindowsSubsystemForLinux;
	}

	/// Resolves the specified WSL [path] to a Windows path.
	static Future<String> resolveWslPath(String path) async {
		assert(path.isNotEmpty);
		return (await io.Process.run("wslpath", ["-w", path])).stdout.trim();
	}
}
