import 'dart:developer';

import 'package:verify/app/core/send_logs_to_web.dart';

abstract class RegisterError {
  void call(Object e);
}

class RegisterErrorImpl implements RegisterError {
  final SendLogsToWeb _sendLogsToWeb;
  RegisterErrorImpl(this._sendLogsToWeb);
  @override
  void call(Object e) {
    final error = 'Error: $e';
    _sendLogsToWeb(error);
    log(error);
  }
}
