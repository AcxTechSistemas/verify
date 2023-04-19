import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/core/auth_store.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/read_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/remove_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/save_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/update_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/read_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/remove_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/update_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/remove_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/home/home_module.dart';
import 'package:verify/app/modules/timeline/timeline_module.dart';
import 'package:verify/app/modules/timeline/view/timeline_page.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
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
import 'package:verify/app/modules/config/settings_module.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/error_handler/firebase_firestore_error_handler.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/firestore_cloud_datasource_impl.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/shared_preferences_local_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/datasource/cloud_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:verify/app/modules/database/infra/repository/api_credentials_repository_impl.dart';
import 'package:verify/app/modules/database/infra/repository/user_preferences_repository_impl.dart';
import 'package:verify/app/shared/services/bb_pix_api_service/bb_pix_api_service.dart';
import 'package:verify/app/shared/services/bb_pix_api_service/error_handler/bb_pix_api_error_handler.dart';
import 'package:verify/app/shared/services/client_service/client_service.dart';
import 'package:verify/app/shared/services/client_service/dio_client_service.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/error_handler/sicoob_pix_api_error_handler.dart';
import 'package:verify/app/shared/services/sicoob_pix_api_service/sicoob_pix_api_service.dart';

class AppModule extends Module {
  final SharedPreferences sharedPreferences;

  AppModule(this.sharedPreferences);
  @override
  List<Bind> get binds => [
        ///Error Registers
        AutoBind.instance<ClientService>(DioClientService()),
        AutoBind.factory<SendLogsToWeb>(SendLogsToDiscordChannel.new),
        AutoBind.factory<RegisterLog>(RegisterLogImpl.new),

        /// Global Stores
        AutoBind.instance<AppStore>(AppStore()),
        AutoBind.instance<AuthStore>(AuthStore()),
        AutoBind.instance<ApiCredentialsStore>(ApiCredentialsStore()),

        /// Global Services
        //SicoobPix
        AutoBind.singleton<SicoobPixApiService>(SicoobPixApiServiceImpl.new),
        AutoBind.factory<SicoobPixApiServiceErrorHandler>(
          SicoobPixApiServiceErrorHandler.new,
        ),
        //BBPix
        AutoBind.singleton<BBPixApiService>(BBPixApiServiceImpl.new),
        AutoBind.factory<BBPixApiServiceErrorHandler>(
          BBPixApiServiceErrorHandler.new,
        ),
        //Banco do Brasil

        /// Auth
        // External
        AutoBind.instance<FirebaseAuth>(FirebaseAuth.instance),
        AutoBind.instance<GoogleSignIn>(GoogleSignIn()),
        //DataSource
        AutoBind.singleton<AuthDataSource>(FirebaseDataSourceImpl.new),
        //Repository
        AutoBind.singleton<AuthRepository>(AuthRepositoryImpl.new),
        //Use Cases
        AutoBind.factory<LoginWithEmailUseCase>(LoginWithEmailUseCaseImpl.new),
        AutoBind.factory<LoginWithGoogleUseCase>(LoginWithGoogleImpl.new),
        AutoBind.factory<GetLoggedUserUseCase>(GetLoggedUserUseCaseImpl.new),
        AutoBind.factory<RemoveUserThemeModePreferencesUseCase>(
          RemoveUserThemeModePreferencesUseCaseImpl.new,
        ),
        AutoBind.factory<RegisterWithEmailUseCase>(
          RegisterWithEmailUseCaseImpl.new,
        ),
        AutoBind.factory<LogoutUseCase>(LogoutUseCaseImpl.new),
        AutoBind.factory<RecoverAccountUseCase>(RecoverAccountUseCaseImpl.new),
        //Error Handler
        AutoBind.factory<FirebaseAuthErrorHandler>(
          FirebaseAuthErrorHandler.new,
        ),

        ///Database
        AutoBind.factory<FirebaseFirestoreErrorHandler>(
          FirebaseFirestoreErrorHandler.new,
        ),
        //Datasources
        AutoBind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        AutoBind.factory<CloudApiCredentialsDataSource>(
          FireStoreCloudDataSourceImpl.new,
        ),
        AutoBind.instance<SharedPreferences>(sharedPreferences),
        AutoBind.factory<LocalApiCredentialsDataSource>(
          SharedPreferencesLocalDataSourceImpl.new,
        ),
        AutoBind.factory<UserPreferencesDataSource>(
          SharedPreferencesLocalDataSourceImpl.new,
        ),
        // Use Cases
        AutoBind.factory<SaveUserThemeModePreferencesUseCase>(
          SaveUserThemeModePreferencesUseCaseImpl.new,
        ),
        AutoBind.factory<ReadUserThemeModePreferencesUseCase>(
          ReadUserThemeModePreferencesUseCaseImpl.new,
        ),

        AutoBind.factory<SaveSicoobApiCredentialsUseCase>(
          SaveSicoobApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<ReadSicoobApiCredentialsUseCase>(
          ReadSicoobApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<UpdateSicoobApiCredentialsUseCase>(
          UpdateSicoobApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<RemoveSicoobApiCredentialsUseCase>(
          RemoveSicoobApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<SaveBBApiCredentialsUseCase>(
          SaveBBApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<ReadBBApiCredentialsUseCase>(
          ReadBBApiCredentialsUseCaseImpl.new,
        ),

        AutoBind.factory<UpdateBBApiCredentialsUseCase>(
          UpdateBBApiCredentialsUseCaseImpl.new,
        ),
        AutoBind.factory<RemoveBBApiCredentialsUseCase>(
          RemoveBBApiCredentialsUseCaseImpl.new,
        ),
        //Repositories
        AutoBind.factory<ApiCredentialsRepository>(
          ApiCredentialsRepositoryImpl.new,
        ),
        AutoBind.factory<UserPreferencesRepository>(
          UserPreferencesRepositoryImpl.new,
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/settings', module: SettingsModule()),
        ModuleRoute(
          '/home',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
          duration: const Duration(milliseconds: 300),
        ),
        ModuleRoute('/timeline', module: TimelineModule()),
      ];
}
