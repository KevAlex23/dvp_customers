import 'package:dvp_customers/presentation/routes/app_routes.dart';
import 'package:dvp_customers/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_app_bar.dart';
import '../home_screen/controllers/customer_list_screen_controller.dart';
import 'controllers/customer_screen_controller.dart';

class CustomerInfoScreen extends StatelessWidget {
  CustomerInfoScreen({super.key});
  final customerViewController = Get.find<CustomerHomeScreenController>();

  @override
  Widget build(BuildContext context) {
    var customer = customerViewController.selectedCustomer;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Customer",
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete customer",
                middleText: "Are you sure you want to delete this customer",
                textConfirm: "Yes, delete",
                textCancel: "Cancel",
                onConfirm: () async {
                  if (await Get.find<CustomerManagementController>().deleteCustomer(customer!.id) != null){
                    Get.snackbar("Deleting customer", "Something was wrong deleting the customer ");
                  }else{
                    Get.back();
                    Get.back();
                  }
                },
              );
            },
            icon: Icon(
              Icons.delete_forever_rounded,
              color: context.theme.colorScheme.error,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(RoutePages().customerManagementRoute)?.whenComplete(
                () {
                  Get.find<CustomerManagementController>().update([
                    'customer_info_view',
                  ]);
                },
              );
            },
            icon: Icon(
              Icons.edit_note_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
      body: GetBuilder(
        id: 'customer_info_view',
        init: CustomerManagementController(),
        builder: (viewController) {
          viewController.selectedCustomer ??= customer;
          customer = viewController.selectedCustomer;
          if (viewController.addressList.isEmpty && customer != null) {
            viewController.addressList.addAll(customer!.addresses);
            viewController.selectedCustomerId = customer!.id;
          }
          final principalAddress = viewController.addressList.firstWhere(
            (test) => test.isSelected,
          );
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${customer?.name ?? "-"} ${customer?.lastName ?? "-"}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Birthdate: ${customer?.birthdate ?? "-"}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        customer?.email ?? "-",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${customer?.countryCode ?? "-"} ${customer?.phoneNumber ?? "-"}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: 'customer_address_tile',
                  child: CustomListTile(
                    title: principalAddress.tag,
                    subtitle:
                        "${principalAddress.address}, ${principalAddress.city}, ${principalAddress.province}",
                    trailingWidget: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Get.toNamed(
                        RoutePages().customerAddressesRoute,
                      )?.whenComplete(() {
                        Get.find<CustomerManagementController>().update([
                          'customer_info_view',
                        ]);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
