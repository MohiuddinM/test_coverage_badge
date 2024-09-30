class BadgeMetrics {
  const BadgeMetrics({
    this.width = 88,
    this.rightX = 725,
    this.rightLength = 190,
  });

  final int width;
  final int rightX;
  final int rightLength;

  factory BadgeMetrics.forPercentage(double value) {
    final pct = (value * 100).floor();
    if (pct.toString().length == 1) {
      return BadgeMetrics();
    } else if (pct.toString().length == 2) {
      return BadgeMetrics(
        width: 94,
        rightX: 755,
        rightLength: 250,
      );
    } else {
      return BadgeMetrics(
        width: 102,
        rightX: 795,
        rightLength: 330,
      );
    }
  }
}

String getColor(double percentage) {
  final map = {
    0.0: Color(0xE0, 0x5D, 0x44),
    0.5: Color(0xE0, 0x5D, 0x44),
    0.6: Color(0xDF, 0xB3, 0x17),
    0.9: Color(0x97, 0xCA, 0x00),
    1.0: Color(0x44, 0xCC, 0x11),
  };

  double? lower;
  double? upper;
  for (final key in map.keys) {
    if (percentage < key) {
      upper = key;
      break;
    }
    if (key < 1.0) lower = key;
  }
  upper ??= 1.0;
  lower ??= 1.0;
  final lowerColor = map[lower]!;
  final upperColor = map[upper]!;
  final range = upper - lower;
  final rangePct = (percentage - lower) / range;
  final pctLower = 1 - rangePct;
  final pctUpper = rangePct;
  final r = (lowerColor.r * pctLower + upperColor.r * pctUpper).floor();
  final g = (lowerColor.g * pctLower + upperColor.g * pctUpper).floor();
  final b = (lowerColor.b * pctLower + upperColor.b * pctUpper).floor();
  final color = Color(r, g, b);
  return color.toString();
}

class Color {
  final int r, g, b;

  Color(this.r, this.g, this.b);

  @override
  String toString() =>
      '#${((1 << 24) + (r << 16) + (g << 8) + b).toRadixString(16).substring(1)}';
}

const kBadgeTemplate = '''
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="{width}" height="20">
  <linearGradient id="b" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <clipPath id="a">
    <rect width="{width}" height="20" rx="3" fill="#fff"/>
  </clipPath>
  <g clip-path="url(#a)">
    <path fill="#555" d="M0 0h59v20H0z"/>
    <path fill="{color}" d="M59 0h{rightWidth}v20H59z"/>
    <path fill="url(#b)" d="M0 0h{width}v20H0z"/>
  </g>
  <g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="110">
    <text x="305" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="490">coverage</text>
    <text x="305" y="140" transform="scale(.1)" textLength="490">coverage</text>
    <text x="{rightX}" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="{rightLength}">{value}</text>
    <text x="{rightX}" y="140" transform="scale(.1)" textLength="{rightLength}">{value}</text>
  </g>
</svg>
''';
