import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vetyo/features/vets/widgets/fact_section.dart';

void main() {
  testWidgets('renders descriptions without quoted text', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder:
            (context, child) =>
                const MaterialApp(home: Scaffold(body: FactSection())),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Description text for the second fact\nitem',
        findRichText: true,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
