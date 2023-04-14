abstract class SendLogsToWeb {
  Future<void> call(Object e);
}

class SendLogsToDiscordChannel implements SendLogsToWeb {
  @override
  Future<void> call(Object e) async {}
}
