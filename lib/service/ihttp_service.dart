abstract class IHttpService  {
  Future get();
  Future post({required String bodyJson, required String uriPath});
}