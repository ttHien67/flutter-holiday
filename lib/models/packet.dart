class Packet {
  final String? id;
  final String title;
  final String location;
  final double price;
  final String image;
  final String description;
  final bool isFavorite;

  Packet({
    this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.description,
    this.isFavorite = false,
  });

  Packet copyWith({
    String? id,
    String? title,
    String? location,
    double? price,
    String? image,
    String? description,
    bool? isFavorite,
  }) {
    return Packet(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
