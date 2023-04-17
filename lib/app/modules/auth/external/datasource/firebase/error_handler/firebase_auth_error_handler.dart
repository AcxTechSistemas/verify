import 'package:firebase_auth/firebase_auth.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';

enum FirebaseErrorType {
  emailAlreadyInUse(
    errorCode: 'email-already-in-use',
    message: 'Usuário já cadastrado',
  ),
  invalidEmail(
    errorCode: 'invalid-email',
    message: 'O endereço de e-mail fornecido não é válido',
  ),
  invalidCredential(
    errorCode: 'invalid-credential',
    message: 'As credenciais fornecidas são inválidas.',
  ),
  operationNotAllowed(
    errorCode: 'operation-not-allowed',
    message: 'O tipo de operação solicitada não é permitido para este usuário',
  ),
  weakPassword(
    errorCode: 'weak-password',
    message: 'A senha fornecida é muito fraca',
  ),
  wrongPassword(
    errorCode: 'wrong-password',
    message: 'O email ou a senha estão incorretos',
  ),
  userDisabled(
    errorCode: 'user-disabled',
    message: 'A conta de usuário está desativada',
  ),
  userNotFound(
    errorCode: 'user-not-found',
    message: 'Usuário não encontrado, revise suas informações',
  ),
  accountExistsWithDifferentCredential(
    errorCode: 'account-exists-with-different-credential',
    message:
        'Já existe uma conta associada a estas credenciais em outro provedor',
  ),
  requiresRecentLogin(
    errorCode: 'requires-recent-login',
    message:
        'Você fez login recentemente e a operação solicitada requer refaça login novamente para concluir',
  ),
  providerAlreadyLinked(
    errorCode: 'provider-already-linked',
    message: 'Esta conta já está vinculada a um provedor de login diferente',
  ),
  credentialAlreadyInUse(
    errorCode: 'credential-already-in-use',
    message: 'As credenciais fornecidas já estão sendo usadas por outra conta.',
  ),
  invalidUserToken(
    errorCode: 'invalid-user-token',
    message: 'Token expirado. \nPor favor, faça login novamente.',
  ),
  userTokenExpired(
    errorCode: 'user-token-expired',
    message: 'Token expirado',
  ),
  nullUser(
    errorCode: 'null-user',
    message: 'O usuário não existe',
  ),
  networkRequestFailed(
    errorCode: 'network-request-failed',
    message: 'Houve um problema de conexão com a rede e a solicitação falhou',
  ),
  networkError(
    errorCode: 'network-error',
    message: 'Houve um problema de conexão com a rede e a solicitação falhou',
  ),
  internalError(
    errorCode: 'internal-error',
    message:
        'Ocorreu um erro interno. \nPor favor, tente novamente mais tarde.',
  ),
  tooManyRequests(
    errorCode: 'too-many-requests',
    message:
        'Limite de solicitações excedido.\nPor favor, tente novamente mais tarde.',
  ),
  missingVerificationCode(
    errorCode: 'missing-verification-code',
    message:
        'Não foi encontrado o codigo de verificação. \nPor favor, verifique se o código foi fornecido corretamente.',
  ),
  invalidVerificationCode(
    errorCode: 'invalid-verification-code',
    message: ' O código de verificação fornecido é inválido ou expirou.',
  ),
  sessionExpired(
    errorCode: 'session-expired',
    message: 'Sua sessão expirou.\nPor favor, faça login novamente.',
  ),
  emailChangeNeedsVerification(
    errorCode: 'email-change-needs-verification',
    message:
        ' É necessário verificar o novo endereço de e-mail antes de usá-lo',
  ),
  unknown(
    errorCode: 'unknown',
    message:
        'Ocorreu um erro ao realizar a solicitação, Tente novamente mais tarde',
  );

  const FirebaseErrorType({
    required this.errorCode,
    required this.message,
  });

  final String message;
  final String errorCode;
}

class FirebaseAuthErrorHandler {
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;
  FirebaseAuthErrorHandler(
    this._registerLog,
    this._sendLogsToWeb,
  );

  Future<String> call(FirebaseAuthException e) async {
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
