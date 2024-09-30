import 'package:test/test.dart';
import 'package:test_coverage_badge/src/badge.dart';
import 'package:test_coverage_badge/src/collector.dart';

void main() {
  group('getBadgeSvg', () {
    test('should correctly generate SVG for provided coverage', () {
      const coverages = <double>[0, 0.25, 0.5, 0.75, 1];

      for (final coverage in coverages) {
        final coverageString = (coverage * 100).toInt().toString();
        final result = getBadgeSvg(coverage);
        final color = getColor(coverage);

        expect(result, contains(coverageString));
        expect(result, contains(color));
      }
    });
  });
}
