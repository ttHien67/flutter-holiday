import 'package:flutter/cupertino.dart';

class Packet {
  final String? id;
  final String title;
  final String location;
  final double price;
  final String image;
  final String description;
  final ValueNotifier<bool> _isFavorite;

  Packet({
    this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.description,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

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
