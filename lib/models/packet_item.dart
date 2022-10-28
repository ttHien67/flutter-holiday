class PacketItem {
  final String id;
  final String title;
  final String location;
  final int quanlity;
  final double price;

  PacketItem({
    required this.id,
    required this.title,
    required this.location,
    required this.quanlity,
    required this.price,
  });

  PacketItem copyWith({
    String? id,
    String? title,
    String? location,
    int? quanlity,
    double? price,
  }){
    return PacketItem(
        id: id ?? this.id,
        title: title ?? this.title,
        location: location ?? this.location,
        quanlity: quanlity ?? this.quanlity,
        price: price ?? this.price);
  }
}