import 'package:flutter/material.dart';
import 'package:pix_sicoob/pix_sicoob.dart';
import 'package:verify/app/shared/widgets/found_transactions_count_widget.dart';
import 'package:verify/app/shared/widgets/pix_transaction_tile_widget.dart';

class SicoobPixListViewBuilder extends StatelessWidget {
  final Future<List<Pix>> future;
  const SicoobPixListViewBuilder({
    super.key,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:

            //TODO: Implements widgets for failure in search or empty data
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nenhuma transação encontrada'),
                );
              }
              final listPix = snapshot.data!;
              return Column(
                children: [
                  FoundTransactionsCountWidget(length: listPix.length),
                  Expanded(
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
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error ?? '');
            } else {
              return ErrorWidget('');
            }
        }
      },
    );
  }
}
