import 'package:dvp_customers/domain/entities/customer.dart';

abstract class CustomerRepository {
  Future<String?> initDatabase();
  Future<String?> createCustomer(Customer customer);
  Future<List<Customer>> getAllCustomers();
  Future<String?> deleteCustomer(String customerId);
  Future<String?> deleteDatabase();
}