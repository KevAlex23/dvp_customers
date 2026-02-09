import 'package:dvp_customers/domain/entities/address.dart';
import 'package:dvp_customers/domain/entities/customer.dart';
import 'package:get/get.dart';

import '../../../../domain/usecases/address_usecase.dart';
import '../../../../domain/usecases/customer_usecase.dart';

class CustomerManagementController extends GetxController {
  final customerUseCase = Get.find<CustomerUseCase>();
  final addressUseCase = Get.find<AddressUseCase>();

  List<Address> addressList = [];
  Address? selectedAddress;
  String? selectedCustomerId;
  Customer? selectedCustomer;

  Future<String?> addCustomer(Customer customer) async {
    return await customerUseCase.addCustomer(customer);
  }

  Future<String?> deleteCustomer(String customerId) async {
    final result = await customerUseCase.deleteCustomer(customerId);
    return result;
  }

  Future updateCustomer(Customer customer) async {
    final deletedCustomer = await deleteCustomer(customer.id);
    if(deletedCustomer == null){
      final result = await addCustomer(customer);
      if(result == null){
        selectedCustomer = customer;
        selectedCustomer!.addresses.addAll(addressList);
      }
    }else{
      return "Failed to update the old customer.";
    }
  }

  Future getAddresses(){
    return addressUseCase.getAddresses(selectedCustomerId!).then((addresses) {
      addressList.clear();
      addressList = addresses;
      update(['customer_addresses_view']);
    });
  }

  Future<String?> addAddress(Address address, String customerId) async {
    final result = await addressUseCase.addAddress(address, customerId);
    return result;
  }

  Future? deleteAddress(String addressId, String customerId) async {
    final result = await addressUseCase.deleteAddress(addressId, customerId);
    return result;
  }

  Future<String?> updateAddress(Address address, String addressId, String customerId) async{
      return deleteAddress(addressId, customerId)?.then((deleteResult) async {
        if (deleteResult == null) {
          return await addAddress(address, customerId);
        } else {
          return "Failed to update the old address.";
        }
      }).catchError((error) {
        return "Error occurred while updating the address: $error";
      });
  }

  Future<String?> setPrincipalAddress(Address address, String addressId, String customerId) async {
    Address currentPrincipalAddress = addressList.firstWhere((addr) => addr.isSelected);
    currentPrincipalAddress.isSelected = false;
    final uncheckPrincipal = await updateAddress(currentPrincipalAddress, currentPrincipalAddress.id, customerId);
    if(uncheckPrincipal == null){
      address.isSelected = true;
      final checkPrincipal = await updateAddress(address, addressId, customerId);
      update(['customer_addresses_view']);
      return checkPrincipal;
    }else{
      return "Failed to unset the current principal address.";
    }
  }
}