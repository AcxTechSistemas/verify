// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum VersionStatus {
  upToDate,
  inactive,
  requiredUpdate,
  optionalUpdate,
  unknown,
}

class VersionModel extends Equatable {
  final VersionStatus status;
  final String? title;
  final String? body;
  final List<String> news;
  const VersionModel({
    required this.status,
    required this.news,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [status, title, body];
}
