class Validator {
  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'please fill this field';
    } else {
      return null;
    }
  }

  static String? nameValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 5) {
        return 'Name must be at least 5 character';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? emailValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var isphone = isEmailUsingRegularExpression(value);

      if (isphone) {
        return  null;
        // if (value.toString().length < 9 || value.toString().length > 13) {
        //   return 'phone number must have at least 9 number';
        // } else {
        //   return null;
        // }
      } else {
        return 'invalid email format';
      }
    } else {
      return emptyResult;
    }
  }

  static String? phoneValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var isEmail = isEmailUsingRegularExpression(value);

      if (isEmail) {
        if (value.toString().length < 9 || value.toString().length > 13) {
          return 'phone number must have at least 9 number';
        } else {
          return null;
        }
      } else {
        return 'invalid phone number';
      }
    } else {
      return emptyResult;
    }
  }

  static String? amountValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      try {
        var _ = double.parse(value);
        return null;
      } catch (e) {
        return 'invalid amount';
      }
    } else {
      return emptyResult;
    }
  }

  static bool isEmailUsingRegularExpression(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  static String? passwordValidate(dynamic value) {
    var emptyResult = valueExists(value);

    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 6) {
        return 'Your password must be at least 6 character';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? addressValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 10) {
        return 'Please fill your full address';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? retypePasswordValidate(dynamic value, dynamic firstPass) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 8) {
        return 'Your password must be at least 8 character';
      } else if (value != firstPass) {
        return 'Both password must be the same';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

}
