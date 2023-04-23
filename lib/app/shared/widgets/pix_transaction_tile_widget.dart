import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:verify/app/shared/extensions/date_time.dart';
import 'package:verify/app/shared/extensions/string.dart';

class PixTransactionTileWidget extends StatelessWidget {
  final String clientName;
  final double value;
  final DateTime date;
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

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: colorScheme.primary.withOpacity(0.05),
        foregroundColor: colorScheme.primary,
        child: const Icon(Icons.pix),
      ),
      title: Text(
        clientName.capitalize(),
        style: textTheme.titleSmall,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _formattedDateTime(),
        style: textTheme.bodySmall!.copyWith(
          color: colorScheme.secondary,
        ),
      ),
      trailing: Text(
        _brazilianValue(),
        style: textTheme.titleSmall!.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }

  String _brazilianValue() {
    final brazilianValue = UtilBrasilFields.obterReal(value);
    return brazilianValue;
  }

  String _formattedDateTime() {
    final dateTime = date.toBrazilianTimeZone();
    final formattedDate = DateFormat('dd-MMM HH:mm:ss').format(dateTime);
    return formattedDate;
  }
}
