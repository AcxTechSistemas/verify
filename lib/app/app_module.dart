import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/auth/auth_module.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/get_logged_user_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/logout_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/recover_account_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/register_with_email_usecase.dart';
import 'package:verify/app/modules/auth/external/datasource/firebase/error_handler/firebase_auth_error_handler.dart';
import 'package:verify/app/modules/auth/external/datasource/firebase/firebase_datasource_impl.dart';
import 'package:verify/app/modules/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:verify/app/modules/config/config_module.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/firestore_cloud_datasource_impl.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/shared_preferences_local_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:verify/app/modules/database/infra/repository/api_credentials_repository_impl.dart';
import 'package:verify/app/modules/database/infra/repository/user_preferences_repository_impl.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/error_handler/sicoob_pix_api_error_handler.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class AppModule extends Module {
  final SharedPreferences sharedPreferences;

  AppModule(this.sharedPreferences);
  @override
  List<Bind> get binds => [
        //Global Services
        AutoBind.singleton<SicoobPixApiService>(SicoobPixApiServiceImpl.new),
        AutoBind.factory<SicoobPixApiServiceErrorHandler>(
          SicoobPixApiServiceErrorHandler.new,
        ),
        //Global Stores
        AutoBind.singleton<AppStore>(AppStore.new),
        //Global Database
        AutoBind.instance<SharedPreferences>(sharedPreferences),
        //UserPreferences
        AutoBind.factory<SaveUserThemeModePreferencesUseCase>(
          SaveUserThemeModePreferencesUseCaseImpl.new,
        ),
        AutoBind.factory<ReadUserThemeModePreferencesUseCase>(
          ReadUserThemeModePreferencesUseCaseImpl.new,
        ),
        AutoBind.factory<UserPreferencesRepository>(
          UserPreferencesRepositoryImpl.new,
        ),
        AutoBind.factory<UserPreferencesDataSource>(
          SharedPreferencesLocalDataSourceImpl.new,
        ),

        ///ApiCredentials
        AutoBind.factory<ApiCredentialsDataSource>(
          SharedPreferencesLocalDataSourceImpl.new,
        ),

        AutoBind.factory<ApiCredentialsRepository>(
          ApiCredentialsRepositoryImpl.new,
        ),

        AutoBind.factory<SaveSicoobApiCredentialsUseCase>(
          SaveSicoobApiCredentialsUseCaseImpl.new,
        ),

        /// Auth
        AutoBind.instance<FirebaseAuth>(FirebaseAuth.instance),
        AutoBind.instance<GoogleSignIn>(GoogleSignIn()),
        AutoBind.factory<AuthDataSource>(FirebaseDataSourceImpl.new),
        AutoBind.factory<AuthRepository>(AuthRepositoryImpl.new),
        AutoBind.factory<LoginWithEmailUseCase>(LoginWithEmailUseCaseImpl.new),
        AutoBind.factory<LoginWithGoogleUseCase>(LoginWithGoogleImpl.new),
        AutoBind.factory<GetLoggedUserUseCase>(GetLoggedUserUseCaseImpl.new),
        AutoBind.factory<RegisterWithEmailUseCase>(
          RegisterWithEmailUseCaseImpl.new,
        ),
        AutoBind.factory<LogoutUseCase>(LogoutUseCaseImpl.new),
        AutoBind.factory<RecoverAccountUseCase>(RecoverAccountUseCaseImpl.new),
        //Error Handler
        AutoBind.instance<SendLogsToWeb>(SendLogsToDiscordChannel()),
        AutoBind.factory<RegisterLog>(RegisterLogImpl.new),
        AutoBind.factory<FirebaseAuthErrorHandler>(
            FirebaseAuthErrorHandler.new),

        ///...Auth
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/config', module: ConfigModule()),
      ];
}
