import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/register_packet.dart';

class RegisterItemCard extends StatefulWidget {
  final RegisterItem register;

  const RegisterItemCard(this.register, {super.key});

  State<RegisterItemCard> createState() => _RegisterItemCardState();
}

class _RegisterItemCardState extends State<RegisterItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            buildRegisterSummary(),
            if (_expanded) buildOrderDetails()
          ],
        ));
  }

  Widget buildRegisterSummary() {
    return ListTile(
        title: Text('\$${widget.register.amount}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(widget.register.dateTime),
        ),
        trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            }));
  }

  Widget buildOrderDetails() {
    
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        height: min(20.0 + 10, 100),
        child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.register.packet!.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.register.packet!.quanlity}x \$${widget.register.packet!.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                ],
              ));
  }
}
