import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vetyo/features/profile/screens/Favorite_screen.dart';

void main() {
  testWidgets('filters veterinarian cards by category and search', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(home: FavoriteScreen()),
      ),
    );
    await tester.pumpAndSettle();

    Finder veterinarianText(String text) =>
        find.descendant(of: find.byType(GridView), matching: find.text(text));

    expect(find.text('Favorite categories'), findsNothing);
    expect(veterinarianText('Dr. Suresh Adhikari'), findsOneWidget);
    expect(veterinarianText('Dr. Ramesh Thapa'), findsOneWidget);
    expect(
      veterinarianText('Kathmandu Pet Clinic, Kathmandu, Nepal'),
      findsOneWidget,
    );
    expect(veterinarianText('(342 reviews)'), findsOneWidget);
    expect(find.byTooltip('Remove from favorites'), findsWidgets);

    await tester.tap(find.byTooltip('Remove from favorites').first);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Add to favorites'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(-200, 0));
    await tester.pumpAndSettle();
    final cattleFilter = find.text('Cattle');
    await tester.tap(cattleFilter);
    await tester.pumpAndSettle();

    expect(veterinarianText('Dr. Ramesh Thapa'), findsOneWidget);
    expect(veterinarianText('Dr. Suresh Adhikari'), findsNothing);

    await tester.drag(find.byType(ListView).first, const Offset(200, 0));
    await tester.pumpAndSettle();
    final generalFilter = find.text('General');
    await tester.tap(generalFilter);
    await tester.pumpAndSettle();

    expect(veterinarianText('Dr. Suresh Adhikari'), findsOneWidget);
    expect(veterinarianText('Dr. Ramesh Thapa'), findsNothing);

    final allFilter = find.text('All');
    await tester.tap(allFilter);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Ramesh');
    await tester.pumpAndSettle();

    expect(veterinarianText('Dr. Ramesh Thapa'), findsOneWidget);
    expect(veterinarianText('Dr. Suresh Adhikari'), findsNothing);

    await tester.enterText(find.byType(TextField), 'agri');
    await tester.pumpAndSettle();
    expect(
      find.text('No veterinarians found in this category'),
      findsOneWidget,
    );
  });
}
