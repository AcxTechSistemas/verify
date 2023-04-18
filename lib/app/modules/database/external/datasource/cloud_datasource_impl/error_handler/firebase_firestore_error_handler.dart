import 'package:firebase_auth/firebase_auth.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';

enum FirebaseErrorType {
  cancelled(
    errorCode: 'cancelled',
    message: 'A operação foi cancelada pelo usuário',
  ),
  invalidArgument(
    errorCode: 'invalid-argument',
    message:
        'O valor inserido não é válido. Por favor, verifique as informações fornecidas e tente novamente.',
  ),
  deadlineExceeded(
    errorCode: 'deadline-exceeded',
    message:
        ' A operação levou mais tempo do que o esperado para ser concluída. Por favor, tente novamente mais tarde.',
  ),
  notFound(
    errorCode: 'not-found',
    message:
        ' O documento ou recurso solicitado não foi encontrado. Verifique as informações fornecidas e tente novamente.',
  ),
  alreadyExists(
    errorCode: 'already-exists',
    message:
        ' O documento ou recurso que você está tentando criar já existe. Por favor, verifique as informações fornecidas e tente novamente.',
  ),
  permissionDenied(
    errorCode: 'permission-denied',
    message:
        'Você não tem permissão para acessar o documento ou recurso solicitado. Por favor, entre em contato com o suporte para mais informações',
  ),
  resourceExhausted(
    errorCode: 'resource-exhausted',
    message:
        'O número de solicitações excedeu o limite permitido. Por favor, tente novamente mais tarde.',
  ),
  failedPrecondition(
    errorCode: 'failed-precondition',
    message:
        'A operação não pode ser realizada devido ao estado atual do recurso. Por favor, verifique as informações fornecidas e tente novamente.',
  ),
  aborted(
    errorCode: 'failed-precondition',
    message:
        'A operação foi interrompida devido a um conflito de concorrência. Por favor, tente novamente mais tarde.',
  ),
  outOfRange(
    errorCode: 'out-of-range',
    message:
        'O valor inserido está fora do intervalo permitido. Por favor, verifique as informações fornecidas e tente novamente.',
  ),
  internal(
    errorCode: 'internal',
    message:
        'Ocorreu um erro interno no servidor. Por favor, tente novamente mais tarde.',
  ),
  unavailable(
    errorCode: 'unavailable',
    message:
        'O serviço não está disponível no momento. Por favor, tente novamente mais tarde',
  ),
  dataLoss(
    errorCode: 'data-loss',
    message:
        'Houve uma perda de dados durante a transmissão. Por favor, tente novamente mais tarde.',
  ),
  unauthenticated(
    errorCode: 'unauthenticated',
    message:
        'Você precisa estar autenticado para acessar o recurso solicitado. Por favor, faça o login e tente novamente.',
  ),
  unknown(
    errorCode: 'unknown',
    message:
        'Ocorreu um erro ao realizar a solicitação. Tente novamente mais tarde',
  );

  const FirebaseErrorType({
    required this.errorCode,
    required this.message,
  });

  final String message;
  final String errorCode;
}

class FirebaseFirestoreErrorHandler {
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;
  FirebaseFirestoreErrorHandler(
    this._registerLog,
    this._sendLogsToWeb,
  );

  Future<String> call(FirebaseException e) async {
    late FirebaseErrorType errorType;

    try {
      errorType = FirebaseErrorType.values
          .where((error) => e.code == error.errorCode)
          .single;
    } catch (e) {
      await _sendLogsToWeb(e);
      errorType = FirebaseErrorType.unknown;
    }

    final errorCode = errorType.errorCode;
    final errorMessage = errorType.message;
    final type = errorType;
    final authError =
        'type: $type code: $errorCode HandleMessage: $errorMessage firebaseException: $e';
    _registerLog(authError);
    return errorMessage;
  }
}
