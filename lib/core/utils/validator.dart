class Validators {
  static String? validateEmailFormat(String email){
    return (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email))? 'Invalid email format' : null;
  }
}