import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verify/app/shared/themes/custom_colors.dart';

enum Bank {
  sicoob(
    backgroundColor: SicoobColors.verdeEscuro,
    foregroundColor: Color(0xffFFFFFF),
    logoPath: 'assets/svg/sicoob_logo.svg',
  ),
  bancoDoBrasil(
    backgroundColor: BBColors.amareloInstitucional,
    foregroundColor: BBColors.azulInstitucional,
    logoPath: 'assets/svg/bb_logo.svg',
  );

  const Bank({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.logoPath,
  });
  final Color backgroundColor;
  final Color foregroundColor;
  final String logoPath;
}

class AccountListTile extends StatelessWidget {
  final Bank bank;
  final bool hasCredentials;
  final void Function()? onTap;
  const AccountListTile({
    super.key,
    required this.bank,
    required this.hasCredentials,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 17, 24, 17),
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bank.backgroundColor,
        ),
        child: Row(
          children: [
            SvgPicture.asset(bank.logoPath),
            const Spacer(),
            Text(
              hasCredentials ? 'Conectada' : 'Desconectada',
              style: const TextStyle().copyWith(color: bank.foregroundColor),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              maxRadius: 4,
              backgroundColor: hasCredentials ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
