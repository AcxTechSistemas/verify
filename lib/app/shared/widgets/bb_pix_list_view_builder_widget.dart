import 'package:flutter/material.dart';
import 'package:pix_bb/pix_bb.dart';
import 'package:verify/app/shared/widgets/found_transactions_count_widget.dart';
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
            return Column(
              children: [
                FoundTransactionsCountWidget(length: listPix.length),
                Expanded(
                  //TODO: Implements widgets for failure in search or empty data
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listPix.length,
                    itemBuilder: (context, index) {
                      final pix = listPix[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PixTransactionTileWidget(
                          clientName: pix.pagador.nome,
                          value: pix.valor,
                          date: pix.horario,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
