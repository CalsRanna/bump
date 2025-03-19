class SemanticVersion {
  int major = 1;
  int minor = 0;
  int patch = 0;
  int build = 1;

  SemanticVersion();

  SemanticVersion.fromString(String version) {
    var parts = version.split('+');
    var build = parts.length >= 2 ? parts[1] : '1';
    parts = parts[0].split('.');
    var major = parts[0];
    var minor = parts.length >= 2 ? parts[1] : '0';
    var patch = parts.length >= 3 ? parts[2] : '0';
    this.major = int.tryParse(major) ?? 1;
    this.minor = int.tryParse(minor) ?? 0;
    this.patch = int.tryParse(patch) ?? 0;
    this.build = int.tryParse(build) ?? 1;
  }

  @override
  String toString() {
    return '$major.$minor.$patch+$build';
  }
}
