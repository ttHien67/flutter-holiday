import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_packet_screen.dart';
import 'user_packet_list_tile.dart';
import 'packet_manager.dart';
import '../shared/app_drawer.dart';

class UserPacketsScreen extends StatelessWidget {
  static const routeName = '/user-packets';
  const UserPacketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packetManager = PacketsManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Packets'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh packets'),
        child: buildUserPacketListView(packetManager),
      ),
    );
  }

  Widget buildUserPacketListView(PacketsManager packetsManager) {
     return Consumer<PacketsManager>(builder: (ctx, productManager, child) {
      return ListView.builder(
        itemCount: packetsManager.itemCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            UserPacketListTile(
              packetsManager.items[i],
            ),
            const Divider()
          ],
        ),
      );
    });
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditPacketScreen.routeName,
        );
      },
    );
  }
}
