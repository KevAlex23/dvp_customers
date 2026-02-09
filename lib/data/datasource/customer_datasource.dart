import 'package:dvp_customers/data/models/address_model.dart';
import 'package:dvp_customers/data/models/customer_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class CustomerDataSource {
  Future<String?> saveCustomer(CustomerModel customer);
  Future<String?> saveAddress(AddressModel address, String customerId);
  Future<List<CustomerModel>> getCustomers();
  Future<List<AddressModel>> getAddressesByCustomer(String customerId);
  Future<String?> initDatabase();
  Future<String?> deleteDatabase();
  Future<String?> deleteAddress(String addressId, String customerId);
  Future<String?> deleteCustomer(String customerId);
}

class CustomerDataSourceImpl implements CustomerDataSource {
  BoxCollection? collection;
  CollectionBox? customersBox;
  CollectionBox? addressesBox;

  @override
  Future<String?> initDatabase() async {
    final applicationsDocumentDirectory =
        await getApplicationDocumentsDirectory();
    var hiveBoxPath = '${applicationsDocumentDirectory.path}/';
    collection = await BoxCollection.open('database', {
      'customers',
      'address',
    }, path: hiveBoxPath);
    customersBox = await collection?.openBox<Map>('customers');
    addressesBox = await collection?.openBox<Map>('address');
    return null;
  }

  CustomerDataSourceImpl();

  @override
  Future<String?> saveCustomer(CustomerModel customer) async {
    await customersBox?.put(customer.id!, customer.toJson());
    return null;
  }

  @override
  Future<String?> saveAddress(AddressModel address, String customerId) async {
    final existingAddresses = await addressesBox?.get(customerId);
    if (existingAddresses != null) {
      List<Map> addressesList =
          List<Map>.from(existingAddresses['addresses']);
      addressesList.add(address.toJson());
      await addressesBox?.delete(customerId);
      await addressesBox?.put(customerId, {"addresses": addressesList});
    } else {
      await addressesBox?.put(customerId, {
        "addresses": [address.toJson()],
      });
    }
    return null;
  }

  @override
  Future<List<CustomerModel>> getCustomers() async {
    final customerResult = (await customersBox?.getAllValues())?.entries
        .map(
          (toElement) =>
              CustomerModel.fromJson({toElement.key: toElement.value}),
        )
        .toList();
    if (customerResult != null) {
      for (var customer in customerResult) {
        customer.addresses = await getAddressesByCustomer(customer.id!);
      }
    }

    return customerResult ?? <CustomerModel>[];
  }

  @override
  Future<List<AddressModel>> getAddressesByCustomer(String customerId) async {
    final result = await addressesBox?.get(customerId);
    if (result != null) {
      return result['addresses']
          .map<AddressModel>(
            (addressJson) => AddressModel.fromJson(addressJson),
          )
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<String?> deleteDatabase() async {
    await customersBox?.clear();
    await addressesBox?.clear();
    return null;
  }
  
  @override
  Future<String?> deleteAddress(String addressId, String customerId) async {
    final existingAddresses = await addressesBox?.get(customerId);
    if (existingAddresses != null) {
      List<Map> addressesList = List<Map>.from(existingAddresses['addresses']);
      addressesList.removeWhere((address) => address['id'] == addressId);
      await addressesBox?.delete(customerId);
      await addressesBox?.put(customerId, {"addresses": addressesList});
    }
    return null;
  }
  
  @override
  Future<String?> deleteCustomer(String customerId) async {
    await customersBox?.delete(customerId);
    return null;
  }
}
