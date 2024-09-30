import 'package:test/test.dart';
import 'package:test_coverage_badge/src/badge.dart';

void main() {
  test('BadgeMetrics.forPercentage returns correct metrics for single digit percentage', () {
    final badgeMetrics = BadgeMetrics.forPercentage(0.05);

    expect(badgeMetrics.width, 88);
    expect(badgeMetrics.rightX, 725);
    expect(badgeMetrics.rightLength, 190);
  });

  test('BadgeMetrics.forPercentage returns correct metrics for double digit percentage', () {
    final badgeMetrics = BadgeMetrics.forPercentage(0.55);

    expect(badgeMetrics.width, 94);
    expect(badgeMetrics.rightX, 755);
    expect(badgeMetrics.rightLength, 250);
  });

  test('BadgeMetrics.forPercentage returns correct metrics for triple digit percentage', () {
    final badgeMetrics = BadgeMetrics.forPercentage(1.0);

    expect(badgeMetrics.width, 102);
    expect(badgeMetrics.rightX, 795);
    expect(badgeMetrics.rightLength, 330);
  });

  // Test for getColor function
  test('getColor returns the correct color at exact keys', () {
    expect(getColor(0.0), '#e05d44');
    expect(getColor(0.5), '#e05d44');
    expect(getColor(0.6), '#dfb317');
    expect(getColor(0.9), '#97ca00');
    expect(getColor(1.0), '#44cc11');
  });

  // Test for Color class toString method
  test('Color toString returns correct hex value', () {
    final color = Color(223, 179, 23);
    expect(color.toString(), '#dfb317');
  });
}