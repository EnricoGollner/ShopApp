import 'package:http/http.dart';

abstract class IStoreService  {
  Future<Response> get({required String uri});
  Future<Response> post({required String uriPath, required String bodyJson});
  Future<Response> patch({required String uri, required String bodyJson,});
  Future<Response> delete({required String uri});
}