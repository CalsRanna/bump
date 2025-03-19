import 'package:args/command_runner.dart';
import 'package:bump/build_command.dart';
import 'package:bump/major_command.dart';
import 'package:bump/minor_command.dart';
import 'package:bump/patch_command.dart';
import 'package:bump/version_command.dart';

Future<void> main(List<String> arguments) async {
  var executable = 'bump';
  var description = 'Bump version automatically';
  var runner =
      CommandRunner(executable, description)
        ..addCommand(MajorCommand())
        ..addCommand(MinorCommand())
        ..addCommand(PatchCommand())
        ..addCommand(BuildCommand())
        ..addCommand(VersionCommand());
  runner.argParser.addFlag(
    'version',
    abbr: 'v',
    negatable: false,
    help: 'Print the current version.',
  );
  var args = _filterVersionArgument(arguments);
  await runner.run(args);
}

List<String> _filterVersionArgument(List<String> arguments) {
  if (arguments.length != 1) return arguments;
  var argument = arguments.first;
  if (argument == '--version' || argument == '-v') return ['version'];
  return arguments;
}
