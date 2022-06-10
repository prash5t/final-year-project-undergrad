import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sentimento/utilities/securestorage.dart';

const String domain = "https://sentimentofyp.herokuapp.com";

const requestHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

//to get response from backend (POST request)
getResponse(endPoint, header, body) async {
  final response =
      await http.post(Uri.parse(endPoint), headers: header, body: body);
  return response;
}

//to get response from JWT protected POST request
getPostResponse(endPoint, body) async {
  String? token = await secureStorage?.read(key: 'access-token');
  var headerwithToken = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };
  final response = await http.post(Uri.parse(endPoint),
      headers: headerwithToken, body: body);
  return response;
}

//to get (GET request)
getGETResponse(endPoint) async {
  String? token = await secureStorage?.read(key: 'access-token');
  var headerwithToken = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };
  final response =
      await http.get(Uri.parse(endPoint), headers: headerwithToken);
  return response;
}

//to handle post/vacancy delete request of user
getDELETEResponse(endPoint) async {
  String? token = await secureStorage?.read(key: 'access-token');
  var headerwithToken = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };
  final response =
      await http.delete(Uri.parse(endPoint), headers: headerwithToken);
  return response;
}

//to respond back to bloc
blocResponder(response) {
  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);
    return decodedResponse;
  }
}
