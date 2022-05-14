import 'package:badges/badges.dart';
import 'package:dartz/dartz.dart';
import 'package:read_smart/helpers/custom_page_route.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/models/failure.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/screens/home_screen.dart';
import 'package:read_smart/screens/sync_highlights_screen.dart';
import 'package:read_smart/widgets/auth/auth_form.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key});
  static const routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<LandingScreen> {
  List<Map<String, dynamic>> _pages = [];
  int _selectedPageIndex = 0;
  final HideNavbar hiding = HideNavbar();
  bool isAuth = false;

  @override
  void initState() {
    _pages = [
      // {
      //   'page': HomeScreen(
      //     controller: hiding.controller,
      //   ),
      // },
      // {
      //   'page': OrdersScreen(),
      //   'appBarTitle': Text(
      //     'Pedidos',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // },
      {
        'page': AuthScreen(),
        'appBarTitle': Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
      },
      // {
      //   'page': ForSale(),
      //   'title': 'algo pra colocar no appBar',
      // },
      // {
      //   'page': CartScreen(),
      // },
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // final cartProvider = CartProvider.cartProvider;

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.read(AuthProvider.authProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/read-smart-home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Text(
                  'Revisit your highligts, remember more of what you read, generate new insights.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.0),
                Container(
                  width: 180,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(CustomPageRoute(AuthForm(
                      //   isLogin: false,
                      // )));
                      // ref.read(HighlightsProvider.highlightsProvider).fetchHighlghts();
                      Navigator.of(context).push(CustomPageRoute(HomeScreen()));
                      // Navigator.of(context).push(CustomPageRoute(SyncHighlightsScreen()));
                    },
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff9d6790),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(CustomPageRoute(AuthForm(
                      isLogin: true,
                    )));
                  },
                  child: Text(
                    'Sign in as an existing user',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ) /* add child content here */,
      ),
    );
  }
}
