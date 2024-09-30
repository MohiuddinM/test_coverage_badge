import 'dart:io';

import 'badge.dart';

/// Runs Flutter tests with coverage enabled in the specified package root.
///
/// Returns `true` if the tests run successfully (exit code 0), otherwise, `false`.
Future<bool> runTestsWithCoverage(String packageRoot) async {
  final result = await Process.start(
    'flutter',
    ['test', '--coverage'],
    workingDirectory: packageRoot,
    mode: ProcessStartMode.inheritStdio,
    runInShell: true
  );

  return (await result.exitCode) == 0;
}

/// Parses the provided LCOV file to calculate the line coverage.
///
/// If the file cannot be read or parsed, the function returns 0.0.
double lineCoverage(File file) {
  final lcov = file.readAsStringSync();

  try {
    final lines = lcov.split('\n');
    int foundLines = 0;
    int hitLines = 0;

    for (final line in lines) {
      if (line.startsWith('DA:')) {
        foundLines++;
        final parts = line.split(',');
        if (int.parse(parts[1]) > 0) {
          hitLines++;
        }
      }
    }

    if (foundLines == 0) {
      return 0.0;
    }

    return hitLines / foundLines;
  } catch (e) {
    return 0.0;
  }
}

String getBadgeSvg(double lineCoverage) {
  const leftWidth = 59;
  final value = '${(lineCoverage * 100).floor()}%';
  final color = getColor(lineCoverage);
  final metrics = BadgeMetrics.forPercentage(lineCoverage);
  final rightWidth = metrics.width - leftWidth;
  final content = kBadgeTemplate
      .replaceAll('{width}', metrics.width.toString())
      .replaceAll('{rightWidth}', rightWidth.toString())
      .replaceAll('{rightX}', metrics.rightX.toString())
      .replaceAll('{rightLength}', metrics.rightLength.toString())
      .replaceAll('{color}', color.toString())
      .replaceAll('{value}', value.toString());
  return content;
}
