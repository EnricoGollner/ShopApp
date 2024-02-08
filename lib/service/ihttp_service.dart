abstract class IHttpService  {
  Future get({required String uri});
  Future post({required String uriPath, required String bodyJson});
  Future patch({required String uri, required String bodyJson,});
}