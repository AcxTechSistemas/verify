import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/timeline/store/timeline_store.dart';
import 'package:pix_bb/pix_bb.dart' as bb;
import 'package:pix_sicoob/pix_sicoob.dart' as sicoob;
import 'package:verify/app/shared/services/bb_pix_api_service/bb_pix_api_service.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class TimelineController {
  final BBPixApiService _bbPixApiService;
  final SicoobPixApiService _sicoobPixApiService;
  final store = Modular.get<TimelineStore>();

  TimelineController(
    this._bbPixApiService,
    this._sicoobPixApiService,
  );
  void onDateSelected(DateTime date) {
    store.setselectedDate(date);
  }

  void selectAccout(int selected) {
    store.setselectedAccount(selected);
  }

  Future<List<bb.Pix>> fetchBBPixTransactions(
    BBApiCredentialsEntity bbApiCredentialsEntity,
    DateTime currentDate,
  ) async {
    final startDate = currentDate.copyWith(hour: 00, minute: 00, second: 00);
    final transactions = await _bbPixApiService.fetchTransactions(
      dateTimeRange: DateTimeRange(start: startDate, end: currentDate),
      applicationDeveloperKey: bbApiCredentialsEntity.applicationDeveloperKey,
      basicKey: bbApiCredentialsEntity.basicKey,
    );
    return transactions;
  }

  Future<List<sicoob.Pix>> fetchSicoobPixTransactions(
    SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
    DateTime currentDate,
  ) async {
    final startDate = currentDate.copyWith(hour: 00, minute: 00, second: 00);
    final transactions = await _sicoobPixApiService.fetchTransactions(
      dateTimeRange: DateTimeRange(start: startDate, end: currentDate),
      clientID: sicoobApiCredentialsEntity.clientID,
      certificateBase64String:
          sicoobApiCredentialsEntity.certificateBase64String,
      certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
    );
    return transactions;
  }
}
