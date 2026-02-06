import 'package:dvp_customers/domain/entities/address.dart';

class AddressModel {
  final String id;
  final String address;
  final String province;
  final String city;
  final String suburb;
  final String postalCode;
  final String country;
  final String tag;
  final bool isSelected;

  AddressModel({
    required this.id,
    required this.address,
    required this.city,
    required this.suburb,
    required this.postalCode,
    required this.country,
    required this.province,
    required this.tag,
    required this.isSelected,
  });

  factory AddressModel.fromJson(Map json) {
    return AddressModel(
      id: json['id'],
      address: json['address'] as String,
      city: json['city'] as String,
      suburb: json['suburb'] as String,
      postalCode: json['postal_code'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
      tag: json['tag'] as String,
      isSelected: json['is_selected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'city': city,
      'suburb': suburb,
      'postal_code': postalCode,
      'country': country,
      'province': province,
      'tag': tag,
      'is_selected': isSelected,
    };
  }

  // Convert model to domain entity
  Address toEntity() => Address(
    id: id,
    address: address,
    suburb: suburb,
    city: city,
    province: province,
    postalCode: postalCode,
    tag: tag,
    isSelected: isSelected,
    country: country,
  );

  // Create model from domain entity
  factory AddressModel.fromEntity(Address addressAux) => AddressModel(
    id: addressAux.id,
    address: addressAux.address,
    city: addressAux.city,
    suburb: addressAux.suburb,
    postalCode: addressAux.postalCode,
    country: addressAux.country,
    province: addressAux.province,
    tag: addressAux.tag,
    isSelected: addressAux.isSelected,
  );
}
