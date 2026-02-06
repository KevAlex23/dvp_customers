import 'package:dvp_customers/domain/entities/address.dart';

abstract class AddressRepository {
  Future<String?> addAddress(Address address, String customerId);
  Future<String?> deleteAddress(String addressId, String customerId);
  Future<List<Address>> getAddresses(String customerId);
}