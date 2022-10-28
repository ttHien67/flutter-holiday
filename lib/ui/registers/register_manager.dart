import 'package:flutter/foundation.dart';

import '../../models/packet_item.dart';

import '../../models/register_packet.dart';

class RegisterManager with ChangeNotifier {
  final List<RegisterItem> _register = [
    RegisterItem(
      id: 'p1',
      amount: 1400,
      packet: 
        PacketItem(id: '1', title: 'Berlin',location: 'Europe', quanlity: 2, price: 700)
      ,
      dateTime: DateTime.now(),
    ),

  ];

  int get registerCount {
    return _register.length;
  }

  List<RegisterItem> get registers {
    return [..._register];
  }
}