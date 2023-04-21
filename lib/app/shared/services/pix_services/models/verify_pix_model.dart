class VerifyPixModel {
  final String clientName;
  final String? documment;
  final String? paymentClientInfo;
  final double value;
  final DateTime date;

  VerifyPixModel({
    required this.clientName,
    this.documment,
    this.paymentClientInfo,
    required this.value,
    required this.date,
  });
}
