import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/screens.dart';
import 'ui/registers/register_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, PacketsManager>(
            create: (ctx) => PacketsManager(),
            update: (ctx, authManager, packetsManager) {
              packetsManager!.authToken = authManager.authToken;
              return packetsManager;
            },
          )
        ],
        child: Consumer<AuthManager>(builder: (ctx, authManager, child) {
          return MaterialApp(
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
            home: authManager.isAuth
                ? const PacketOverviewScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: ((context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    })),
            routes: {
              RegisterScreen.routeName: (ctx) => const UserPacketsScreen(),
              UserPacketsScreen.routeName: (ctx) => const UserPacketsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == PacketDetailScreen.routeName) {
                final packetId = settings.arguments as String?;
                return MaterialPageRoute(builder: (ctx) {
                  return PacketDetailScreen(
                    packetId != null 
                      ? ctx.read<PacketsManager>().findById(packetId)
                      : null,
                  );
                });
              }
              
              if (settings.name == EditPacketScreen.routeName) {
                final packetId = settings.arguments as String?;
                return MaterialPageRoute(builder: (ctx) {
                  return EditPacketScreen(
                    packetId != null
                        ? ctx.read<PacketsManager>().findById(packetId)
                        : null,
                  );
                });
              }

              return null;
            },
          );
        }));
  }
}
