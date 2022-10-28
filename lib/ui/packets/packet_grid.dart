import 'package:flutter/material.dart';

import 'packet_grid_tile.dart';
import 'packet_manager.dart';

class PacketsGrid extends StatelessWidget {
  final bool showFavorite;

  const PacketsGrid(this.showFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    final packetManager = PacketsManager();
    final products =
        showFavorite ? packetManager.favoriteItems : packetManager.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => PacketGridTitle(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}