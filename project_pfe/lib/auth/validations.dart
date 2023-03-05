  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
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

    String? validatetele(String value) {
    RegExp regex =
        RegExp(r'^(?:[+0]9)?[0-9]{10}$');
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