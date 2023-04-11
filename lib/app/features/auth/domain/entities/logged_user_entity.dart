import 'package:equatable/equatable.dart';

abstract class LoggedUserEntity extends Equatable {
  final String email;
  final String name;
  final bool validEmail;

  const LoggedUserEntity({
    required this.email,
    required this.name,
    required this.validEmail,
  });
  @override
  List<Object?> get props => [email, name];
}
