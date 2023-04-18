import 'package:pix_bb/pix_bb.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';

enum BBPixApiErrorType {
  differenceBetweenDatesTooLong(
    errorCode: 'difference-between-dates-too-long',
    message:
        'A Diferença entre as datas de inicio e fim da consulta são maiores que 4 dias',
  ),
  emptyBasicKey(
    errorCode: ' Basic key vazia ou não definida',
    message: 'A Senha do Certificado está vazia ou não definida',
  ),
  emptyAppDevKey(
    errorCode: 'empty_app_dev_key',
    message: 'Application developer key vazia ou não definida',
  ),
  invalidCredentials(
    errorCode: 'invalid_client',
    message: 'BasicKey invalida',
  ),
  invalidAppDevKey(
    errorCode: 'Forbidden',
    message: 'AppDevKey invalida',
  ),
  unknown(
    errorCode: 'unknown',
    message:
        'Ocorreu um erro ao realizar a solicitação. Tente novamente mais tarde',
  );

  const BBPixApiErrorType({
    required this.errorCode,
    required this.message,
  });
  final String errorCode;
  final String message;
}

class BBPixApiServiceErrorHandler {
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;

  late BBPixApiErrorType errorType;

  BBPixApiServiceErrorHandler(
    this._registerLog,
    this._sendLogsToWeb,
  );
  Future<String> call(PixException e) async {
    if (e is BBApiException) {
      return e.errorDescription;
    } else {
      try {
        errorType = BBPixApiErrorType.values
            .where((error) => e.error == error.errorCode)
            .single;
      } catch (e) {
        await _sendLogsToWeb(e);
        errorType = BBPixApiErrorType.unknown;
      }
      final errorCode = errorType.errorCode;
      final errorMessage = errorType.message;
      final type = errorType;
      final sicoobPixError =
          'type: $type code: $errorCode HandleMessage: $errorMessage BBPixException: $e';
      _registerLog(sicoobPixError);
      return errorMessage;
    }
  }
}
