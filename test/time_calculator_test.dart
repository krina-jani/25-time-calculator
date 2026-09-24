import 'package:flutter_test/flutter_test.dart';
import 'package:time_calculator/utils/time_calculator_logic.dart';

void main() {
  group('TimeCalculatorLogic Unit Tests', () {
    test('1. 1 hour + 30 minutes', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '1',
        minute1Text: '',
        second1Text: '',
        day2Text: '',
        hour2Text: '',
        minute2Text: '30',
        second2Text: '',
        isSubtract: false,
      );
      expect(result.days, 0);
      expect(result.hours, 1);
      expect(result.minutes, 30);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('2. 2 days + 5 hours', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '2',
        hour1Text: '',
        minute1Text: '',
        second1Text: '',
        day2Text: '',
        hour2Text: '5',
        minute2Text: '',
        second2Text: '',
        isSubtract: false,
      );
      expect(result.days, 2);
      expect(result.hours, 5);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('3. 90 seconds + 30 seconds', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '',
        minute1Text: '',
        second1Text: '90',
        day2Text: '',
        hour2Text: '',
        minute2Text: '',
        second2Text: '30',
        isSubtract: false,
      );
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 2);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('4. 90 minutes + 90 minutes', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '',
        minute1Text: '90',
        second1Text: '',
        day2Text: '',
        hour2Text: '',
        minute2Text: '90',
        second2Text: '',
        isSubtract: false,
      );
      expect(result.days, 0);
      expect(result.hours, 3);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('5. 25 hours + 2 hours', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '25',
        minute1Text: '',
        second1Text: '',
        day2Text: '',
        hour2Text: '2',
        minute2Text: '',
        second2Text: '',
        isSubtract: false,
      );
      expect(result.days, 1);
      expect(result.hours, 3);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('6. blank fields treated as 0', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '',
        minute1Text: '',
        second1Text: '',
        day2Text: '',
        hour2Text: '',
        minute2Text: '',
        second2Text: '',
        isSubtract: false,
      );
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('7. subtraction', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '5',
        minute1Text: '30',
        second1Text: '',
        day2Text: '',
        hour2Text: '2',
        minute2Text: '10',
        second2Text: '',
        isSubtract: true,
      );
      expect(result.days, 0);
      expect(result.hours, 3);
      expect(result.minutes, 20);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('8. subtraction resulting in zero', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '1',
        hour1Text: '2',
        minute1Text: '3',
        second1Text: '4',
        day2Text: '1',
        hour2Text: '2',
        minute2Text: '3',
        second2Text: '4',
        isSubtract: true,
      );
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, false);
    });

    test('9. subtraction resulting in negative duration', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '',
        hour1Text: '1',
        minute1Text: '',
        second1Text: '',
        day2Text: '',
        hour2Text: '2',
        minute2Text: '',
        second2Text: '',
        isSubtract: true,
      );
      expect(result.days, 0);
      expect(result.hours, 1);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
      expect(result.isNegative, true);
    });

    test('10. large duration values', () {
      final result = TimeCalculatorLogic.calculate(
        day1Text: '1000',
        hour1Text: '500',
        minute1Text: '3000',
        second1Text: '10000',
        day2Text: '500',
        hour2Text: '200',
        minute2Text: '1000',
        second2Text: '5000',
        isSubtract: false,
      );
      expect(result.days > 0, true);
      expect(result.isNegative, false);
    });
  });
}
