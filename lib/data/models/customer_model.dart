import 'package:dvp_customers/data/models/address_model.dart';
import 'package:dvp_customers/domain/entities/customer.dart';

class CustomerModel {
  String? id;
  String? name;
  String? lastName;
  String? email;
  String? birthdate;
  String? phoneNumber;
  String? countryCode;
  List<AddressModel>? addresses;

  CustomerModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.birthdate,
    this.phoneNumber,
    this.addresses,
    this.countryCode
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    final jsonAux = json.values.first;
    id = jsonAux['id'];
    name = jsonAux['name'];
    lastName = jsonAux['lastName'];
    email = jsonAux['email'];
    birthdate = jsonAux['birthdate'];
    phoneNumber = jsonAux['phoneNumber'];
    countryCode = jsonAux['countryCode'];
    if (jsonAux['addresses'] != null) {
      addresses = <AddressModel>[];
      jsonAux['addresses'].forEach((v) {
        addresses!.add(AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['birthdate'] = birthdate;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Convert model to domain entity
  Customer toEntity() => Customer(
    id: id!,
    name: name!,
    email: email!,
    lastName: lastName!,
    birthdate: birthdate!,
    phoneNumber: phoneNumber!,
    countryCode: countryCode ?? 'CO+57 ',
    addresses: addresses?.map((toElement)=> toElement.toEntity()).toList()??[],
  );

  // Create model from domain entity
  factory CustomerModel.fromEntity(Customer customer) => CustomerModel(
    id: customer.id,
    name: customer.name,
    lastName: customer.lastName,
    email: customer.email,
    birthdate: customer.birthdate,
    phoneNumber: customer.phoneNumber,
    countryCode: customer.countryCode,
    addresses: customer.addresses.map((toElement)=> AddressModel.fromEntity(toElement)).toList()
  );
}
