import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/authentication/model/authentication.dart';
import 'package:shop/authentication/services/authentication_service.dart';
import 'package:shop/core/exceptions/auth_exception.dart';
import 'package:shop/core/utils/data_store.dart';

class AuthViewModel extends ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final bool isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  final AuthenticationService authenticationService = AuthenticationService();

  Future<void> signup({required String email, required String password}) async {
    final Authentication auth =
        Authentication(email: email, password: password);
    final http.Response response = await authenticationService.authenticate(
        authentication: auth, urlMethod: 'signUp');

    if (response.statusCode == 204) {}
  }

  Future<AuthException?> login(
      {required String email, required String password}) async {
    final Authentication auth =
        Authentication(email: email, password: password);

    try {
      final http.Response response = await authenticationService.authenticate(authentication: auth, urlMethod: 'signInWithPassword');
      final body = jsonDecode(response.body);

      if (body['error'] != null) {
        return AuthException(key: body['error']['message']);
      } else {
        _token = body['idToken'];
        _email = body['email'];
        _userId = body['localId'];

        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              body['expiresIn'],
            ),
          ),
        );

        DataStore.saveMap(key: 'userData', value: {
          'token': _token,
          'email': _email,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String()
        });

        _autoLogout();
        notifyListeners();
      }
    } catch (_) {
      return AuthException(key: '');
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final Map<String, dynamic> userData =await DataStore.getMap(key: 'userData');
    if (userData.isEmpty) return;

    final DateTime expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return; // Token expired

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearAutoLogoutTimer();
    DataStore.remove(key: 'userData').then((_) {
      notifyListeners();
    });
  }

  void _clearAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearAutoLogoutTimer();
    final int timetToLogout =
        _expiryDate?.difference(DateTime.now()).inSeconds ?? 0;
    _logoutTimer = Timer(Duration(seconds: timetToLogout), logout);
  }
}
