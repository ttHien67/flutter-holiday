import 'package:flutter/material.dart';

import 'register_manager.dart';
import 'register_item_card.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const routeName = '/register';


  @override
  Widget build(BuildContext context) {
    print('building orders');
    final registerManager = RegisterManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: registerManager.registerCount,
        itemBuilder: (ctx, i) => RegisterItemCard(registerManager.registers[i]),
      ),
    );
  }
}