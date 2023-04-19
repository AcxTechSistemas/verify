import 'package:flutter/material.dart';

class AccountCardWidget extends StatefulWidget {
  final String imageAsset;
  final bool hasCredentials;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function()? setFavorite;
  const AccountCardWidget({
    super.key,
    required this.imageAsset,
    required this.hasCredentials,
    this.onTap,
    required this.isFavorite,
    this.setFavorite,
  });

  @override
  State<AccountCardWidget> createState() => _AccountCardWidgetState();
}

class _AccountCardWidgetState extends State<AccountCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Visibility(
              visible: !widget.hasCredentials,
              child: SizedBox(
                width: constraints.maxWidth * 0.9,
                height: constraints.maxHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Toque para configurar',
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.primary,
                      ),
                    ),
                    const Icon(
                      Icons.touch_app,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Image.asset(
                widget.imageAsset,
                opacity: widget.hasCredentials
                    ? null
                    : const AlwaysStoppedAnimation<double>(0.2),
              ),
            ),
            Visibility(
              visible: widget.hasCredentials,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.07,
                    horizontal: constraints.maxWidth * 0.015,
                  ),
                  child: IconButton(
                    onPressed: widget.setFavorite,
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: const Color(0xFF91D888),
                      size: constraints.maxHeight * 0.16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
