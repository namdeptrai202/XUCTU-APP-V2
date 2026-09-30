import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuctu/src/app.dart';
import 'package:xuctu/src/data.dart';
import 'package:xuctu/src/models.dart';

void main() {
  test('dummy repository filters resources by grade and category', () {
    const repository = DummyResourceRepository();
    final resources = repository.resourcesForCategory(9, 8);
    expect(resources, isNotEmpty);
    expect(resources.every((item) => item.grade == 9), isTrue);
    expect(resources.every((item) => item.categoryId == 8), isTrue);
    expect(
      resources.map((item) => item.resourceType),
      contains(ResourceType.video),
    );
  });

  testWidgets('first launch selects grade and opens home', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const XuctuApp());
    await tester.pumpAndSettle();
    expect(find.text('Bạn đang học lớp mấy?'), findsOneWidget);
    await tester.tap(find.text('Lớp 9'));
    await tester.pump();
    await tester.tap(find.text('Bắt đầu học'));
    await tester.pumpAndSettle();
    expect(find.text('Sẵn sàng học Toán lớp 9?'), findsOneWidget);
    expect(find.text('Khám phá theo chủ đề'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('saved grade skips grade selection', (tester) async {
    SharedPreferences.setMockInitialValues({'selected_grade': 7});
    await tester.pumpWidget(const XuctuApp());
    await tester.pumpAndSettle();
    expect(find.text('Sẵn sàng học Toán lớp 7?'), findsOneWidget);
    expect(find.text('Bạn đang học lớp mấy?'), findsNothing);
  });
}
