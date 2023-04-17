import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';

part 'api_credentials_store.g.dart';

class ApiCredentialsStore = ApiCredentialsStoreBase with _$ApiCredentialsStore;

abstract class ApiCredentialsStoreBase with Store {
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
}
