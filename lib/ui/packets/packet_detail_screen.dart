import 'package:flutter/material.dart';

import '../../models/packet.dart';

class PacketDetailScreen extends StatelessWidget {
  static const routeName = '/packet-detail';

  const PacketDetailScreen(
    this.packet, {
    super.key,
  });

  final Packet packet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packet.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(packet.image),
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            packet.location,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$${packet.price}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              packet.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),

          SizedBox(
            height: 50,
          ),
          Container(   
            child: FlatButton(  
              child: Text('Register', style: TextStyle(fontSize: 20.0)),  
              color: Colors.blueGrey,  
              textColor: Colors.white,  
              onPressed: () {},  
            ),  
          ),
        ],
      )),
    );
  }
}
