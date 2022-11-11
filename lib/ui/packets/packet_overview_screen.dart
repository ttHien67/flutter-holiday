import 'package:flutter/material.dart';
import 'package:holiday/ui/packets/packet_manager.dart';
import 'package:provider/provider.dart';

import 'packet_grid.dart';
import '../shared/app_drawer.dart';

enum FilterOptions { favorites, all }

class PacketOverviewScreen extends StatefulWidget {
  const PacketOverviewScreen({super.key});

  State<PacketOverviewScreen> createState() => _PacketOverviewScreenState();
}

class _PacketOverviewScreenState extends State<PacketOverviewScreen> {
  var _showOnlyFavorites = ValueNotifier<bool>(false);

  late Future<void> _fetchPackets;

  @override
  void initState() {
    super.initState();
    _fetchPackets = context.read<PacketsManager>().fetchPackets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('MyShop'),
          actions: <Widget>[
            buildProductFilterMenu(),
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _fetchPackets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<bool>(
                valueListenable: _showOnlyFavorites,
                builder: (context, onlyFavorites, child) {
                  return PacketsGrid(onlyFavorites);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          }else {
            _showOnlyFavorites.value = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value:  FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        )
      ],
    );
  }
}