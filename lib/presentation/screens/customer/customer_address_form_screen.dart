import 'package:dvp_customers/domain/entities/address.dart';
import 'package:dvp_customers/domain/entities/customer.dart';
import 'package:dvp_customers/presentation/screens/customer/address_form_screen.dart';
import 'package:dvp_customers/presentation/screens/customer/controllers/customer_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uid/uid.dart';

import '../../widgets/custom_app_bar.dart';
import 'customer_form_screen.dart';


class ClientFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController().obs;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _tagController = TextEditingController();
  final _countryController = TextEditingController();

  DateTime? _selectedBirthdate;

  final _pageController = PageController();

  ClientFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageList = <Widget>[
      CustomerFormScreen(
        nameController: _nameController,
        lastNameController: _lastNameController,
        birthDateController: _birthDateController,
        selectedBirthdate: _selectedBirthdate,
        emailController: _emailController,
        phoneController: _phoneController,
        countryController: _countryController,
      ),
      AddressFormScreen(
        addressController: _addressController,
        suburbController: _suburbController,
        cityController: _cityController,
        provinceController: _provinceController,
        postalCodeController: _postalCodeController,
        tagController: _tagController,
        countryController: _countryController,
      ),
    ];

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Add customer",
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: GetBuilder(
            init: CustomerManagementController(),
            id: "add_customer_view",
            builder: (viewController) {
              return PageView.builder(
                controller: _pageController,
                itemCount: pageList.length,
                itemBuilder: (_, pageIndex) {
                  return Column(
                    children: [
                      Expanded(child: pageList[pageIndex]),
                      pageIndex == 0
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          if (pageIndex == 0) {
                                            _pageController.nextPage(
                                              duration: Duration(
                                                milliseconds: 1,
                                              ),
                                              curve: Curves.bounceIn,
                                            );
                                            viewController.update([
                                              'add_customer_view',
                                            ]);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Next',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                              color: context
                                                  .theme
                                                  .colorScheme
                                                  .surface,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            _pageController.previousPage(
                                              duration: Duration(
                                                milliseconds: 1,
                                              ),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).primaryColor,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Go Back',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .surface,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              final customerId = UId.getId();
                                              final customer = Customer(
                                                id: customerId,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                lastName:
                                                    _lastNameController.text,
                                                birthdate: _birthDateController
                                                    .value
                                                    .text,
                                                phoneNumber:
                                                    _phoneController.text,
                                                    countryCode: _countryController.text,
                                                addresses: [],
                                              );
                                              final address = Address(
                                                id: UId.getId(),
                                                address:
                                                    _addressController.text,
                                                suburb: _suburbController.text,
                                                city: _cityController.text,
                                                province:
                                                    _provinceController.text,
                                                postalCode:
                                                    _postalCodeController.text,
                                                tag: _tagController.text,
                                                isSelected: true,
                                                country:
                                                    _countryController.text,
                                              );

                                              final addCustomer =
                                                  await viewController
                                                      .addCustomer(customer);
                                              final addAddress =
                                                  await viewController
                                                      .addAddress(
                                                        address,
                                                        customerId,
                                                      );
                                              viewController.update([
                                                'add_customer_view',
                                              ]);
                                              if (addAddress == null &&
                                                  addCustomer == null) {
                                                Get.back();
                                                Get.snackbar(
                                                  "Success",
                                                  "Customer added successfully",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor:
                                                      Colors.green.shade600,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.snackbar(
                                                  "Error",
                                                  "Failed to add customer",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor:
                                                      Colors.red.shade600,
                                                  colorText: Colors.white,
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).primaryColor,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Save',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .surface,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}