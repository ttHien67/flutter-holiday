import 'package:flutter/material.dart';

import 'packet_grid.dart';
import '../shared/app_drawer.dart';

enum FilterOptions { favorites, all }

class PacketOverviewScreen extends StatefulWidget {
  const PacketOverviewScreen({super.key});

  State<PacketOverviewScreen> createState() => _PacketOverviewScreenState();
}

class _PacketOverviewScreenState extends State<PacketOverviewScreen> {
  var _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holiday'),
        actions: <Widget>[
          buildProductFilterMenu(),
        ],
      ),
      drawer: const AppDrawer(),
      body: PacketsGrid(_showOnlyFavorite),
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorite = true;
          }else {
            _showOnlyFavorite = false;
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