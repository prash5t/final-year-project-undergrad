class TextFieldValidator {
  static emailValidator(email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return null;
    } else {
      return "Enter valid email address";
    }
  }

  static passwordValidator(password) {
    if (password!.isEmpty || password.length < 6) {
      return "Password length must be atleast 6";
    }

    return null;
  }

  static nameValidator(name) {
    if (name!.isEmpty) {
      return "Name cannot be empty";
    }
    if (name.length < 5) {
      return "Name should be more than 5chars";
    }
    if (name.length > 55) {
      return "Name should be less than 55chars";
    }
  }

  static keyValidator(key) {
    if (key!.isEmpty) {
      return "Key/coupan cannot be empty";
    }
    if (key.length < 5) {
      return "Key/coupan should be more than 5chars";
    }
    if (key.length > 250) {
      return "Key/coupan should be less than 250chars";
    }
  }

  static dataSourceValidator(source, platform) {
    if (platform == "youtube") {
      if (source!.isEmpty) {
        return "Video url cannot be empty";
      }
      if (source.length < 5) {
        return "Url cannot be this small";
      }
      if (source.length > 250) {
        return "Url cannot be longer than 250chars";
      }
    }
    if (platform == "twitter") {
      if (source!.isEmpty) {
        return "Tweet topic cannot be empty";
      }
      if (source.length < 2) {
        return "Tweet topic cannot be this small";
      }
      if (source.length > 250) {
        return "Tweet topic be longer than 250chars";
      }
    }
  }

  static numOfDataValidator(dataCount) {
    try {
      int approx = int.parse(dataCount);
      if ((approx < 20) || (approx > 1000)) {
        return "Range of 20 to 1000 is only allowed for now.";
      }
    } catch (e) {
      return "Enter numeric values only";
    }
  }

  static roleValidator(role) {
    if ((role.length < 3) || (role.length > 50)) {
      return "Length of role should be between 3 to 50";
    }
  }

  static phoneNumberValidator(number) {
    if ((number.length < 5) || (number.length > 20)) {
      return "Length of phone number should be between 5 to 20";
    }
  }

  static descriptionValidator(desc) {
    if (desc.length < 15) {
      return "Description should be atleast 15chars in length";
    }
  }

  static workHrValidator(hr) {
    try {
      int hrs = int.parse(hr);
      if ((hrs < 1) || (hrs > 8)) {
        return "Working hour should be in range of 1 to 8";
      }
    } catch (e) {
      return "Enter numeric values only";
    }
  }

  static wageValidator(wage) {
    if ((wage.length < 2) || (wage.length > 15)) {
      return "Invalid wage/hour format";
    }
  }
}
