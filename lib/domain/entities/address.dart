class Address {
  final String id;
  final String address;
  final String suburb;
  final String city;
  final String province;
  final String postalCode;
  final String tag;
  final String country;
  bool isSelected;

  Address({
    required this.id,
    required this.address,
    required this.suburb,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.tag,
    required this.isSelected,
    required this.country,
  });
}
