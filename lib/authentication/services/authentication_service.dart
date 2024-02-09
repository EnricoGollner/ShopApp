import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/authentication/model/authentication.dart';
import 'package:shop/core/exceptions/auth_exception.dart';
import 'package:shop/core/utils/config.dart';

class AuthenticationService {
  Future<http.Response> authenticate({required Authentication authentication, required String urlMethod}) async {
    final http.Response response = await http.post(
      Uri.parse('${Config.baseUrlAuth}$urlMethod?key=${Config.apiKey}'),
      body: jsonEncode({
        'email': authentication.email,
        'password': authentication.password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(response.body);

    if(body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    }

    return response;
  }
}