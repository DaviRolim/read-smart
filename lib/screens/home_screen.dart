import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/providers/daily_review_provider.dart';
import 'package:read_smart/providers/sync_provider.dart';
import 'package:read_smart/screens/sync_highlights_screen.dart';
import 'package:read_smart/widgets/home/home_content.dart';
import 'package:read_smart/widgets/shared/brightness_toggle.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home';

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
    final currentStreak =
        ref.watch(DailyReviewProvider.dailyReviewProvider).currentStreak;

    final syncState = ref.watch(SyncProvider.syncProvider).state;
    // final streakState = ref.watch(DailyReviewProvider.dailyReviewProvider).state;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BrightnessToggle(),
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
                      child: CircularProgressIndicator(
                        color: Color(0xff9d6790),
                      ),
                    )),
          SizedBox(width: 5),
          Container(
              padding: EdgeInsets.only(right: 10),
              width: 45,
              height: 45,
              child: Image.asset('assets/icons/trophy-icon.png'))
        ],
        title: Text('readsmart',
            style: GoogleFonts.comfortaa(
              textStyle: Theme.of(context).textTheme.headlineSmall,
            )),
      ),
      body: Column(
        children: [
          if (syncState == NotifierState.loading)
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                height: 40,
                color: Colors.green[600],
                child: Center(
                    child: FadingText('Synchronizing Books',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary))),
              ),
            ),
          Container(child: _pages[_selectedPageIndex]),
        ],
      ),
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
                currentIndex: _selectedPageIndex,
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
