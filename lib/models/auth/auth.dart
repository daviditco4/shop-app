import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/html_exception.dart';

class Auth with ChangeNotifier {
  static const _apiKey = 'AIzaSyA1JI1gf8UgDEI5H1Aub03ecvXY5tCmIIo';
  static const _uidKey = 'userUid';
  static const _tokKey = 'idToken';
  static const _expyKey = 'tokenExpiry';
  static const _dataKey = 'authData';
  String _userUid;
  String _idToken;
  DateTime _tokenExpiry;
  Timer _signoutTimer;
  bool get isSignedIn => token != null;

  String get token {
    final now = DateTime.now();
    return _tokenExpiry != null && _tokenExpiry.isAfter(now) ? _idToken : null;
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

    final tokExpy = DateTime.now().add(
      Duration(seconds: int.parse(responseData['expiresIn'])),
    );
    _setDataAndTimer(responseData['localId'], responseData['idToken'], tokExpy);
    _saveAuthDataOnDevice();
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

  void signOut() {
    _userUid = null;
    _idToken = null;
    _tokenExpiry = null;
    _signoutTimer?.cancel();
    _signoutTimer = null;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) => prefs.clear());
  }

  Future<void> attemptAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(_dataKey)) {
      final authData =
          json.decode(prefs.getString(_dataKey)) as Map<String, dynamic>;
      final tokenExpiry = DateTime.parse(authData[_expyKey]);

      if (tokenExpiry.isAfter(DateTime.now())) {
        _setDataAndTimer(authData[_uidKey], authData[_tokKey], tokenExpiry);
      }
    }
  }

  void _setDataAndTimer(String userUid, String idToken, DateTime tokenExpiry) {
    _userUid = userUid;
    _idToken = idToken;
    _tokenExpiry = tokenExpiry;
    _setSignoutTimer();
    notifyListeners();
  }

  void _setSignoutTimer() {
    _signoutTimer?.cancel();
    _signoutTimer = Timer(_tokenExpiry.difference(DateTime.now()), signOut);
  }

  Future<void> _saveAuthDataOnDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = json.encode(
      {
        _uidKey: _userUid,
        _tokKey: _idToken,
        _expyKey: _tokenExpiry.toIso8601String(),
      },
    );

    await prefs.setString(_dataKey, authData);
  }
}
