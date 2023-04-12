class SicoobApiCredentialsEntity {
  final String clientID;
  final String certificatePassword;
  final String certificateBase64String;
  final bool isFavorite;

  SicoobApiCredentialsEntity(
    this.clientID,
    this.certificatePassword,
    this.certificateBase64String,
    this.isFavorite,
  );
}
