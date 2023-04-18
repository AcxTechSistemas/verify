// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';

class SicoobApiCredentialsModel implements SicoobApiCredentialsEntity {
  @override
  final String clientID;
  @override
  final String certificateBase64String;
  @override
  final String certificatePassword;
  @override
  final bool isFavorite;

  SicoobApiCredentialsModel({
    required this.clientID,
    required this.certificateBase64String,
    required this.certificatePassword,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientID': clientID,
      'certificateBase64String': certificateBase64String,
      'certificatePassword': certificatePassword,
      'isFavorite': isFavorite,
    };
  }

  factory SicoobApiCredentialsModel.fromMap(Map<String, dynamic> map) {
    return SicoobApiCredentialsModel(
      clientID: map['clientID'] as String,
      certificateBase64String: map['certificateBase64String'] as String,
      certificatePassword: map['certificatePassword'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SicoobApiCredentialsModel.fromJson(String source) {
    return SicoobApiCredentialsModel.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  SicoobApiCredentialsModel copyWith({
    String? clientID,
    String? certificateBase64String,
    String? certificatePassword,
    bool? isFavorite,
  }) {
    return SicoobApiCredentialsModel(
      clientID: clientID ?? this.clientID,
      certificateBase64String:
          certificateBase64String ?? this.certificateBase64String,
      certificatePassword: certificatePassword ?? this.certificatePassword,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
