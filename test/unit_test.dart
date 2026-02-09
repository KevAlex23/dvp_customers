import 'package:dvp_customers/core/utils/validator.dart';
import 'package:dvp_customers/data/repositoryImp/customer_repository_imp.dart';
import 'package:dvp_customers/domain/entities/address.dart';
import 'package:dvp_customers/domain/entities/customer.dart';
import 'package:dvp_customers/domain/usecases/customer_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepositoryImp extends Mock implements CustomerRepositoryImp {}

void main() {
  late CustomerUseCase customerUseCase;
  late MockCustomerRepositoryImp mockCustomerRepositoryImp;

  setUp((){
    mockCustomerRepositoryImp = MockCustomerRepositoryImp();
    customerUseCase = CustomerUseCase(mockCustomerRepositoryImp);
  });

  group('EmailValidator', () {
    test('check wrong email format', () {
      final result = Validators.validateEmailFormat('Ab1@');
      expect(result, contains("Invalid email format"));
    });

    test('check email format', () {
      final result = Validators.validateEmailFormat('dvp@dev.co');
      expect(result, null);
    });

  });

  group('Customer tests', (){
    final addressMock = Address(id: "01A", address: "St 28 302-22", suburb: "PM", city: "NJ", province: "NY", postalCode: "10202", tag: "Home", isSelected: true, country: "CO");
    final customerMock = Customer(id: "01", name: "Mock", email: "email@ma.co", lastName: "lastName", birthdate: "2007-02-05", phoneNumber: "3157308010", addresses: [addressMock], countryCode: "CO-+57");
      test('Save customer done', () async {
        

        when(()=> mockCustomerRepositoryImp.createCustomer(customerMock)).thenAnswer((_) async => null);
        final storeCustomer = await customerUseCase.addCustomer(customerMock);
        expect(storeCustomer, null);
      });

      test('check saved customer', () async {
        when(() => mockCustomerRepositoryImp.getAllCustomers()).thenAnswer((_) async => [customerMock]);
        final checkCustomers = await customerUseCase.getAllCustomers();
        final length = checkCustomers?.length??0;
        expect(length, 1);
      });
  });
}