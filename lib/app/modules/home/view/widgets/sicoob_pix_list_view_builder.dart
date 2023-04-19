import 'package:flutter/material.dart';
import 'package:pix_sicoob/pix_sicoob.dart';

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
            final listPix = snapshot.data!;
            return ListView.builder(
              itemCount: listPix.length,
              itemBuilder: (context, index) {
                final pix = listPix[index];
                return Text(pix.pagador.nome);
              },
            );
        }
      },
    );
  }
}
