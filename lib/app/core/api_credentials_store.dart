import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/read_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/read_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

part 'api_credentials_store.g.dart';

class ApiCredentialsStore = ApiCredentialsStoreBase with _$ApiCredentialsStore;

abstract class ApiCredentialsStoreBase with Store {
  @observable
  bool loading = false;

  @observable
  BBApiCredentialsEntity? bbApiCredentialsEntity;

  @observable
  SicoobApiCredentialsEntity? sicoobApiCredentialsEntity;

  @action
  void setBBApiCredentials(BBApiCredentialsEntity? credentials) {
    bbApiCredentialsEntity = credentials;
  }

  @action
  void setSicoobApiCredentialsEntity(SicoobApiCredentialsEntity? credentials) {
    sicoobApiCredentialsEntity = credentials;
  }

  @computed
  bool get hasApiCredentials {
    return bbApiCredentialsEntity != null || sicoobApiCredentialsEntity != null;
  }

  @computed
  List<Map<String, dynamic>>? get listAccounts {
    List<Map<String, dynamic>> list = [];
    final bbAccount = {
      'account': 'bancoDoBrasil',
      'hasCredentials': bbApiCredentialsEntity != null,
      'isFavorite': bbApiCredentialsEntity?.isFavorite ?? false,
      'imageAsset': 'assets/images/bancoDoBrasilAccountCard.png',
    };
    final sicoobAccount = {
      'account': 'sicoob',
      'hasCredentials': sicoobApiCredentialsEntity != null,
      'isFavorite': sicoobApiCredentialsEntity?.isFavorite ?? false,
      'imageAsset': 'assets/images/sicoobAccountCard.png',
    };
    list.add(bbAccount);
    list.add(sicoobAccount);
    list.sort(
      (a, b) {
        if (a['hasCredentials'] && b['hasCredentials']) {
          if (a['isFavorite']) {
            return -1;
          } else if (b['isFavorite']) {
            return 1;
          }
        }
        if (a['hasCredentials'] && !b['hasCredentials']) {
          return -1;
        } else if (b['hasCredentials'] && !a['hasCredentials']) {
          return 1;
        } else {
          return 0;
        }
      },
    );
    return list;
  }

  @action
  Future<void> loadData() async {
    loading = true;
    final bbReadUseCase = Modular.get<ReadBBApiCredentialsUseCase>();
    final sicoobReadUseCase = Modular.get<ReadSicoobApiCredentialsUseCase>();

    final sicoobCredentials = await sicoobReadUseCase(
      id: '',
      database: Database.local,
    ).getOrNull();

    final bbCredentials = await bbReadUseCase(
      id: '',
      database: Database.local,
    ).getOrNull();

    sicoobApiCredentialsEntity = sicoobCredentials;
    bbApiCredentialsEntity = bbCredentials;
    loading = false;
  }
}
