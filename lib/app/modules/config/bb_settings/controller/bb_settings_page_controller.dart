import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/auth/domain/usecase/get_logged_user_usecase.dart';
import 'package:verify/app/modules/config/bb_settings/store/bb_settings_store.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/remove_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/save_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';
import 'package:verify/app/shared/services/pix_services/bb_pix_api_service/bb_pix_api_service.dart';

class BBSettingsPageController {
  final BBPixApiService _bbPixApiService;
  final BBSettingsStore _store;
  final SaveBBApiCredentialsUseCase _saveBBApiCredentialsUseCase;
  final RemoveBBApiCredentialsUseCase _removeBBApiCredentialsUseCase;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  //
  final appDevKeyController = TextEditingController();
  final basicKeyController = TextEditingController();
  final appDevKeyFocus = FocusNode();
  final basicKeyFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  final apiStore = Modular.get<ApiCredentialsStore>();

  BBSettingsPageController(
    this._bbPixApiService,
    this._store,
    this._saveBBApiCredentialsUseCase,
    this._getLoggedUserUseCase,
    this._removeBBApiCredentialsUseCase,
  );
  void popPage() async => Modular.to.pop();

  Future<void> goToBBDevelopersPortal() async {
    final bbDeveloperUrl = Uri.parse(
      'https://developers.bb.com.br/conheca-o-portal',
    );
    await launchUrl(bbDeveloperUrl);
  }

  void validateFields() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _store.setValidFields(true);
    } else {
      _store.setValidFields(false);
    }
  }

  String? validateAppDevKey(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return 'Insira uma AppDevKey';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? validateBasicKey(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return 'Insira uma BasicKey';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String?> validateCredentials() async {
    String? errorValidating;

    _store.validatingCredentials(true);
    errorValidating = await _bbPixApiService.validateCredentials(
      applicationDeveloperKey: appDevKeyController.text,
      basicKey: basicKeyController.text,
    );
    if (errorValidating != null) {
      _store.validatingCredentials(false);
      return errorValidating;
    }
    errorValidating = await saveCredentials();
    if (errorValidating != null) {
      _store.validatingCredentials(false);
      return errorValidating;
    }
    _store.validatingCredentials(false);
    return errorValidating;
  }

  Future<String?> saveCredentials() async {
    String? errorInSaving;
    errorInSaving = await saveCredentialsinCloud();
    if (errorInSaving != null) {
      return errorInSaving;
    }
    errorInSaving = await saveCredentialsinLocal();
    if (errorInSaving != null) {
      return errorInSaving;
    }
    await apiStore.loadData();
    return errorInSaving;
  }

  Future<String?> saveCredentialsinCloud() async {
    _store.savingInCloud(true);
    final message = await _saveCredentialsOnDatabase(Database.cloud);
    _store.savingInCloud(false);
    return message;
  }

  Future<String?> saveCredentialsinLocal() async {
    _store.savingInLocal(true);
    final message = await _saveCredentialsOnDatabase(Database.local);
    _store.savingInLocal(false);
    return message;
  }

  Future<String?> _saveCredentialsOnDatabase(Database database) async {
    final user = await _getLoggedUserUseCase();
    if (user == null) {
      return 'Sua sessão expirou.\nPor favor, faça login novamente.';
    } else {
      final saved = await _saveBBApiCredentialsUseCase(
        database: database,
        id: user.id,
        bbApiCredentialsEntity: BBApiCredentialsEntity(
          applicationDeveloperKey: appDevKeyController.text,
          basicKey: basicKeyController.text,
          isFavorite: false,
        ),
      );
      saved.fold(
        (success) => null,
        (failure) => failure.message,
      );
      return null;
    }
  }

  Future<String?> removeCredentials() async {
    String? errorInRemoving;
    errorInRemoving = await removeCredentialsinCloud();
    if (errorInRemoving != null) {
      return errorInRemoving;
    }
    errorInRemoving = await removeCredentialsinLocal();
    if (errorInRemoving != null) {
      return errorInRemoving;
    }
    await apiStore.loadData();
    return errorInRemoving;
  }

  Future<String?> removeCredentialsinCloud() async {
    _store.savingInCloud(true);
    final message = await _removeCredentialsOnDatabase(Database.cloud);
    _store.savingInCloud(false);
    return message;
  }

  Future<String?> removeCredentialsinLocal() async {
    _store.savingInLocal(true);
    final message = await _removeCredentialsOnDatabase(Database.local);
    _store.savingInLocal(false);
    return message;
  }

  Future<String?> _removeCredentialsOnDatabase(Database database) async {
    final user = await _getLoggedUserUseCase();
    if (user == null) {
      return 'Sua sessão expirou.\nPor favor, faça login novamente.';
    } else {
      final saved = await _removeBBApiCredentialsUseCase(
        database: database,
        id: user.id,
      );
      saved.fold(
        (success) => null,
        (failure) => failure.message,
      );
      return null;
    }
  }

  void dispose() {
    appDevKeyFocus.unfocus();
    basicKeyFocus.unfocus();
    appDevKeyController.clear();
    basicKeyController.clear();
    _store.savingInCloud(false);
    _store.savingInLocal(false);
    _store.validatingCredentials(false);
    _store.setValidFields(false);
  }
}
