import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../models/packet.dart';

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
      leading: IconButton(
        icon: Icon(
          packet.isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          print('Toggle a favorite packet');
        },
      ),
      title: Text(
        packet.title,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 20,
        ),
      )
    );
  }
}