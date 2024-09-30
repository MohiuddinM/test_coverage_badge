import 'package:test/test.dart';
import 'dart:io';

import 'package:test_coverage_badge/test_coverage_badge.dart';

void main() {
  group('calculateLineCoverage', () {
    test('should return correct coverage when all lines are hit', () {
      final lcovReport = File('test/fixtures/full_coverage.lcov');
      final coverage = lineCoverage(lcovReport);
      expect(coverage, 1.0);
    });

    test('should return correct coverage when no lines are hit', () {
      final lcovReport = File('test/fixtures/no_coverage.lcov');
      final coverage = lineCoverage(lcovReport);
      expect(coverage, 0.0);
    });

    test('should return correct coverage for mixed coverage', () {
      final lcovReport = File('test/fixtures/mixed_coverage.lcov');
      final coverage = lineCoverage(lcovReport);
      expect(coverage, closeTo(0.65, 0.02));
    });

    test('should handle null records gracefully', () {
      final lcovReport = File('test/fixtures/null_records.lcov');
      final coverage = lineCoverage(lcovReport);
      expect(coverage, closeTo(0.0, 0.01));
    });

    test('should return 0 if total lines is 0', () {
      final lcovReport = File('test/fixtures/no_lines.lcov');
      final coverage = lineCoverage(lcovReport);
      expect(coverage, 0.0);
    });
  });
}
