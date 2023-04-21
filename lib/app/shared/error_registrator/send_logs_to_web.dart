// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/domain/usecase/get_logged_user_usecase.dart';
import 'package:verify/app/shared/error_registrator/discord_webhook_url.dart';
import 'package:verify/app/shared/services/client_service/client_service.dart';

abstract class SendLogsToWeb {
  Future<void> call(Object e);
}

class SendLogsToDiscordChannel implements SendLogsToWeb {
  final ClientService _clientService;
  SendLogsToDiscordChannel(
    this._clientService,
  );
  @override
  Future<void> call(Object e) async {
    final getLoggedUser = Modular.get<GetLoggedUserUseCase>();
    final user = await getLoggedUser();
    final userId = user?.id;

    await _clientService.post(
      url: discordWebookUrl,
      body: {'content': '```diff\n+ UserID: $userId\n- Error: $e \n```'},
    );
  }
}
