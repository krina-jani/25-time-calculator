class TimeResult {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool isNegative;
  final bool hasCalculated;

  const TimeResult({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.isNegative = false,
    this.hasCalculated = false,
  });

  factory TimeResult.empty() {
    return const TimeResult(hasCalculated: false);
  }

  /// Formatted string representation for clean display
  String get formattedText {
    if (!hasCalculated) return '';
    final sign = isNegative ? '-' : '';
    List<String> parts = [];
    parts.add('$days ${days == 1 ? "Day" : "Days"}');
    parts.add('$hours ${hours == 1 ? "Hour" : "Hours"}');
    parts.add('$minutes ${minutes == 1 ? "Minute" : "Minutes"}');
    parts.add('$seconds ${seconds == 1 ? "Second" : "Seconds"}');
    return '$sign ${parts.join(" ")}'.trim();
  }
}

class TimeCalculatorLogic {
  static const int secondsInMinute = 60;
  static const int secondsInHour = 3600;
  static const int secondsInDay = 86400;

  /// Parses input string to integer, defaulting to 0 for empty or invalid strings.
  static int parseInput(String text) {
    if (text.trim().isEmpty) return 0;
    final parsed = int.tryParse(text.trim());
    if (parsed == null || parsed < 0) return 0;
    return parsed;
  }

  /// Calculates addition or subtraction of two time values.
  static TimeResult calculate({
    required String day1Text,
    required String hour1Text,
    required String minute1Text,
    required String second1Text,
    required String day2Text,
    required String hour2Text,
    required String minute2Text,
    required String second2Text,
    required bool isSubtract,
  }) {
    final d1 = parseInput(day1Text);
    final h1 = parseInput(hour1Text);
    final m1 = parseInput(minute1Text);
    final s1 = parseInput(second1Text);

    final d2 = parseInput(day2Text);
    final h2 = parseInput(hour2Text);
    final m2 = parseInput(minute2Text);
    final s2 = parseInput(second2Text);

    final totalSec1 = (d1 * secondsInDay) + (h1 * secondsInHour) + (m1 * secondsInMinute) + s1;
    final totalSec2 = (d2 * secondsInDay) + (h2 * secondsInHour) + (m2 * secondsInMinute) + s2;

    final resultSec = isSubtract ? (totalSec1 - totalSec2) : (totalSec1 + totalSec2);

    final bool isNeg = resultSec < 0;
    final int absSec = resultSec.abs();

    final days = absSec ~/ secondsInDay;
    final remDay = absSec % secondsInDay;

    final hours = remDay ~/ secondsInHour;
    final remHour = remDay % secondsInHour;

    final minutes = remHour ~/ secondsInMinute;
    final seconds = remHour % secondsInMinute;

    return TimeResult(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      isNegative: isNeg,
      hasCalculated: true,
    );
  }
}
