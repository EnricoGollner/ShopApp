import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/authentication/model/authentication.dart';
import 'package:shop/authentication/services/authentication_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationService authenticationService = AuthenticationService();

  Future<void> signup({required String email, required String password}) async {
    final Authentication auth = Authentication(email: email, password: password);
    final http.Response response = await authenticationService.authenticate(authentication: auth, urlMethod: 'signUp');

    if (response.statusCode == 204) {
      
    }
  }

  Future<void> login({required String email, required String password}) async {
    final Authentication auth = Authentication(email: email, password: password);
    final http.Response response = await authenticationService.authenticate(authentication: auth, urlMethod: 'signInWithPassword');


    print(jsonDecode(response.body));
  }
}
