import 'package:dvp_customers/presentation/routes/app_routes.dart';
import 'package:dvp_customers/presentation/screens/customer/controllers/customer_screen_controller.dart';
import 'package:dvp_customers/presentation/widgets/custom_app_bar.dart';
import 'package:dvp_customers/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerAddressesScreen extends StatelessWidget {
  const CustomerAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'customer_addresses_view',
      init: Get.find<CustomerManagementController>(),
      builder: (viewController) {
        final principalAddress = viewController.addressList.firstWhere(
          (address) => address.isSelected,
        );
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add_home_work_rounded,
              color: context.theme.colorScheme.secondary,
            ),
            onPressed: () {
              Get.toNamed(
                RoutePages().customerAddressManagementRoute,
              )?.whenComplete(() async {
                await Future.delayed(const Duration(milliseconds: 500));
                await viewController.getAddresses();
              });
            },
          ),
          appBar: customAppBar(
            context: context,
            title: "Addresses",
            actions: [],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Hero(
                  tag: 'customer_address_tile',
                  child: CustomListTile(
                    leading: Icon(
                      Icons.star_purple500_sharp,
                      color: context.theme.colorScheme.secondary,
                    ),
                    title: principalAddress.tag,
                    subtitle:
                        "${principalAddress.address}, ${principalAddress.city}, ${principalAddress.province}",
                    trailingWidget: SizedBox(),
                    onTap: () {},
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewController.addressList.length,
                    itemBuilder: (context, index) {
                      final address = viewController.addressList[index];
                      return CustomListTile(
                        leading: IconButton(
                          onPressed: () async {
                            final setPrincipal = await viewController
                                .setPrincipalAddress(
                                  address,
                                  address.id,
                                  viewController.selectedCustomerId!,
                                );
                            if (setPrincipal == null) {
                              Get.snackbar(
                                "Success",
                                "Address set as principal",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green.shade600,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Failed to set address as principal",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.shade600,
                                colorText: Colors.white,
                              );
                            }
                          },
                          icon: Icon(
                            address.isSelected
                                ? Icons.star_purple500_sharp
                                : Icons.star_border_purple500_outlined,
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        title: address.tag,
                        subtitle:
                            "${address.address}, ${address.city}, ${address.province}",
                        trailingWidget: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: context.theme.colorScheme.primary,
                        ),
                        onTap: () {
                          viewController.selectedAddress = address;
                          Get.toNamed(
                            RoutePages().customerAddressManagementRoute,
                          )?.whenComplete(() async {
                            viewController.selectedAddress = null;
                            await Future.delayed(const Duration(milliseconds: 500));
                            await viewController.getAddresses();
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
