import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/customer.dart';
import '../../../../domain/usecases/customer_usecase.dart';

class CustomerHomeScreenController extends GetxController {
  final customerUseCase = Get.find<CustomerUseCase>();
  BuildContext? context;

  List<Customer> customers = [];

  Customer? selectedCustomer;

  //view states
  bool isLoading = false;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading = true;
    update(["customers_list_view"]);
    await Future.delayed(Duration(seconds: 1));
    await getAllCustomers();
    isLoading = false;
    update(["customers_list_view"]);
  }

  Future getAllCustomers() async {
    try {
      customers = await customerUseCase.getAllCustomers() ?? [];
      update(["customers_list_view"]);
      return customers;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load data",
        backgroundColor: context!.theme.colorScheme.error,
      );
    }
  }

  Future deleteDatabase(){
    return customerUseCase.deleteDatabase();
  }

}
