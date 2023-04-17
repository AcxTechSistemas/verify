class LoggedUserInfoEntity {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;

  LoggedUserInfoEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
  });
}
