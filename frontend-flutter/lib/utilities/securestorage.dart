import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
String? name;
String? email;

isLoggedIn() async {
  String? token = await secureStorage?.read(key: 'access-token');
  if (token != null) {
    name = await secureStorage?.read(key: 'name');
    email = await secureStorage?.read(key: 'email');
    return true;
  } else {
    return false;
  }
}

saveUserInfo(accessToken, name, email) async {
  await secureStorage?.write(key: 'access-token', value: accessToken);
  await secureStorage?.write(key: 'name', value: name);
  await secureStorage?.write(key: 'email', value: email);
  name = await secureStorage?.read(key: 'name');
  email = await secureStorage?.read(key: 'email');
}

saveUserKeys(
    redKey, consumerKey, consumerSecret, blueAccess, blueAccessSecret) async {
  await secureStorage?.write(key: 'red-key', value: redKey);
  await secureStorage?.write(key: 'consumer-key', value: consumerKey);
  await secureStorage?.write(key: 'consumer-secret', value: consumerSecret);
  await secureStorage?.write(key: 'blue-access', value: blueAccess);
  await secureStorage?.write(
      key: 'blue-access-secret', value: blueAccessSecret);
}

//to remove user's specific details like tokens, coupans/keys
deleteLoginTokens() async {
  await secureStorage?.deleteAll();
}

getStoredCoupans() async {
  FlutterSecureStorage? appCache = const FlutterSecureStorage();
  String? yKey = await appCache.read(key: 'red-key');
  String? ck = await appCache.read(key: 'consumer-key');
  String? cs = await appCache.read(key: 'consumer-secret');
  String? at = await appCache.read(key: 'blue-access');
  String? ats = await appCache.read(key: 'blue-access-secret');

  List<String> coupans = ["1", "2", "3", "4", "5"];
  if ((yKey == null) ||
      (ck == null) ||
      (cs == null) ||
      (at == null) ||
      (ats == null)) {
    coupans[0] = "";
    coupans[1] = "";
    coupans[2] = "";
    coupans[3] = "";
    coupans[4] = "";
    return coupans;
  } else {
    coupans[0] = yKey;
    coupans[1] = ck;
    coupans[2] = cs;
    coupans[3] = at;
    coupans[4] = ats;
    return coupans;
  }
}
