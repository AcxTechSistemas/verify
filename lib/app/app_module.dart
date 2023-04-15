import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/auth/auth_module.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/recover_account_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/register_with_email_usecase.dart';
import 'package:verify/app/modules/auth/external/datasource/firebase/error_handler/firebase_auth_error_handler.dart';
import 'package:verify/app/modules/auth/external/datasource/firebase/firebase_datasource_impl.dart';
import 'package:verify/app/modules/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/modules/auth/infra/repositories/auth_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Auth
        AutoBind.instance<FirebaseAuth>(FirebaseAuth.instance),
        AutoBind.instance<GoogleSignIn>(GoogleSignIn()),
        AutoBind.factory<AuthDataSource>(FirebaseDataSourceImpl.new),
        AutoBind.factory<AuthRepository>(AuthRepositoryImpl.new),
        AutoBind.factory<LoginWithEmailUseCase>(LoginWithEmailUseCaseImpl.new),
        AutoBind.factory<LoginWithGoogleUseCase>(LoginWithGoogleImpl.new),
        AutoBind.factory<RegisterWithEmailUseCase>(
          RegisterWithEmailUseCaseImpl.new,
        ),
        AutoBind.factory<RecoverAccountUseCase>(RecoverAccountUseCaseImpl.new),
        //Error Handler
        AutoBind.instance<SendLogsToWeb>(SendLogsToDiscordChannel()),
        AutoBind.factory<RegisterLog>(RegisterLogImpl.new),
        AutoBind.factory<FirebaseAuthErrorHandler>(
            FirebaseAuthErrorHandler.new),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
      ];
}
