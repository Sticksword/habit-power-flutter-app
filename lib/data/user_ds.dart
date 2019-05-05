import 'dart:async';

import 'package:habit_power/utils/network_util.dart';
import 'package:habit_power/models/user_credential.dart';

class UserDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://ed8a74bd.ngrok.io/api";
  static final LOGIN_URL = BASE_URL + "/authenticate";
  static final _API_KEY = "somerandomkey";

  Future<UserCredential> login(String email, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "api_key": _API_KEY,
      "email": email,
      "password": password
    }).then((dynamic res) {
      print('hello from user_ds');
      print(res.toString());
      print(res['error']);

      print('hello');
      return new UserCredential.fromJson(res, email);
      // return new User.map(res, email);
    });
  }
}