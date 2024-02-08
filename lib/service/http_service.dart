import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop/core/utils/config.dart';
import 'package:shop/service/ihttp_service.dart';

class HttpService implements IHttpService {
  @override
  Future get({required String uri}) async {
    return await http.get(Uri.parse('${Config.baseUrl}$uri'));
  }

  @override
  Future post({required String bodyJson, required String uriPath}) async {
    final http.Response response = await http.post(
      Uri.parse("${Config.baseUrl}/$uriPath"), // we MUST finish the URI with .json
      body: bodyJson,
    );

    if (response.statusCode >= 400) {
      throw const HttpException('Could not save product.');
    }
  }
}
