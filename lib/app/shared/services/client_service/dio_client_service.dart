import 'package:dio/dio.dart';
import 'package:verify/app/shared/services/client_service/client_service.dart';

class DioClientService implements ClientService {
  final dio = Dio();
  @override
  Future<void> post({
    required String url,
    required String body,
  }) async {
    await dio.post(
      url,
      data: body,
    );
  }
}
