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
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Toque para configurar',
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                    const Icon(Icons.touch_app),
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
                    : const AlwaysStoppedAnimation<double>(0.3),
              ),
            ),
            Visibility(
              visible: widget.hasCredentials,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * 0.03),
                  child: IconButton(
                    onPressed: widget.setFavorite,
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: colorScheme.onInverseSurface,
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
