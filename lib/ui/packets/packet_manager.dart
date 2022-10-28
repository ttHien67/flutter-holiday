import '../../models/packet.dart';

class PacketsManager {
  final List<Packet> _items = [
    Packet(
      id: '1',
      title: 'Berlin',
      location: 'Europe',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
      price: 700,
      image: 'assets/image/berlin.jpg',
      isFavorite: true,
    ),
    Packet(
        id: '2',
        title: 'HongKong',
        location: 'Asia',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
        price: 500,
        image: 'assets/image/hong-kong.jpg'),
    Packet(
      id: '3',
      title: 'San Franciso',
      location: 'United States',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
      price: 400,
      image: 'assets/image/san-francisco.jpg',
      isFavorite: true,
    ),
    Packet(
        id: '4',
        title: 'PhuKet',
        location: 'Thailandia',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
        price: 1200,
        image: 'assets/image/phuket.jpg'),
    Packet(
        id: '5',
        title: 'Amsterdam',
        location: 'Netherlands',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
        price: 1500,
        image: 'assets/image/amsterdam.jpg'),
    Packet(
        id: '6',
        title: 'Tuscany',
        location: 'Italy',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut efficitur ante. Donec dapibus dictum scelerisque.',
        price: 730,
        image: 'assets/image/tuscany.jpg'),
  ];

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
}
