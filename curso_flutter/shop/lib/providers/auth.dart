import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
//Cadastre-se com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-create-email-password
  static const _signin =
      //'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]'
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAIfuGZEFWdeFPU9HXLt4OfQrni4f1f_00';

//Entrar com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-sign-in-email-password
  static const _signup =
      //'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]'
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAIfuGZEFWdeFPU9HXLt4OfQrni4f1f_00';

  Future<void> signup(String email, String password) async {
    return _auth(_signup, email, password);
  }

  Future<void> signin(String email, String password) async {
    return _auth(_signin, email, password);
  }

  Future<void> _auth(String uri, String email, String password) async {
    final response = await http.post(Uri.parse(uri),
        body: json.encode({
          'returnSecureToken': true,
          'email': email,
          'password': password,
        }));

    print(json.decode(response.body));

    return Future.value();
  }
}
