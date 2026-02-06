import 'package:flutter/material.dart';

class AddressFormScreen extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController? suburbController;
  final TextEditingController? cityController;
  final TextEditingController? provinceController;
  final TextEditingController? postalCodeController;
  final TextEditingController? tagController;
  final TextEditingController? countryController;
  const AddressFormScreen({super.key, required this.addressController, required this.suburbController, required this.cityController, required this.provinceController, required this.postalCodeController, required this.tagController, required this.countryController});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10.0),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: suburbController,
            decoration: InputDecoration(
              labelText: 'Suburb',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: cityController,
            decoration: InputDecoration(
              labelText: 'City',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: provinceController,
            decoration: InputDecoration(
              labelText: 'Province',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: postalCodeController,
            decoration: InputDecoration(
              labelText: 'Postal Code',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: tagController,
            decoration: InputDecoration(
              labelText: 'Tag',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}