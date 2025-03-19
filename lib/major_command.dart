import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bump/util/version_util.dart';
import 'package:yaml_edit/yaml_edit.dart';

class MajorCommand extends Command {
  @override
  String get description => 'Bump major version automatically';

  @override
  String get name => 'major';

  @override
  Future<void> run() async {
    var semanticVersion = await VersionUtil.semanticVersion;
    var from = semanticVersion.toString();
    var argument = argResults?.arguments.firstOrNull;
    if (argument != null) {
      semanticVersion.major = int.tryParse(argument) ?? 1;
    } else {
      semanticVersion.major += 1;
    }
    var content = await File('./pubspec.yaml').readAsString();
    var editor = YamlEditor(content);
    editor.update(['version'], semanticVersion.toString());
    var yaml = editor.toString();
    await File('./pubspec.yaml').writeAsString(yaml);
    print('✨ Bump version from $from to $semanticVersion');
  }
}
