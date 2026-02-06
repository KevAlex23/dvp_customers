import 'package:dvp_customers/presentation/screens/customer/address_form_screen.dart';
import 'package:dvp_customers/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uid/uid.dart';

import '../../../domain/entities/address.dart';
import 'controllers/customer_screen_controller.dart';

class AddressManagementScreen extends StatelessWidget {
  AddressManagementScreen({super.key});

  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _tagController = TextEditingController();
  final _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final viewController = Get.find<CustomerManagementController>();
    _addressController.text = viewController.selectedAddress?.address ?? "";
    _suburbController.text = viewController.selectedAddress?.suburb ?? "";
    _cityController.text = viewController.selectedAddress?.city ?? "";
    _provinceController.text = viewController.selectedAddress?.province ?? "";
    _postalCodeController.text =
        viewController.selectedAddress?.postalCode ?? "";
    _tagController.text = viewController.selectedAddress?.tag ?? "";

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: viewController.selectedAddress == null
            ? "Add Address"
            : "Edit Address",
        actions: [
          (viewController.selectedAddress ==null || viewController.selectedAddress?.isSelected == true)? const SizedBox() : IconButton(
            onPressed: () async {
              await viewController.deleteAddress(
                viewController.selectedAddress!.id,
                viewController.selectedCustomerId!,
              );
              Get.back();
            },
            icon: Icon(Icons.delete_forever_rounded, color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: AddressFormScreen(
                  addressController: _addressController,
                  suburbController: _suburbController,
                  cityController: _cityController,
                  provinceController: _provinceController,
                  postalCodeController: _postalCodeController,
                  tagController: _tagController,
                  countryController: _countryController,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          final address = Address(
                            id:
                                viewController.selectedAddress?.id ??
                                UId.getId(),
                            address: _addressController.text,
                            suburb: _suburbController.text,
                            city: _cityController.text,
                            province: _provinceController.text,
                            postalCode: _postalCodeController.text,
                            tag: _tagController.text,
                            isSelected:
                                viewController.selectedAddress?.isSelected ??
                                false,
                            country: _countryController.text,
                          );

                          String? deleteAddress;
                          String? addAddress;

                          if (viewController.selectedAddress != null) {
                            deleteAddress = await viewController.updateAddress(
                              address,
                              viewController.selectedAddress!.id,
                              viewController.selectedCustomerId!,
                            );
                          } else {
                            addAddress = await viewController.addAddress(
                              address,
                              viewController.selectedCustomerId ?? "",
                            );
                          }

                          viewController.update(['add_customer_view']);
                          if (addAddress == null && deleteAddress == null) {
                            Get.back();
                            Get.snackbar(
                              "Success",
                              "Address added successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.shade600,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.snackbar(
                              "Error",
                              "Failed to add address",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.shade600,
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        viewController.selectedAddress == null
                            ? "Add Address"
                            : 'Update',
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
