import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coachmark/coachmark.dart';

void main() {
  group('Coachmark Widget Tests', () {
    testWidgets('Coachmark renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Coachmark(
              config: const CoachmarkConfig(
                description: 'Test description',
              ),
              child: const Text('Test Child'),
            ),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('Coachmark does not show overlay when isVisible is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Coachmark(
              isVisible: false,
              config: const CoachmarkConfig(
                description: 'Test description',
              ),
              child: const Text('Test Child'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test description'), findsNothing);
    });
  });

  group('CoachmarkConfig Tests', () {
    test('CoachmarkConfig creates with required fields', () {
      const config = CoachmarkConfig(
        description: 'Test',
      );

      expect(config.description, 'Test');
      expect(config.bubbleBackgroundColor, Colors.white);
      expect(config.highlightBorderColor, Colors.green);
    });

    test('CoachmarkConfig copyWith works correctly', () {
      const config = CoachmarkConfig(
        description: 'Test',
      );

      final updatedConfig = config.copyWith(
        description: 'Updated',
        highlightBorderColor: Colors.blue,
      );

      expect(updatedConfig.description, 'Updated');
      expect(updatedConfig.highlightBorderColor, Colors.blue);
      expect(updatedConfig.bubbleBackgroundColor, Colors.white);
    });

    test('CoachmarkConfig has correct default values', () {
      const config = CoachmarkConfig(
        description: 'Test',
      );

      expect(config.highlightBorderWidth, 2.0);
      expect(config.highlightCornerRadius, 12.0);
      expect(config.bubbleCornerRadius, 12.0);
      expect(config.bubbleMaxWidth, 300.0);
      expect(config.spacing, 12.0);
      expect(config.preferredPosition, CoachmarkBubblePosition.auto);
    });
  });

  group('CoachmarkBubblePosition Tests', () {
    test('CoachmarkBubblePosition has all positions', () {
      expect(CoachmarkBubblePosition.values, hasLength(5));
      expect(CoachmarkBubblePosition.values,
          contains(CoachmarkBubblePosition.auto));
      expect(CoachmarkBubblePosition.values,
          contains(CoachmarkBubblePosition.left));
      expect(CoachmarkBubblePosition.values,
          contains(CoachmarkBubblePosition.right));
      expect(CoachmarkBubblePosition.values,
          contains(CoachmarkBubblePosition.top));
      expect(CoachmarkBubblePosition.values,
          contains(CoachmarkBubblePosition.bottom));
    });
  });
}
