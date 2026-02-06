import 'package:dvp_customers/domain/entities/customer.dart';
import 'package:dvp_customers/domain/repositories/customer_repository.dart';

class CustomerUseCase {
  final CustomerRepository repository;

  CustomerUseCase(this.repository);

  Future<String?> initDatabase({String? path}){
    return repository.initDatabase(path: path);
  }

  Future<List<Customer>?> getAllCustomers() async {
    final result = await repository.getAllCustomers();
    return result;
  }

  Future<String?> addCustomer(Customer customer){
    return repository.createCustomer(customer);
  }

  Future<String?> deleteDatabase() async {
    return await repository.deleteDatabase();
  }

  Future<String?> deleteCustomer(String customerId) async {
    return await repository.deleteCustomer(customerId);
  }
}