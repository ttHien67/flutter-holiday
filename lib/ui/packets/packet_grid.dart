import 'package:flutter/material.dart';
import 'package:holiday/models/packet.dart';
import 'package:provider/provider.dart';

import 'packet_grid_tile.dart';
import 'packet_manager.dart';

class PacketsGrid extends StatelessWidget {
  final bool showFavorite;

  const PacketsGrid(this.showFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    final packets = context.select<PacketsManager, List<Packet>>(
        (productsManager) => showFavorite
            ? productsManager.favoriteItems
            : productsManager.items);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: packets.length,
      itemBuilder: (ctx, i) => PacketGridTitle(packets[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}