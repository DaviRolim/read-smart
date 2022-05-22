import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/models/DailyReview.dart';
import 'package:read_smart/models/Highlight.dart';
import 'package:read_smart/providers/daily_review_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/widgets/dailyreview/daily_review_app_bar.dart';
import 'package:read_smart/widgets/dailyreview/done_page.dart';
import 'package:read_smart/widgets/dailyreview/highlight_container.dart';
import 'package:read_smart/widgets/shared/next_page_button.dart';

import '../widgets/dailyreview/daily_review_page.dart';

class DailyReviewScreen extends ConsumerStatefulWidget {
  const DailyReviewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyReviewScreen> createState() => _DailyReviewScreenState();
}

class _DailyReviewScreenState extends ConsumerState<DailyReviewScreen> {
  final HideNavbar hiding = HideNavbar();
  var pageController = PageController();
  late List<Widget> listPages;

  @override
  void initState() {
    var index = ref.read(DailyReviewProvider.dailyReviewProvider).currentIndex;
    pageController = PageController(initialPage: index);
    listPages = ref
        .read(DailyReviewProvider.dailyReviewProvider)
        .dailyReview
        .highlights
        .map<Widget>((highlightExtended) =>
            HighlightContainer(highlight: highlightExtended))
        .toList();

    listPages.add(DonePage());
    super.initState();
  }

  void _onNextPagePressed(int currentIndex, int lenght) {
    setState(() {
      var index = currentIndex;
      if (currentIndex < lenght) {
        index = currentIndex + 1;
      }
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DailyReview? dailyReview =
        ref.read(DailyReviewProvider.dailyReviewProvider).dailyReview;
    final int _selectedPageIndex =
        ref.watch(DailyReviewProvider.dailyReviewProvider).currentIndex;
    return dailyReview!.highlights.length > 0
        ? Scaffold(
            appBar: DailyReviewAppBar(),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: ((_selectedPageIndex + 1) /
                          dailyReview.highlights.length),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DailyReviewPage(
                        ref: ref,
                        pageController: pageController,
                        dailyReview: dailyReview,
                        listPage: listPages),
                  ],
                ),
              ),
            ),
            floatingActionButton: NextPageButton(onPressed: () {
              final highlightsLength = dailyReview.highlights.length;
              if (_selectedPageIndex == highlightsLength) {
                Navigator.of(context).pop();
              } else {
                _onNextPagePressed(_selectedPageIndex, highlightsLength);
              }
            }))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
