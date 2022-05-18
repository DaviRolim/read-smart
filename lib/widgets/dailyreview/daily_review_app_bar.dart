import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/daily_review_provider.dart';

class DailyReviewAppBar extends ConsumerWidget with PreferredSizeWidget {
  const DailyReviewAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedPageIndex =
        ref.read(DailyReviewProvider.dailyReviewProvider).currentIndex;
    final dailyReviewHighlightLenght = ref
        .read(DailyReviewProvider.dailyReviewProvider)
        .dailyReview
        .highlights
        .length;
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop()),
      centerTitle: true,
      actions: <Widget>[
        buildTrackCounter(context, (_selectedPageIndex + 1).toString(),
            dailyReviewHighlightLenght.toString())
      ],
      title: Text(
        'Daily Review',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Padding buildTrackCounter(
      BuildContext context, String current, String total) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Center(
        child: Text(current + ' of ' + total,
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
