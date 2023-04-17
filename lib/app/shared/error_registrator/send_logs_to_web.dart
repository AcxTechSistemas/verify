import 'package:verify/app/shared/services/client_service/client_service.dart';

abstract class SendLogsToWeb {
  Future<void> call(Object e);
}

class SendLogsToDiscordChannel implements SendLogsToWeb {
  final ClientService _clientService;
  SendLogsToDiscordChannel(this._clientService);
  @override
  Future<void> call(Object e) async {
    await _clientService.post(
      url:
          'https://discord.com/api/webhooks/1083091280659226675/2tQn2yBfvKdo4gV6zAXnPyL3CzUhHzbRGyGIiB21Z8CYZUudvh8OLrDV-RoS-syN56V-',
      body: e.toString(),
    );
  }
}
