import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _apiKey = 'AIzaSyA1JI1gf8UgDEI5H1Aub03ecvXY5tCmIIo';
  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts';
  static const _signupUrl = '$_url:signUp?key=$_apiKey';
  static const _signinUrl = '$_url:signInWithPassword?key=$_apiKey';

  String _userUid;
  String _idToken;
  DateTime _tokenExpiresIn;

  Future<void> signUp(String email, String password) async {
    final response = await http.post(
      _signupUrl,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    print(json.decode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      _signinUrl,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    print(json.decode(response.body)['registered']);
  }
}
