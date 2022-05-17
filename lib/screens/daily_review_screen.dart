import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/models/DailyReview.dart';
import 'package:read_smart/models/Highlight.dart';
import 'package:read_smart/providers/daily_review_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/widgets/dailyreview/daily_review_app_bar.dart';
import 'package:read_smart/widgets/dailyreview/highlight_container.dart';
import 'package:read_smart/widgets/shared/next_page_button.dart';

class DailyReviewScreen extends ConsumerStatefulWidget {
  const DailyReviewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyReviewScreen> createState() => _DailyReviewScreenState();
}

class _DailyReviewScreenState extends ConsumerState<DailyReviewScreen> {
  final HideNavbar hiding = HideNavbar();
  var pageController = PageController();

  @override
  void initState() {
    var index = ref.read(DailyReviewProvider.dailyReviewProvider).currentIndex;
    pageController = PageController(initialPage: index);
    super.initState();
  }

  void _onNextPagePressed(currentIndex, lenght) {
    setState(() {
      var index = currentIndex;
      if (currentIndex < lenght - 1) {
        index = currentIndex + 1;
      }
      pageController.jumpToPage(index);
      ref.read(DailyReviewProvider.dailyReviewProvider).setCurrentIndex(index);
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
                      color: Color(0xff9d6790),
                      value: ((_selectedPageIndex + 1) /
                          dailyReview.highlights.length),
                    ),
                    // TODO Remove page from here to widget DailyReviewPage
                    Flexible(
                      child: PageView(
                        onPageChanged: (value) {
                          ref
                              .read(DailyReviewProvider.dailyReviewProvider)
                              .setCurrentIndex(value);
                        },
                        controller: pageController,
                        children: dailyReview.highlights
                            .map((highlightExtended) => HighlightContainer(
                                highlight: highlightExtended))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: NextPageButton(
              onPressed: () => _onNextPagePressed(
                  _selectedPageIndex, dailyReview.highlights.length),
            ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  
}
