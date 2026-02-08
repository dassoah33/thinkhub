import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:thinkhub/main.dart';

void main() {
  testWidgets('ThinkHub app launches', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ThinkHubApp()),
    );
    expect(find.text('ThinkHub'), findsOneWidget);
  });
}
