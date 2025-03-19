import 'dart:io';

import 'package:bump/model/semantic_version.dart';
import 'package:yaml/yaml.dart';

class VersionUtil {
  static Future<SemanticVersion> get semanticVersion async {
    var specification = loadYaml(await File('./pubspec.yaml').readAsString());
    var version = specification['version'].toString();
    return SemanticVersion.fromString(version);
  }
}
