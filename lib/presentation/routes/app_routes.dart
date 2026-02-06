import 'package:dvp_customers/presentation/screens/customer/address_management_screen.dart';
import 'package:dvp_customers/presentation/screens/customer/customer_addresses_screen.dart';
import 'package:dvp_customers/presentation/screens/customer/customer_info_screen.dart';
import 'package:get/get.dart';

import '../screens/customer/customer_address_form_screen.dart';
import '../screens/customer/customer_management_screen.dart';
import '../screens/home_screen/customer_list_screen.dart';
class RoutePages {
  String homeRoute = '/home';
  String customerInfoRoute = '/customer-info';
  String customerAddRoute = '/customer-add';
  String customerAddressesRoute = '/addresses-list';
  String customerAddressManagementRoute = '/address-management';
  String customerManagementRoute = '/customer-management';
  List<GetPage> appRoutes() => [
      GetPage(
        name: homeRoute,
        page: () => CustomerListScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: customerInfoRoute,
        page: () => CustomerInfoScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: customerAddRoute,
        page: () => ClientFormScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: customerAddressesRoute,
        page: () => CustomerAddressesScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: customerAddressManagementRoute,
        page: () => AddressManagementScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: customerManagementRoute,
        page: () => CustomerManagementScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
      ),
    ];
  
}

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}