import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/app_firebase.dart';

class Auth with ChangeNotifier {
  static const key = 'signin';

  String _localId;
  String _idToken;
  DateTime _expiresDate;
  Timer _timer;

  String get token => _idToken;
  String get localId => _localId;

  bool get isAuth => !(_idToken == null ||
      _localId == null ||
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

  Future<bool> autoSignin() async {
    if (isAuth) {
      return Future.value(true);
    }
    final Map<String, dynamic> body = await Store.loadMap(key);
    if (body == null || body.isEmpty) {
      return Future.value(false);
    }
    _processBody(body);
    return Future.value(isAuth);
  }

  void logout() {
    this._expiresDate = null;
    this._idToken = null;
    this._localId = null;
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    Store.delete(key);
    notifyListeners();
  }

  Future<void> _auth(String uri, String email, String password) async {
    final response = await http.post(Uri.parse(uri),
        body: json.encode({
          'returnSecureToken': true,
          'email': email,
          'password': password,
        }));

    final Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode == 200) {
      _processBody(body);
      Store.saveMap(key, body);
      return Future.value();
    } else {
      _idToken = null;
      _expiresDate = null;
    }

    throw AuthException(body['error']['message']);
  }

  void _processBody(Map<String, dynamic> body) {
    int expiresIn = int.parse(body['expiresIn']);
    _idToken = body['idToken'];
    _localId = body['localId'];
    if (body['expiresDate'] == null) {
      _expiresDate = DateTime.now().add(Duration(seconds: expiresIn));
      body['expiresDate'] = _expiresDate.toIso8601String();
    } else {
      _expiresDate = DateTime.parse(body['expiresDate']);
      expiresIn = _expiresDate.difference(DateTime.now()).inSeconds;
    }
    _autoLogout(expiresIn);
    notifyListeners();
  }

  void _autoLogout(int expiresIn) {
    if (expiresIn < 1) {
      logout();
      return;
    }
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: expiresIn), () {
      _timer = null;
      logout();
    });
  }
}
