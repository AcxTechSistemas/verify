import 'package:flutter/material.dart';
import 'package:pix_sicoob/pix_sicoob.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/error_handler/sicoob_pix_api_error_handler.dart';

abstract class SicoobPixApiService {
  Future<String?> validateCredentials({
    required String clientID,
    required String certificateBase64String,
    required String certificatePassword,
  });
  Future<List<Pix>> fetchTransactions({
    required String clientID,
    required String certificateBase64String,
    required String certificatePassword,
  });
}

class SicoobPixApiServiceImpl implements SicoobPixApiService {
  final SicoobPixApiServiceErrorHandler _apiServiceErrorHandler;
  final SendLogsToWeb _sendLogsToWeb;
  final RegisterLog _registerLog;

  SicoobPixApiServiceImpl(
    this._apiServiceErrorHandler,
    this._sendLogsToWeb,
    this._registerLog,
  );

  @override
  Future<String?> validateCredentials({
    required String clientID,
    required String certificateBase64String,
    required String certificatePassword,
  }) async {
    try {
      final pixSicoob = PixSicoob(
        clientID: clientID,
        certificateBase64String: certificateBase64String,
        certificatePassword: certificatePassword,
      );
      await pixSicoob.getToken().then((token) => pixSicoob.fetchTransactions(
            token: token,
          ));
      return null;
    } on PixException catch (e) {
      final errorMessage = await _apiServiceErrorHandler(e);
      return errorMessage;
    } catch (e) {
      _sendLogsToWeb(e);
      _registerLog(e);
      return 'Não foi possivel validar as credenciais tente novamente';
    }
  }

  @override
  Future<List<Pix>> fetchTransactions({
    required String clientID,
    required String certificateBase64String,
    required String certificatePassword,
    DateTimeRange? dateTimeRange,
  }) async {
    try {
      final pixSicoob = PixSicoob(
        clientID: clientID,
        certificateBase64String: certificateBase64String,
        certificatePassword: certificatePassword,
      );
      final token = await pixSicoob.getToken();
      final transactions = await pixSicoob.fetchTransactions(
        token: token,
        dateTimeRange: dateTimeRange,
      );
      return transactions;
    } catch (e) {
      _sendLogsToWeb(e);
      _registerLog(e);
      rethrow;
    }
  }
}
