import 'package:equatable/equatable.dart';

abstract class LoggedUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final bool emailVerified;

  const LoggedUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.emailVerified,
  });
  @override
  List<Object?> get props => [id, email, name, emailVerified];
}
