// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'packet_manager.dart';
import 'package:provider/provider.dart';

import '../../models/packet.dart';
import '../shared/dialog_utils.dart';

class PacketDetailScreen extends StatefulWidget {
  static const routeName = '/packet-detail';

  PacketDetailScreen(
    Packet? packet, {
    super.key,
  }) {
    if (packet == null) {
      this.packet = Packet(
          id: null,
          title: '',
          location: '',
          description: '',
          price: 0,
          image: '');
    } else {
      this.packet = packet;
    }
  }

  late final Packet packet;

  @override
  State<PacketDetailScreen> createState() => _PacketDetailScreenState();
}

class _PacketDetailScreenState extends State<PacketDetailScreen> {
  late Packet _packet;

  @override
  void initState() {
    _packet = widget.packet;
    super.initState();
  }

  Future<void> savePacketRegister() async {
    try {
      final packetsManager = context.read<PacketsManager>();
      await packetsManager.saveUserRegister(_packet.id);
    } catch (error) {
      await showErrorDialog(context, 'Some went wrong.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_packet.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(_packet.image),
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            _packet.location,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$${_packet.price}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              _packet.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: () {
              savePacketRegister();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                    content: Text(
                  'Your packet has registered',
                  textAlign: TextAlign.center,
                )));
            },
            child: const Text('Register', style: TextStyle(fontSize: 20.0)),
          ),
        ],
      )),
    );
  }
}
