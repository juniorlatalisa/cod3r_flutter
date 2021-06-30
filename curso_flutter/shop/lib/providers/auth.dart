import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
//Cadastre-se com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-create-email-password

//Entrar com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-sign-in-email-password
  static const _URL =
      //'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]'
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAIfuGZEFWdeFPU9HXLt4OfQrni4f1f_00';

  Future<void> signup(String email, String password) async {
    final response = await http.post(Uri.parse(_URL),
        body: json.encode({
          'returnSecureToken': true,
          'email': email,
          'password': password,
        }));

    print(json.decode(response.body));

    return Future.value();
  }
}
