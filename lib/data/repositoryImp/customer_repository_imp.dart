import 'package:dvp_customers/core/error/failures.dart';
import 'package:dvp_customers/data/datasource/customer_datasource.dart';
import 'package:dvp_customers/data/models/customer_model.dart';
import 'package:dvp_customers/domain/entities/customer.dart';
import 'package:dvp_customers/domain/repositories/customer_repository.dart';

class CustomerRepositoryImp implements CustomerRepository {
  final CustomerDataSource customerDataSource;
  CustomerRepositoryImp({required this.customerDataSource});

  @override
  Future<String?> initDatabase({String? path}) async {
    try {
      return await customerDataSource.initDatabase(path: path);
    } catch (e) {
      return e.toString();
    }
    
  }

  @override
  Future<String?> deleteCustomer(String customerId) async {
    try {
      return await customerDataSource.deleteCustomer(customerId);
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> createCustomer(Customer customer) async {
    try {
      final savedCustomer = await customerDataSource.saveCustomer(CustomerModel.fromEntity(customer));
      return savedCustomer;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<List<Customer>> getAllCustomers() async{
    try {
      final customerModel = await customerDataSource.getCustomers();
      List<Customer> customers = [];
      for (var element in customerModel) {
        customers.add(element.toEntity());
      }
      return customers;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
  
  @override
  Future<String?> deleteDatabase() async {
    try {
      return await customerDataSource.deleteDatabase();
    } catch (e) {
      return e.toString();
    }
  }

}
