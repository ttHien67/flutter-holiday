import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/packet.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService([AuthToken? authToken]) : super(authToken);

  Future<List<Packet>> fetchPackets([bool filterByUser = false]) async {
    final List<Packet> packets = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final packetUrl =
          Uri.parse('$databaseUrl/packets.json?auth=$token&$filters');

      final response = await http.get(packetUrl);
      final packetsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(packetsMap['error']);
        return packets;
      }

      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoriteResponse = await http.get(userFavoriteUrl);
      final userFavoritesMap = json.decode(userFavoriteResponse.body);

      packetsMap.forEach((packetId, packet) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[packetId] ?? false);

        packets.add(
          Packet.fromJson({
            'id': packetId,
            ...packet,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return packets;
    } catch (error) {
      print(error);
      return packets;
    }
  }

  Future<Packet?> addPacket(Packet packet) async {
    try {
      final url = Uri.parse('$databaseUrl/packets.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          packet.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return packet.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }
}
