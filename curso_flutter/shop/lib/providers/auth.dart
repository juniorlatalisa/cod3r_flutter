import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/app_firebase.dart';

class Auth with ChangeNotifier {
  String _idToken;
  DateTime _expiresDate;

  String get token => _idToken;

  bool get isAuth => !(_idToken == null ||
      _expiresDate == null ||
      _expiresDate.isBefore(DateTime.now()));

//Cadastre-se com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-create-email-password
  static const _signin =
      //'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]'
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${AppFireBase.API_TOKEN}';

//Entrar com e-mail / senha
//https://firebase.google.com/docs/reference/rest/auth?hl=pt#section-sign-in-email-password
  static const _signup =
      //'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]'
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${AppFireBase.API_TOKEN}';

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

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      int _expiresIn = int.parse(body['expiresIn']);
      _idToken = body['idToken'];
      _expiresDate = DateTime.now().add(Duration(seconds: _expiresIn));
      notifyListeners();
      return Future.value();
    } else {
      _idToken = null;
      _expiresDate = null;
    }

    throw AuthException(body['error']['message']);
  }
}
