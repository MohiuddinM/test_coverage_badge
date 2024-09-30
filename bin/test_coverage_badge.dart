import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:test_coverage_badge/test_coverage_badge.dart';

Future main(List<String> args) async {
  final package = Directory.current;

  final parser = ArgParser();
  parser.addFlag(
    'help',
    abbr: 'h',
    help: 'Show usage',
    negatable: false,
  );
  parser.addOption(
    'file',
    abbr: 'f',
    help:
        'Path to test coverage file file (this will be generated if not provided)',
  );

  final results = parser.parse(args);

  final help = results.flag('help');
  if (help) {
    print(parser.usage);
    return;
  }

  final lcovPath = results.option('file');
  if (lcovPath == null) {
    final success = await runTestsWithCoverage(package.path);

    if (!success) {
      print('tests failed');
      return exit(-1);
    }
  }

  final lcovFile = File(lcovPath ?? 'coverage/lcov.info');
  final coverage = lineCoverage(lcovFile);
  final svg = getBadgeSvg(coverage);
  File(join(package.path, 'coverage_badge.svg')).writeAsStringSync(svg);
}
