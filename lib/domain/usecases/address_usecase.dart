import 'package:dvp_customers/domain/entities/address.dart';

import '../repositories/address_repository.dart';

class AddressUseCase {
  final AddressRepository repository;

  AddressUseCase(this.repository);

  Future<String?> addAddress(Address address, String customerId) async {
    return await repository.addAddress(address, customerId);
  }

  Future<String?> deleteAddress(String addressId, String customerId){
    return repository.deleteAddress(addressId, customerId);
  }

  Future<List<Address>> getAddresses(String customerId) async {
    return await repository.getAddresses(customerId);
  }
}