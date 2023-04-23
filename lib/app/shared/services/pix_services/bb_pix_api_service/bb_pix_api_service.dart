import 'package:flutter/material.dart';
import 'package:pix_bb/pix_bb.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/shared/services/pix_services/bb_pix_api_service/error_handler/bb_pix_api_error_handler.dart';
import 'package:verify/app/shared/services/pix_services/models/verify_pix_model.dart';

abstract class BBPixApiService {
  Future<String?> validateCredentials({
    required String applicationDeveloperKey,
    required String basicKey,
  });
  Future<List<VerifyPixModel>> fetchTransactions({
    required String applicationDeveloperKey,
    required String basicKey,
    DateTimeRange? dateTimeRange,
  });
}

class BBPixApiServiceImpl implements BBPixApiService {
  final SendLogsToWeb _sendLogsToWeb;
  final RegisterLog _registerLog;
  final BBPixApiServiceErrorHandler _apiServiceErrorHandler;
  BBPixApiServiceImpl(
    this._sendLogsToWeb,
    this._registerLog,
    this._apiServiceErrorHandler,
  );
  @override
  Future<String?> validateCredentials({
    required String applicationDeveloperKey,
    required String basicKey,
  }) async {
    try {
      final pixBB = PixBB(
        ambiente: Ambiente.producao,
        basicKey: basicKey,
        developerApplicationKey: applicationDeveloperKey,
      );
      await pixBB.getToken().then((token) => pixBB.fetchTransactions(
            token: token,
          ));
      return null;
    } on PixException catch (e) {
      final errorMessage = await _apiServiceErrorHandler(e);
      return errorMessage;
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      return 'Não foi possivel validar as credenciais tente novamente';
    }
  }

  @override
  Future<List<VerifyPixModel>> fetchTransactions({
    required String applicationDeveloperKey,
    required String basicKey,
    DateTimeRange? dateTimeRange,
  }) async {
    try {
      final pixBB = PixBB(
        ambiente: Ambiente.producao,
        basicKey: basicKey,
        developerApplicationKey: applicationDeveloperKey,
      );
      final token = await pixBB.getToken();
      final transactions = await pixBB.fetchTransactions(
        token: token,
        dateTimeRange: dateTimeRange,
      );
      final verifyPixList = transactions
          .map((pix) => VerifyPixModel(
                clientName: pix.pagador.nome,
                documment: pix.pagador.cpf ?? pix.pagador.cnpj,
                value: double.parse(pix.valor),
                date: DateTime.parse(pix.horario),
              ))
          .toList();
      return verifyPixList;
    } on PixException catch (e) {
      final error = e.errorDescription ?? '';
      if (error.contains('4769515')) {
        return [];
      }
      await _sendLogsToWeb(e);
      _registerLog(e);
      rethrow;
    }
  }
}
