import 'package:dvp_customers/domain/entities/address.dart';

class Customer {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String birthdate;
  final String phoneNumber;
  final String countryCode;
  final List<Address> addresses;

  Customer({required this.id, required this.name, required this.email, required this.lastName, required this.birthdate, required this.phoneNumber, required this.addresses, required this.countryCode});
}