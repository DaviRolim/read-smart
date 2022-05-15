import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/providers/daily_review_provider.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/providers/notifier_enum.dart';
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
    ref.read(DailyReviewProvider.dailyReviewProvider).fetchUserStreak();
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
    final currentStreak =
        ref.watch(DailyReviewProvider.dailyReviewProvider).currentStreak;
    // final streakState = ref.watch(DailyReviewProvider.dailyReviewProvider).state;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.notifications_outlined,
          color: Color(0xffFBC646),
          size: 26,
        ),
        centerTitle: true,
        actions: <Widget>[
          Center(
              child: currentStreak != null
                  ? Text(currentStreak.toString(),
                      style: Theme.of(context).textTheme.bodyMedium)
                  : Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Color(0xff9d6790),),
                  )),
          SizedBox(width: 5),
          Container(
              padding: EdgeInsets.only(right: 10),
              width: 45,
              height: 45,
              child: Image.asset('assets/icons/trophy-icon.png'))
        ],
        title: Text(
          'Readsmart',
          style: Theme.of(context).textTheme.titleMedium,
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
