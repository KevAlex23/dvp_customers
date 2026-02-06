import 'package:dvp_customers/presentation/screens/customer/customer_form_screen.dart';
import 'package:dvp_customers/presentation/screens/customer/controllers/customer_screen_controller.dart';
import 'package:dvp_customers/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/customer.dart';

class CustomerManagementScreen extends StatelessWidget {
  CustomerManagementScreen({super.key});
  final viewController = Get.find<CustomerManagementController>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController().obs;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = viewController.selectedCustomer?.name ?? "";
    _lastNameController.text = viewController.selectedCustomer?.lastName ?? "";
    _birthDateController.value.text =
        viewController.selectedCustomer?.birthdate ?? "";
    _emailController.text = viewController.selectedCustomer?.email ?? "";
    _phoneController.text = viewController.selectedCustomer?.phoneNumber ?? "";
    _countryController.text =
        viewController.selectedCustomer?.countryCode ?? "CO-+57";

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Edit Customer",
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: CustomerFormScreen(
                  nameController: _nameController,
                  lastNameController: _lastNameController,
                  birthDateController: _birthDateController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  countryController: _countryController,
                  selectedBirthdate: DateTime.parse(_birthDateController.value.text),
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
                          final customer = Customer(
                            id: viewController.selectedCustomer!.id,
                            name: _nameController.text,
                            email: _emailController.text,
                            lastName: _lastNameController.text,
                            birthdate: _birthDateController.value.text,
                            phoneNumber: _phoneController.text,
                            countryCode: _countryController.text,
                            addresses: [],
                          );

                          final addCustomer = await viewController
                              .updateCustomer(customer);
                          if (addCustomer == null) {
                            Get.back();
                            Get.snackbar(
                              "Success",
                              "Customer updated successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.shade600,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.snackbar(
                              "Error",
                              "Failed to update customer",
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
                        'Update',
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
