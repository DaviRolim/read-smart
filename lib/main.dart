import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/providers/theme.dart';
import 'package:read_smart/screens/auth_screen.dart';
import 'package:read_smart/screens/books_screen.dart';
import 'package:read_smart/screens/home_screen.dart';
import 'package:read_smart/screens/landing_screen.dart';

import 'firebase_options.dart';
import 'models/Book.dart';
import 'models/Highlight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HighlightAdapter());
  Hive.registerAdapter(BookAdapter());
  Future.wait([Hive.openBox<Book>('books'), Hive.openBox('userInfo')]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: ReadSmartApp()));
}

class ReadSmartApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<ReadSmartApp> createState() => _ReadSmartAppState();
}

class _ReadSmartAppState extends ConsumerState<ReadSmartApp> {
  @override
  Widget build(BuildContext context) {
    final settings = ValueNotifier(ThemeSettings(
      sourceColor: const Color(0xff8a19e6), // Replace this color
      themeMode: ThemeMode.system,
    ));
    // Default color for texts
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.grey[200],
          displayColor: Colors.grey[200],
        );

    final auth = ref.read(AuthProvider.authProvider);
    return DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => ThemeProvider(
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            settings: settings,
            child: NotificationListener<ThemeSettingChange>(
              onNotification: (notification) {
                settings.value = notification.settings;
                return true;
              },
              child: ValueListenableBuilder<ThemeSettings>(
                  valueListenable: settings,
                  builder: (context, value, _) {
                    // Create theme instance
                    final theme = ThemeProvider.of(context);
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Readsmart',
                      theme: theme.light(settings.value.sourceColor),
                      themeMode: theme.themeMode(),
                      darkTheme: theme.dark(settings.value.sourceColor),
                      home: auth.user != null ? HomeScreen() : LandingScreen(),
                      routes: {
                        AuthScreen.routeName: (ctx) => AuthScreen(
                              isLogin: false,
                            ),
                        HomeScreen.routeName: (ctx) => HomeScreen(),
                        BooksScreen.routeName: (ctx) => BooksScreen(),
                        // MainScreen.routeName: (ctx) => MainScreen(),
                      },
                    );
                  }),
            )));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
