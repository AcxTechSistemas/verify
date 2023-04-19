import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PixTransactionTileWidget extends StatelessWidget {
  final String clientName;
  final String value;
  final String date;
  const PixTransactionTileWidget({
    super.key,
    required this.clientName,
    required this.value,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final doubleValue = double.parse(value);
    final brazilianValue = UtilBrasilFields.obterReal(doubleValue);
    final dateTime = DateTime.parse(date).subtract(const Duration(hours: 3));
    final formattedDate = DateFormat('dd-MMM HH:mm:ss').format(dateTime);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: colorScheme.primary.withOpacity(0.05),
        foregroundColor: colorScheme.primary,
        child: const Icon(Icons.pix),
      ),
      title: Text(
        clientName,
        style: textTheme.titleSmall,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        formattedDate,
        style: textTheme.bodySmall!.copyWith(
          color: colorScheme.secondary,
        ),
      ),
      trailing: Text(
        brazilianValue,
        style: textTheme.titleSmall!.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
