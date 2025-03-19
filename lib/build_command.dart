import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bump/util/version_util.dart';
import 'package:process_run/process_run.dart';
import 'package:yaml_edit/yaml_edit.dart';

class BuildCommand extends Command {
  @override
  String get description => 'Bump build number automatically';

  @override
  String get name => 'build';

  @override
  Future<void> run() async {
    var semanticVersion = await VersionUtil.semanticVersion;
    var from = semanticVersion.toString();
    var argument = argResults?.arguments.firstOrNull;
    if (argument != null) {
      semanticVersion.build = int.tryParse(argument) ?? 0;
    } else {
      try {
        var count = await _countCommit();
        semanticVersion.build = count + 1;
      } catch (e) {
        semanticVersion.build += 1;
      }
    }
    var content = await File('./pubspec.yaml').readAsString();
    var editor = YamlEditor(content);
    editor.update(['version'], semanticVersion.toString());
    var yaml = editor.toString();
    await File('./pubspec.yaml').writeAsString(yaml);
    print('✨ Bump version from $from to $semanticVersion');
  }

  Future<int> _countCommit() async {
    var shell = Shell(verbose: false);
    var result = await shell.run('git rev-list --count HEAD');
    var count = result.first.stdout.toString();
    return int.parse(count);
  }
}
