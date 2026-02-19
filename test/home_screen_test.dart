import 'package:dvp_customers/injection.dart';
import 'package:dvp_customers/main.dart';
import 'package:dvp_customers/presentation/screens/home_screen/controllers/customer_list_screen_controller.dart';
import 'package:dvp_customers/presentation/screens/home_screen/customer_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class _Wrapper extends StatelessWidget {
  final Widget child;
  _Wrapper(this.child);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(392.727, 759.272));
    return child;
  }
}

Widget testableWidget({required Widget child}) {
  return MediaQuery(
    data: MediaQueryData(size: Size(392.727, 759.272)),
    child: MyApp(),
  );
}

void main() {
  testWidgets('Render the home page with empty list', (
    WidgetTester tester,
  ) async {
    await initializeDependencies();
    await tester.pumpWidget(testableWidget(child: CustomerListScreen()));
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey('text_empty_list')), findsOneWidget);
  });

  testWidgets('Render the add customer view', (WidgetTester tester) async {
    await initializeDependencies();
    await tester.pumpWidget(testableWidget(child: CustomerListScreen()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('btn_add_customer')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('btn_next_form')), findsOneWidget);
  });

  testWidgets('Validate email format', (
    WidgetTester tester,
  ) async {
    await initializeDependencies();
    await tester.pumpWidget(testableWidget(child: CustomerListScreen()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('btn_add_customer')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('textfield_email_form')).last, 'abc');
    await tester.tap(find.byKey(Key('btn_next_form')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.textContaining('Invalid email format'), findsOneWidget);
  });

}
