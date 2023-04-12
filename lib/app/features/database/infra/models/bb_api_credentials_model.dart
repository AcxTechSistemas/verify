// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';

class BBApiCredentialsModel implements BBApiCredentialsEntity {
  @override
  final String applicationDeveloperKey;
  @override
  final String basicKey;
  @override
  final bool isFavorite;

  BBApiCredentialsModel({
    required this.applicationDeveloperKey,
    required this.basicKey,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicationDeveloperKey': applicationDeveloperKey,
      'basicKey': basicKey,
      'isFavorite': isFavorite,
    };
  }

  factory BBApiCredentialsModel.fromMap(Map<String, dynamic> map) {
    return BBApiCredentialsModel(
      applicationDeveloperKey: map['applicationDeveloperKey'] as String,
      basicKey: map['basicKey'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BBApiCredentialsModel.fromJson(String source) {
    return BBApiCredentialsModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }
}
