import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/widgets/dailyreview/highlight_container.dart';

import '../../models/DailyReview.dart';
import '../../providers/daily_review_provider.dart';

class DailyReviewPage extends StatelessWidget {
  const DailyReviewPage({
    Key? key,
    required this.ref,
    required this.pageController,
    required this.dailyReview,
    required this.listPage
  }) : super(key: key);

  final WidgetRef ref;
  final PageController pageController;
  final DailyReview? dailyReview;
  final List<Widget> listPage;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView(
        onPageChanged: (value) {
          ref
              .read(DailyReviewProvider.dailyReviewProvider)
              .setCurrentIndex(value);
        },
        controller: pageController,
        children: listPage,
      ),
    );
  }
}
