import 'packet_item.dart';

class RegisterItem {
  final String? id;
  final double amount;
  final PacketItem? packet;
  final DateTime dateTime;

  // int get packetCount {
  //   return packets.length;
  // }

  RegisterItem({
    this.id,
    required this.amount,
    required this.packet,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  RegisterItem copyWith({
    String? id,
    double? amount,
    PacketItem? packet,
    DateTime? dateTime,
  }) {
    return RegisterItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      packet: packet ?? this.packet,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}