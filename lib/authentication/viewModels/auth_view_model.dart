import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/authentication/model/authentication.dart';
import 'package:shop/authentication/services/authentication_service.dart';
import 'package:shop/core/exceptions/auth_exception.dart';

class AuthViewModel extends ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final bool isExpired = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isExpired;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  final AuthenticationService authenticationService = AuthenticationService();

  Future<void> signup({required String email, required String password}) async {
    final Authentication auth =
        Authentication(email: email, password: password);
    final http.Response response = await authenticationService.authenticate(
        authentication: auth, urlMethod: 'signUp');

    if (response.statusCode == 204) {}
  }

  Future<void> login({required String email, required String password}) async {
    final Authentication auth =
        Authentication(email: email, password: password);
    final http.Response response = await authenticationService.authenticate(
        authentication: auth, urlMethod: 'signInWithPassword');

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            body['expiresIn'],
          ),
        ),
      );

      notifyListeners();
    }
  }
}
