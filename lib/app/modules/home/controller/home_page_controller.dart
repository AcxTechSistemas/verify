import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pix_bb/pix_bb.dart' as bb;
import 'package:pix_sicoob/pix_sicoob.dart' as sicoob;
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/update_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/update_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';
import 'package:verify/app/modules/home/store/home_store.dart';
import 'package:verify/app/shared/services/bb_pix_api_service/bb_pix_api_service.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class HomePageController {
  final SicoobPixApiService _sicoobPixApiService;
  final BBPixApiService _bbPixApiService;
  final UpdateBBApiCredentialsUseCase _updateBBApiCredentialsUseCase;
  final UpdateSicoobApiCredentialsUseCase _updateSicoobApiCredentialsUseCase;

  final homeStore = Modular.get<HomeStore>();
  final apiStore = Modular.get<ApiCredentialsStore>();

  final pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

  HomePageController(
    this._sicoobPixApiService,
    this._bbPixApiService,
    this._updateBBApiCredentialsUseCase,
    this._updateSicoobApiCredentialsUseCase,
  );

  void onAccountChanged(int selectedCard) {
    homeStore.setSelectedAccountCard(selectedCard);
  }

  Future<List<bb.Pix>> fetchBBPixTransactions(
    BBApiCredentialsEntity bbApiCredentialsEntity,
  ) async {
    final transactions = await _bbPixApiService.fetchTransactions(
      applicationDeveloperKey: bbApiCredentialsEntity.applicationDeveloperKey,
      basicKey: bbApiCredentialsEntity.basicKey,
    );
    return transactions;
  }

  Future<List<sicoob.Pix>> fetchSicoobPixTransactions(
    SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  ) async {
    final transactions = await _sicoobPixApiService.fetchTransactions(
      clientID: sicoobApiCredentialsEntity.clientID,
      certificateBase64String:
          sicoobApiCredentialsEntity.certificateBase64String,
      certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
    );
    return transactions;
  }

  Future<String?> setBBFavorite() async {
    if (apiStore.bbApiCredentialsEntity != null) {
      final currentCredentials = apiStore.bbApiCredentialsEntity!;
      final bbCredentials = BBApiCredentialsEntity(
        applicationDeveloperKey: currentCredentials.applicationDeveloperKey,
        basicKey: currentCredentials.basicKey,
        isFavorite: !currentCredentials.isFavorite,
      );
      final result = await _updateBBApiCredentialsUseCase(
        id: '',
        database: Database.local,
        bbApiCredentialsEntity: bbCredentials,
      );
      result.fold(
        (success) {
          apiStore.loadData();
          return null;
        },
        (failure) => failure.message,
      );
    } else {
      return 'Ocorreu um erro ao ler suas credenciais tente novemente';
    }
  }

  Future<String?> setSicoobFavorite() async {
    if (apiStore.bbApiCredentialsEntity != null) {
      final currentCredentials = apiStore.sicoobApiCredentialsEntity!;
      final sicoobCredentials = SicoobApiCredentialsEntity(
        clientID: currentCredentials.clientID,
        certificatePassword: currentCredentials.certificatePassword,
        certificateBase64String: currentCredentials.certificateBase64String,
        isFavorite: !currentCredentials.isFavorite,
      );
      final result = await _updateSicoobApiCredentialsUseCase(
        id: '',
        database: Database.local,
        sicoobApiCredentialsEntity: sicoobCredentials,
      );
      result.fold(
        (success) {
          apiStore.loadData();
          return null;
        },
        (failure) => failure.message,
      );
    } else {
      return 'Ocorreu um erro ao ler suas credenciais tente novemente';
    }
  }

  String _greetingOfTheDay() {
    DateTime agora = DateTime.now();
    int hora = agora.hour;

    if (hora >= 6 && hora < 12) {
      return "Bom dia";
    } else if (hora >= 12 && hora < 18) {
      return "Boa tarde";
    } else {
      return "Boa noite";
    }
  }

  String get dayTimeMessage => _greetingOfTheDay();
}
