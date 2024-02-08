abstract class IHttpService  {
  Future get({required String uri});
  Future post({required String bodyJson, required String uriPath});
}