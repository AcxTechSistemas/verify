import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/core/auth_store.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/modules/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/modules/auth/utils/email_regex.dart';
import 'package:verify/app/modules/auth/utils/password_regex.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/read_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/save_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/read_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class LoginController {
  final LoginStore _loginStore;
  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final ReadSicoobApiCredentialsUseCase _readSicoobApiCredentialsUseCase;
  final ReadBBApiCredentialsUseCase _readBBApiCredentialsUseCase;
  final SaveSicoobApiCredentialsUseCase _saveSicoobApiCredentialsUseCase;
  final SaveBBApiCredentialsUseCase _saveBBApiCredentialsUseCase;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final authStore = Modular.get<AuthStore>();

  LoginController(
    this._loginStore,
    this._loginWithEmailUseCase,
    this._loginWithGoogleUseCase,
    this._readSicoobApiCredentialsUseCase,
    this._readBBApiCredentialsUseCase,
    this._saveSicoobApiCredentialsUseCase,
    this._saveBBApiCredentialsUseCase,
  );

  void goToRegisterPage() {
    dispose();
    Modular.to.pushReplacementNamed('./register');
  }

  void goToRecoverAccountPage() {
    dispose();
    Modular.to.pushReplacementNamed('./recover');
  }

  Future<String?> loginWithEmail() async {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    _loginStore.loggingInWithEmailInProgress(true);
    final loginCredentials = LoginCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _loginWithEmailUseCase(loginCredentials);

    return result.fold(
      (user) async {
        if (!user.emailVerified) {
          _loginStore.loggingInWithEmailInProgress(false);
          return 'Confirme seu email no link enviado';
        }
        authStore.setUser(user);
        _loginStore.loggingInWithEmailInProgress(false);
        await _fetchCloudApiCredentials(user);
        Modular.to.pushReplacementNamed('/home/');
        return null;
      },
      (failure) {
        _loginStore.loggingInWithEmailInProgress(false);
        return failure.message;
      },
    );
  }

  Future<String?> loginWithGoogle() async {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    _loginStore.loggingInWithGoogleInProgress(true);
    final result = await _loginWithGoogleUseCase.call();

    return result.fold(
      (user) async {
        authStore.setUser(user);
        await _fetchCloudApiCredentials(user);
        _loginStore.loggingInWithGoogleInProgress(false);
        Modular.to.pushReplacementNamed('/home/');
        return null;
      },
      (failure) {
        _loginStore.loggingInWithGoogleInProgress(false);
        return failure.message;
      },
    );
  }

  void validateFields() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _loginStore.isValidFields(true);
    } else {
      _loginStore.isValidFields(false);
    }
  }

  String? autoValidateEmail(String? emailInput) {
    if (emailRegex.hasMatch(emailInput ?? '')) {
      return null;
    } else {
      return 'Digite um email válido';
    }
  }

  String? autoValidatePassword(String? passwordInput) {
    if (passwordRegex.hasMatch(passwordInput ?? '')) {
      return null;
    } else {
      return 'Senha deve ter no minimo 8 caracteres';
    }
  }

  Future<void> _fetchCloudApiCredentials(LoggedUserInfoEntity user) async {
    final cloudBBCredentials = await _readBBApiCredentialsUseCase(
      id: user.id,
      database: Database.cloud,
    ).getOrNull();

    final cloudSicoobCredentials = await _readSicoobApiCredentialsUseCase(
      id: user.id,
      database: Database.cloud,
    ).getOrNull();
    if (cloudBBCredentials != null) {
      final bbCredentials = BBApiCredentialsEntity(
        applicationDeveloperKey: cloudBBCredentials.applicationDeveloperKey,
        basicKey: cloudBBCredentials.basicKey,
        isFavorite: cloudBBCredentials.isFavorite,
      );
      await _saveBBApiCredentialsUseCase(
        id: '',
        bbApiCredentialsEntity: bbCredentials,
        database: Database.local,
      );
    }
    if (cloudSicoobCredentials != null) {
      final bbCredentials = SicoobApiCredentialsEntity(
        clientID: cloudSicoobCredentials.clientID,
        certificatePassword: cloudSicoobCredentials.certificatePassword,
        certificateBase64String: cloudSicoobCredentials.certificateBase64String,
        isFavorite: cloudSicoobCredentials.isFavorite,
      );
      await _saveSicoobApiCredentialsUseCase(
        id: '',
        sicoobApiCredentialsEntity: bbCredentials,
        database: Database.local,
      );
    }
    final apiStore = Modular.get<ApiCredentialsStore>();
    await apiStore.loadData();
  }

  void dispose() {
    emailController.text = '';
    passwordController.text = '';
    _loginStore.isValidFields(false);
    _loginStore.loggingInWithEmailInProgress(false);
    _loginStore.loggingInWithGoogleInProgress(false);
  }
}
