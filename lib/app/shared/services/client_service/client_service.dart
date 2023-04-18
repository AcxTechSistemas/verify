abstract class ClientService {
  Future<void> post({
    required String url,
    required Object body,
  });
}
