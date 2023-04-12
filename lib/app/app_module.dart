import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:verify/app/features/auth/auth_module.dart';
import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/features/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/features/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/features/auth/domain/usecase/recover_account_usecase.dart';
import 'package:verify/app/features/auth/domain/usecase/register_with_email_usecase.dart';
import 'package:verify/app/features/auth/external/datasource/firebase/firebase_datasource.dart';
import 'package:verify/app/features/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/features/auth/infra/repositories/auth_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
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
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
      ];
}
