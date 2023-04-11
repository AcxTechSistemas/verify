import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButton extends StatelessWidget {
  final String? title;
  final void Function() onTap;
  final bool isLoading;
  const GoogleSignInButton({
    super.key,
    required this.onTap,
    this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 10, 0, 10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/google_logo.svg'),
                    const Spacer(),
                    Text(
                      title == null ? 'Entre com Google' : title!,
                      style: GoogleFonts.roboto(
                        letterSpacing: 0.25,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
