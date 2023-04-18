import 'dart:developer';

abstract class RegisterLog {
  void call(Object e);
}

class RegisterLogImpl implements RegisterLog {
  @override
  void call(Object e) async {
    final error = 'Error: $e';
    log(error);
  }
}
