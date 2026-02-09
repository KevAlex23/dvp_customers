import 'package:dvp_customers/injection.dart';
import 'package:dvp_customers/main.dart';
import 'package:dvp_customers/presentation/screens/home_screen/customer_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('Render the ', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDependencies();
    await tester.pumpWidget(GetMaterialApp(
      home: CustomerListScreen(),
    ));

    expect(find.byKey(Key("home_appbar")), findsOneWidget);
  });

  testWidgets('Sho', (WidgetTester tester) async {

  });

  testWidgets('Per', (WidgetTester tester) async {

  });
}
