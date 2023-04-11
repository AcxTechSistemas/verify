abstract class SendLogsToWeb {
  void call(String message);
}

class SendLogsToDiscordChannel implements SendLogsToWeb {
  @override
  void call(String message) {}
}
