import 'package:dvp_customers/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomerFormScreen extends StatelessWidget {
  CustomerFormScreen({
    super.key,
    required TextEditingController nameController,
    required TextEditingController lastNameController,
    required Rx<TextEditingController> birthDateController,
    DateTime? selectedBirthdate,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController countryController,
  }) : _nameController = nameController,
       _lastNameController = lastNameController,
       _birthDateController = birthDateController,
       _selectedBirthdate = selectedBirthdate,
       _emailController = emailController,
       _phoneController = phoneController,
       _countryController = countryController;

  final TextEditingController _nameController;
  final TextEditingController _lastNameController;
  final Rx<TextEditingController> _birthDateController;
  DateTime? _selectedBirthdate;
  final TextEditingController _emailController;
  final TextEditingController _phoneController;
  final TextEditingController _countryController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
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
              return 'Please enter a name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _lastNameController,
          decoration: InputDecoration(
            labelText: 'Last Name',
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
              return 'Please enter a last name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              _selectedBirthdate = pickedDate;
              _birthDateController.value.text =
                  '${_selectedBirthdate?.year}-${_selectedBirthdate?.month.toString().padLeft(2, '0')}-${_selectedBirthdate?.day.toString().padLeft(2, '0')}';
            }
          },
          child: AbsorbPointer(
            child: Obx(() {
              return TextFormField(
                enabled: false,
                controller: _birthDateController.value,
                decoration: InputDecoration(
                  label: Text('Select your birthdate'),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (_selectedBirthdate == null) {
                    return 'Please select a birthdate';
                  }
                  final age = DateTime.now().year - _selectedBirthdate!.year;
                  if (age < 18 || age > 100) {
                    return 'Age must be between 18 and 100';
                  }
                  return null;
                },
              );
            }),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: Key('textfield_email_form'),
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email';
            }
            Validators.validateEmailFormat(value);
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        IntlPhoneField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          initialCountryCode: _countryController.text.isEmpty? 'CO': _countryController.text.split('-').first,
          onChanged: (phone) {
            _countryController.text = "${phone.countryISOCode}-${phone.countryCode}";
          },
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value == null ||
                value.completeNumber.isEmpty ||
                value.number.isEmpty) {
              return 'Please enter a phone number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
