import 'package:flutter_test/flutter_test.dart';
import 'package:time_calculator/main.dart';

void main() {
  testWidgets('Time Calculator smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TimeCalculatorApp());

    // Verify Time Calculator title exists
    expect(find.text('Time Calculator'), findsWidgets);
    expect(find.text('Calculate'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
  });
}
