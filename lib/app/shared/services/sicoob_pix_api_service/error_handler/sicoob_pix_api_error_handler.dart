import 'package:pix_sicoob/pix_sicoob.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';

enum SicoobPixApiErrorType {
  invalidCertificatePassword(
    errorCode: 'the-certificate-password-is-incorrect',
    message: 'A Senha do certificado está incorreta',
  ),
  emptyCertificatePassword(
    errorCode: 'empty-certificate-password',
    message: 'A Senha do Certificado está vazia ou não definida',
  ),
  emptyBase64String(
    errorCode: 'empty-certificate-base64string',
    message: 'O Certificado náo foi inserido corretamente',
  ),
  certificateNotFound(
    errorCode: 'could-not-find-the-certificate-path',
    message: 'Não foi possivel localizar o caminho do certificado',
  ),

  invalidCertificateFile(
    errorCode: 'invalid-certificate-file',
    message: 'O Arquivo do certificado e inválido',
  ),

  invalidCertificateString(
    errorCode: 'invalid-certificate-base64string',
    message: 'Certificado em formato inválido',
  ),

  invalidClient(
    errorCode: 'invalid_client',
    message: 'ClientID Inválido',
  ),

  invalidDateRange(
    errorCode: 'date-range-must-be-in-the-same-month',
    message: 'O intervalo de datas deve estar dentro do mesmo mês',
  ),
  unknown(
    errorCode: 'unknown',
    message:
        'Ocorreu um erro ao realizar a solicitação. Tente novamente mais tarde',
  );

  const SicoobPixApiErrorType({
    required this.errorCode,
    required this.message,
  });
  final String errorCode;
  final String message;
}

class SicoobPixApiServiceErrorHandler {
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;

  late SicoobPixApiErrorType errorType;

  SicoobPixApiServiceErrorHandler(
    this._registerLog,
    this._sendLogsToWeb,
  );
  Future<String> call(PixException e) async {
    if (e is SicoobApiException) {
      return e.errorDescription;
    } else {
      try {
        errorType = SicoobPixApiErrorType.values
            .where((error) => e.error == error.errorCode)
            .single;
      } catch (e) {
        await _sendLogsToWeb(e);
        errorType = SicoobPixApiErrorType.unknown;
      }
      final errorCode = errorType.errorCode;
      final errorMessage = errorType.message;
      final type = errorType;
      final sicoobPixError =
          'type: $type code: $errorCode HandleMessage: $errorMessage sicoobPixException: $e';
      _registerLog(sicoobPixError);
      return errorMessage;
    }
  }
}
