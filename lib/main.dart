import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/screens/auth_screen.dart';
import 'package:read_smart/screens/home_screen.dart';
import 'package:read_smart/screens/landing_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: ReadSmartApp()));
}

class ReadSmartApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default color for texts
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.grey[200],
          displayColor: Colors.grey[200],
        );

    final auth = ref.read(AuthProvider.authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        cardColor: Colors.grey[900],
        textTheme: newTextTheme.copyWith(
          titleLarge: TextStyle(
              color: Colors.grey[100],
              fontSize: 28,
              fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              color: Colors.grey[300],
              fontSize: 18,
              fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              color: Colors.grey[200],
              fontSize: 18,
              fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(
            color: Colors.grey[300],
            fontSize: 15,
          ),
          labelMedium: TextStyle(
            color: Colors.grey[400],
            fontSize: 13,
          ),
          bodySmall: TextStyle(color: Colors.white70),
        ),
      ),
      home: auth.user != null ? HomeScreen() : LandingScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        // MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}
