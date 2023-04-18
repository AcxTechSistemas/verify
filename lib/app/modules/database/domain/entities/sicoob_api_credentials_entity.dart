class SicoobApiCredentialsEntity {
  final String clientID;
  final String certificatePassword;
  final String certificateBase64String;
  final bool isFavorite;

  SicoobApiCredentialsEntity({
    required this.clientID,
    required this.certificatePassword,
    required this.certificateBase64String,
    required this.isFavorite,
  });
}
