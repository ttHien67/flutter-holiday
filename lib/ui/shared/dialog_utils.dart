import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: const Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  child: const Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  })
            ],
          ));
}