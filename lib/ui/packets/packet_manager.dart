import '../../models/packet.dart';
import 'package:flutter/foundation.dart';

import '../../services/packets_service.dart';
import '../../models/packet.dart';
import '../../models/auth_token.dart';
import '../../services/packets_service.dart';


class PacketsManager with ChangeNotifier {
  // final List<Packet> _items = [
  //   Packet(
  //     id: '1',
  //     title: 'Berlin',
  //     location: 'Europe',
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //     price: 700,
  //     image: 'assets/image/berlin.jpg',
  //     isFavorite: true,
  //   ),
  //   Packet(
  //       id: '2',
  //       title: 'HongKong',
  //       location: 'Asia',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //       price: 500,
  //       image: 'assets/image/hong-kong.jpg'),
  //   Packet(
  //     id: '3',
  //     title: 'San Franciso',
  //     location: 'United States',
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //     price: 400,
  //     image: 'assets/image/san-francisco.jpg',
  //     isFavorite: true,
  //   ),
  //   Packet(
  //       id: '4',
  //       title: 'PhuKet',
  //       location: 'Thailandia',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //       price: 1200,
  //       image: 'assets/image/phuket.jpg'),
  //   Packet(
  //       id: '5',
  //       title: 'Amsterdam',
  //       location: 'Netherlands',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //       price: 1500,
  //       image: 'assets/image/amsterdam.jpg'),
  //   Packet(
  //       id: '6',
  //       title: 'Tuscany',
  //       location: 'Italy',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
  //       price: 730,
  //       image: 'assets/image/tuscany.jpg'),
  // ];
  List<Packet> _items = [];

  final ProductsService _packetsService;

  PacketsManager([AuthToken? authToken])
      : _packetsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _packetsService.authToken = authToken;
  }

  Future<void> fetchPackets([bool filterByuser = false]) async {
    _items = await _packetsService.fetchPackets(filterByuser);
    notifyListeners();
  }

  Future<void> addPacket(Packet packet) async {
    final newPacket = await _packetsService.addPacket(packet);
    if (newPacket != null) {
      _items.add(newPacket);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Packet> get items {
    return [..._items];
  }

  List<Packet> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Packet findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void addPacket(Packet packet) {
  //   _items.add(packet.copyWith(
  //     id: 'p${DateTime.now().toIso8601String()}',
  //   ));
  //   notifyListeners();
  // }

  void updatePacket(Packet packet) {
    final index = _items.indexWhere((item) => item.id == packet.id);
    if (index >= 0) {
      _items[index] = packet;
      notifyListeners();
    }
  }

  void toggleFavoriteStatus(Packet packet) {
    final savedStatus = packet.isFavorite;
    packet.isFavorite = !savedStatus;
  }

  void deletePacket(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}
