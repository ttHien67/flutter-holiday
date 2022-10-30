import 'package:flutter/material.dart';
import 'package:holiday/ui/packets/packet_manager.dart';
import 'package:provider/provider.dart';

import '../../models/packet.dart';
import 'edit_packet_screen.dart';

class UserPacketListTile extends StatelessWidget {
  final Packet packet;

  const UserPacketListTile(this.packet, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(packet.title),
      leading: CircleAvatar(
        backgroundImage: AssetImage(packet.image),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          buildEditButton(context),
          buildDeleteButton(context),
        ]),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.delete),
     onPressed: () {
        context.read<PacketsManager>().deletePacket(packet.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
              content: Text(
            'Packet deleted',
            textAlign: TextAlign.center,
          )));
      },
      color: Theme.of(context).errorColor,
    );
  }

  Widget buildEditButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditPacketScreen.routeName,
          arguments: packet.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}