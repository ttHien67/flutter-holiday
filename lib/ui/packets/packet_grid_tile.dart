import 'package:flutter/material.dart';
import 'package:holiday/ui/packets/packet_manager.dart';
import '../../models/packet.dart';
import 'package:provider/provider.dart';

import 'packet_detail_screen.dart';

class PacketGridTitle extends StatelessWidget {
  const PacketGridTitle(
    this.packet, {
    super.key,
  });

  final Packet packet;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: buildGridFooterBar(context),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                PacketDetailScreen.routeName,
                arguments: packet.id,
              );
            },
            child: Image(
              image: AssetImage(packet.image),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
        leading: ValueListenableBuilder<bool>(
          valueListenable: packet.isFavoriteListenable,
          builder: (ctx, isFavorite, child) {
            return IconButton(
              icon: Icon(
                packet.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                ctx.read<PacketsManager>().toggleFavoriteStatus(packet);
              },
            );
          },
        ),
        title: Text(
          packet.title,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 20,
          ),
        ));
  }
}
