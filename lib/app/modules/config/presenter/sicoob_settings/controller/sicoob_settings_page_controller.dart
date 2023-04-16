import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pix_sicoob/pix_sicoob.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verify/app/modules/auth/domain/usecase/get_logged_user_usecase.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/store/sicoob_settings_store.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class SicoobSettingsPageController {
  final SicoobPixApiService _pixSicoobService;
  final SicoobSettingsStore _store;
  final SaveSicoobApiCredentialsUseCase _saveSicoobApiCredentialsUseCase;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  //
  String certificateString = '';
  final clientIDController = TextEditingController();
  final certificatePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SicoobSettingsPageController(
    this._pixSicoobService,
    this._store,
    this._saveSicoobApiCredentialsUseCase,
    this._getLoggedUserUseCase,
  );

  Future<void> goToSicoobDevelopersPortal() async {
    final sicoobDeveloperUrl = Uri.parse(
      'https://developers.sicoob.com.br/portal/#!/',
    );
    await launchUrl(sicoobDeveloperUrl);
  }

  void validateFields() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _store.setValidFields(true);
    } else {
      _store.setValidFields(false);
    }
  }

  String? validateClientID(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return 'Insira um client ID';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? validateCertificatePassword(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return 'Insira um client ID';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> pickCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pfx', 'cer', 'crt'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final certBase64String = PixSicoob.certFileToBase64String(
        pkcs12CertificateFile: file,
      );
      certificateString = certBase64String;
      final fileName = file.path.split('/').last;
      _store.setCertificateFileName(fileName);
    }
  }

  Future<String?> validateCredentials() async {
    final response = await _pixSicoobService.validateCredentials(
      clientID: clientIDController.text,
      certificateBase64String: certificateString,
      certificatePassword: certificatePasswordController.text,
    );
    return response;
  }

  Future<String?> saveCredentialsOnCloudDatabase() async {
    final user = await _getLoggedUserUseCase();
    return user.fold(
      (user) async {
        await _saveSicoobApiCredentialsUseCase(
          id: user.name,
          sicoobApiCredentialsEntity: SicoobApiCredentialsEntity(
            clientID: clientIDController.text,
            certificatePassword: certificatePasswordController.text,
            certificateBase64String: certificateString,
            isFavorite: false,
          ),
        );
        return null;
      },
      (error) {
        return error.message;
      },
    );
  }
}
