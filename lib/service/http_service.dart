import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop/core/utils/config.dart';
import 'package:shop/service/ihttp_service.dart';

class HttpService implements IHttpService {
  final String _baseUrl = Config.baseUrl;

  @override
  Future get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future post({required String bodyJson, required String uriPath}) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/$uriPath"), // we MUST finish the URI with .json
      body: bodyJson,
    );

    if (response.statusCode >= 400) {
      throw const HttpException('Could not save product.');
    }
  }
}
