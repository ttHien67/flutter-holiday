
import 'package:flutter/material.dart';
import 'ui/screens.dart';
import 'ui/registers/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        // home: const SafeArea(child: RegisterScreen()),
        home: const PacketOverviewScreen(),
          routes: {
            UserPacketsScreen.routeName: (ctx) => const UserPacketsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == PacketDetailScreen.routeName) {
              final productId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (ctx) {
                  return PacketDetailScreen(
                    PacketsManager().findById(productId),
                  );
              });
            }
            return null;
          },
        );
  }
}
