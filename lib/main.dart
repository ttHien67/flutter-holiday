import 'package:flutter/material.dart';
import 'ui/screens.dart';
import 'ui/registers/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => PacketsManager(),
          )
        ],
        child: MaterialApp(
          title: 'My Holiday',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blueGrey,
              ).copyWith(
                secondary: Colors.deepOrange,
              )),
          // home: const SafeArea(child: RegisterScreen()),
          home: const PacketOverviewScreen(),
          routes: {
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            UserPacketsScreen.routeName: (ctx) => const UserPacketsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == PacketDetailScreen.routeName) {
              final packetId = settings.arguments as String;
              return MaterialPageRoute(builder: (ctx) {
                return PacketDetailScreen(
                  ctx.read<PacketsManager>().findById(packetId),
                );
              });
            }
            return null;
          },
        ));
  }
}
