import 'package:firebase_auth/firebase_auth.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';

enum FirebaseErrorType {
  docummentNotFound(
    errorCode: 'invalid-argument',
    message: 'O Documento solicitado não exite',
  ),
  emptyDocummentData(
    errorCode: 'empty-documment-data',
    message: 'Não existe dados para a solicitacao',
  ),
  invalidArgument(
    errorCode: 'invalid-argument',
    message: 'O valor fornecido é inválido',
  ),
  failedPrecondition(
    errorCode: 'failed-precondition',
    message:
        'Não foi possível realizar a operação porque não foi atendida uma condição necessária',
  ),
  unauthenticated(
    errorCode: 'failed-precondition',
    message:
        'Não foi possível realizar a operação porque o usuário não está autenticado.',
  ),
  permissionDenied(
    errorCode: 'permission-denied',
    message:
        'Não foi possível realizar a operação devido à falta de permissões.',
  ),
  notFound(
    errorCode: 'not-found',
    message:
        'Não foi possível concluir a operação porque o recurso solicitado não foi encontrado.',
  ),
  aborted(
    errorCode: 'aborted',
    message: 'A operação foi cancelada.',
  ),

  alreadyExists(
    errorCode: 'already-exists',
    message: 'Não foi possível realizar a operação porque o recurso já existe.',
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
      _sendLogsToWeb(e);
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
