import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bump/util/version_util.dart';
import 'package:yaml_edit/yaml_edit.dart';

class PatchCommand extends Command {
  @override
  String get description => 'Bump patch version automatically';

  @override
  String get name => 'patch';

  @override
  Future<void> run() async {
    var semanticVersion = await VersionUtil.semanticVersion;
    var from = semanticVersion.toString();
    var argument = argResults?.arguments.firstOrNull;
    if (argument != null) {
      semanticVersion.patch = int.tryParse(argument) ?? 0;
    } else {
      semanticVersion.patch += 1;
    }
    var content = await File('./pubspec.yaml').readAsString();
    var editor = YamlEditor(content);
    editor.update(['version'], semanticVersion.toString());
    var yaml = editor.toString();
    await File('./pubspec.yaml').writeAsString(yaml);
    print('✨ Bump version from $from to $semanticVersion');
  }
}
