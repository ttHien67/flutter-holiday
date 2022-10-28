import 'package:flutter/material.dart';

import '../../models/packet.dart';

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

  Widget buildEditButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        print('Delete a packet');
      },
      color: Theme.of(context).errorColor,
    );
  }

  Widget buildDeleteButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        print('Go to edit packet screen');
      },
      color: Theme.of(context).primaryColor,
    );
  }
}