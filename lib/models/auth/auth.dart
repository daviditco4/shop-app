import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';

class Auth with ChangeNotifier {
  static const _apiKey = 'AIzaSyA1JI1gf8UgDEI5H1Aub03ecvXY5tCmIIo';
  String _userUid;
  String _idToken;
  DateTime _tokenExpiresIn;
  bool get isSignedIn => token != null;

  String get token {
    return _tokenExpiresIn != null && _tokenExpiresIn.isAfter(DateTime.now())
        ? _idToken
        : null;
  }

  String get userId => _userUid;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final response = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apiKey',
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    final responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HtmlException(responseData['error']['message']);
    }

    _userUid = responseData['localId'];
    _idToken = responseData['idToken'];
    _tokenExpiresIn = DateTime.now().add(
      Duration(seconds: int.parse(responseData['expiresIn'])),
    );
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _authenticate(email, password, 'signUp');
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authenticate(email, password, 'signInWithPassword');
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
