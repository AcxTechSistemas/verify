import 'package:flutter/material.dart';
import 'package:pix_bb/pix_bb.dart';
import 'package:verify/app/shared/widgets/pix_transaction_tile_widget.dart';

class BBPixListViewBuilder extends StatefulWidget {
  final Future<List<Pix>> future;
  const BBPixListViewBuilder({
    super.key,
    required this.future,
  });

  @override
  State<BBPixListViewBuilder> createState() => _BBPixListViewBuilderState();
}

class _BBPixListViewBuilderState extends State<BBPixListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            final listPix = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Transações encontradas',
                        style: textTheme.titleSmall!.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${listPix.length}',
                          style: textTheme.titleSmall!.copyWith(
                            color: colorScheme.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listPix.length,
                      itemBuilder: (context, index) {
                        final pix = listPix[index];
                        return PixTransactionTileWidget(
                          clientName: pix.pagador.nome,
                          value: pix.valor,
                          date: pix.horario,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
