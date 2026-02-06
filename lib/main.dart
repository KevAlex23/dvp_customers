import 'package:dvp_customers/injection.dart';
import 'package:dvp_customers/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Customers Management',
      theme: appTheme,
      getPages: RoutePages().appRoutes(),
      initialRoute: RoutePages().homeRoute,
    );
  }
}
