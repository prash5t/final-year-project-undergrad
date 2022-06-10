import 'dart:convert';
import 'api_universal.dart';

const String loginEndPoint = "$domain/login/";

const String registerEndPoint = "$domain/register/";

Future requestProfile() async {
  return blocResponder(await getGETResponse("$domain/profile/"));
}

Future requestLogin(String email, String password) async {
  var requestBody =
      jsonEncode(<String, String>{"email": email, "password": password});
  return blocResponder(
      await getResponse(loginEndPoint, requestHeader, requestBody));
}

Future requestRegister(name, email, password, purpose) async {
  var requestBody = jsonEncode(<String, String>{
    "name": name,
    "purpose": purpose,
    "email": email,
    "password": password
  });
  return blocResponder(
      await getResponse(registerEndPoint, requestHeader, requestBody));
}
