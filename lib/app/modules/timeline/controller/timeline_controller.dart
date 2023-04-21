import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/timeline/store/timeline_store.dart';
import 'package:verify/app/shared/services/pix_services/bb_pix_api_service/bb_pix_api_service.dart';
import 'package:verify/app/shared/services/pix_services/models/verify_pix_model.dart';
import 'package:verify/app/shared/services/pix_services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class TimelineController {
  final BBPixApiService _bbPixApiService;
  final SicoobPixApiService _sicoobPixApiService;

  final store = Modular.get<TimelineStore>();

  final scrollController = ScrollController();

  TimelineController(
    this._bbPixApiService,
    this._sicoobPixApiService,
  );

  void goToTodayDate() {
    final now = DateTime.now();
    store.setSelectedDate(now);
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void selectDateOnCarrousel(DateTime date) {
    store.setSelectedDate(date);
  }

  void selectAccout(int selected) {
    store.setselectedAccount(selected);
  }

  Future<List<VerifyPixModel>> fetchBBPixTransactions(
    BBApiCredentialsEntity bbApiCredentialsEntity,
    DateTime selectedDate,
  ) async {
    final initialDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final endDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      23,
      59,
      59,
    ).add(const Duration(hours: 4));

    final transactions = await _bbPixApiService.fetchTransactions(
      dateTimeRange: DateTimeRange(start: initialDate, end: endDate),
      applicationDeveloperKey: bbApiCredentialsEntity.applicationDeveloperKey,
      basicKey: bbApiCredentialsEntity.basicKey,
    );
    return transactions;
  }

  Future<List<VerifyPixModel>> fetchSicoobPixTransactions(
    SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
    DateTime selectedDate,
  ) async {
    final initialDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    ).add(const Duration(hours: 1));

    final endDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      23,
      59,
      59,
    );

    final transactions = await _sicoobPixApiService.fetchTransactions(
      dateTimeRange: DateTimeRange(start: initialDate, end: endDate),
      clientID: sicoobApiCredentialsEntity.clientID,
      certificateBase64String:
          sicoobApiCredentialsEntity.certificateBase64String,
      certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
    );
    return transactions;
  }
}
