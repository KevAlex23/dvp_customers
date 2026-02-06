import 'package:dvp_customers/domain/entities/address.dart';
import 'package:dvp_customers/domain/repositories/address_repository.dart';

import '../../core/error/failures.dart';
import '../datasource/customer_datasource.dart';
import '../models/address_model.dart';

class AddressRepositoryImp implements AddressRepository {
  final CustomerDataSource customerDataSource;
  AddressRepositoryImp({required this.customerDataSource});
  @override
  Future<String?> addAddress(Address address, String customerId) async {
    try {
      final savedCustomer = await customerDataSource.saveAddress(AddressModel.fromEntity(address), customerId);
      return savedCustomer;
    } catch (e) {
      return e.toString();
    }
  }
  
  @override
  Future<String?> deleteAddress(String addressId, String customerId) async {
    try {
      final deletedAddress = await customerDataSource.deleteAddress(addressId, customerId);
      return deletedAddress;
    } catch (e) {
      return e.toString();
    }
  }
  
  @override
  Future<List<Address>> getAddresses(String customerId) async {
    try {
      final addressesModel = await customerDataSource.getAddressesByCustomer(customerId);
      List<Address> addresses = [];
      for (var element in addressesModel) {
        addresses.add(element.toEntity());
      }
      return addresses;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
  
}