import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop/core/utils/config.dart';
import 'package:shop/service/istore_service.dart';

class StoreService implements IStoreService {
  @override
  Future<http.Response> get({required String uri}) async {
    return await http.get(Uri.parse('${Config.baseUrl}$uri'));
  }

  @override
  Future<http.Response> post({required String uriPath, required String bodyJson}) async {
    final http.Response response = await http.post(
      Uri.parse("${Config.baseUrl}/$uriPath"), // we MUST finish the URI with .json
      body: bodyJson,
    );

    if (response.statusCode >= 400) {
      throw const HttpException('Could not save product.');
    }

    return response;
  }
  
  @override
  Future<http.Response> patch({required String uri, required String bodyJson}) async {
    return await http.patch(Uri.parse('${Config.baseUrl}$uri'));
  }
  
  @override
  Future<http.Response> delete({required String uri}) async {
    return await http.delete(Uri.parse('${Config.baseUrl}$uri'));
  }
}
