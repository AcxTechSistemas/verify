import 'package:flutter/material.dart';
import 'package:verify/app/shared/services/pix_services/models/verify_pix_model.dart';
import 'package:verify/app/shared/widgets/custom_error_widget.dart';
import 'package:verify/app/shared/widgets/found_transactions_count_widget.dart';
import 'package:verify/app/shared/widgets/pix_transaction_tile_widget.dart';
import 'package:verify/app/shared/widgets/transactions_not_found_widget.dart';

class PixListViewBuilder extends StatelessWidget {
  final Future<List<VerifyPixModel>> future;
  final String? replacementTitle;
  const PixListViewBuilder({
    super.key,
    required this.future,
    this.replacementTitle,
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
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: TransactionsNotFoundWidget(),
                );
              }
              final listPix = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: listPix.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return FoundTransactionsCountWidget(
                      replacementTitle: replacementTitle,
                      length: listPix.length,
                    );
                  } else {
                    final pix = listPix[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PixTransactionTileWidget(
                        clientName: pix.clientName,
                        value: pix.value,
                        date: pix.date,
                      ),
                    );
                  }
                },
              );
            }
            if (snapshot.hasError) {
              return const CustomErrorWidget();
            } else {
              return const CustomErrorWidget();
            }
        }
      },
    );
  }
}
