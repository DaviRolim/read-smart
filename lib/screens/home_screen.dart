import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/repository/auth_repository.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';
import 'package:read_smart/screens/sync_highlights_screen.dart';
import 'package:read_smart/widgets/home/home_content.dart';

import '../models/Book.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedPageIndex = 0;
  final HideNavbar hiding = HideNavbar();
  List<Widget> _pages = [];
  @override
  void initState() {
    _pages = <Widget>[
      HomeContent(),
      SyncHighlightsScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.notifications, color: Colors.white70),
        centerTitle: true,
        actions: <Widget>[
          // Add Text later to display the current streak
          IconButton(
            icon: const Icon(
              Icons.bolt,
              color: Colors.white70,
            ),
            tooltip: 'Streak',
            onPressed: () {
              // handle the press
            },
          ),
        ],
        title: Text(
          'Read Smart',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: Container(child: _pages[_selectedPageIndex]),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: hiding.visible,
        builder: (context, bool value, child) => AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: value ? kBottomNavigationBarHeight : 0.0,
          child: Wrap(
            children: [
              BottomNavigationBar(
                onTap: _selectPage,
                elevation: 3,
                unselectedItemColor: Colors.grey[600],
                selectedItemColor: Colors.grey[200],
                currentIndex: _selectedPageIndex,
                backgroundColor: Colors.grey[900],
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sync), label: 'Sync'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
