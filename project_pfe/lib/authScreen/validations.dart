String? validatePassword(String value) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return "Enter valid password exemple 'Helloworld2023'";
    } else {
      return null;
    }
  }
}

String? validateEmail(String value) {
  RegExp reg = RegExp(r'^[a-z0-9]+@[a-z].[a-z]');
  if (value.isEmpty) {
    return 'Please entre your Email';
  } else {
    if (reg.hasMatch(value)) {
      return null;
    } else
      return 'Your Email is incorrect';
  }
}

String? validatetele(String value) {
  RegExp regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  if (value.isEmpty) {
    return 'Please enter Phone number';
  } else {
    if (!regex.hasMatch(value)) {
      return "Enter valid number phone";
    } else {
      return null;
    }
  }
}
