import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_smart/helpers/custom_page_route.dart';
import 'package:read_smart/screens/daily_review_screen.dart';
import 'package:read_smart/widgets/home/headline_card.dart';
import 'package:read_smart/widgets/home/section_card.dart';

import '../../providers/daily_review_provider.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  @override
  void initState() {
    // TODO Should Emit the HomeContentInitEvent
    // and the provider would run the code below
    final dailyReviewProvider =
        ref.read(DailyReviewProvider.dailyReviewProvider);
    if (dailyReviewProvider.dailyReview.highlights.isEmpty) {
      ref.read(DailyReviewProvider.dailyReviewProvider).getDailyReview();
    }
    ref.read(DailyReviewProvider.dailyReviewProvider).fetchUserStreak();
    super.initState();
  }

  final _image = AssetImage("assets/images/daily-review-bg.webp");

  final _textTop = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final todayProgressText =
        ref.watch(DailyReviewProvider.dailyReviewProvider).progressText;
    final finishedReview =
        ref.read(DailyReviewProvider.dailyReviewProvider).dailyReview.finished;
    return Container(
        // color: Colors.black54,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            HeadlineCard(
                title: 'Daily Review',
                image: _image,
                textTop: _textTop,
                body: _buildBody(context, finishedReview, todayProgressText),
                ontap: () => Navigator.of(context)
                    .push(CustomPageRoute(DailyReviewScreen()))),
            SizedBox(height: 18.0),
            SectionCard(title: 'Books'),
            SizedBox(height: 5.0),
            SectionCard(title: 'Summaries'),
          ],
        ));
  }

  _buildBody(
      BuildContext context, bool finishedReview, String? todayProgressText) {
    return Flexible(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            if (finishedReview)
              ClipOval(
                child: Material(
                  // color: Colors.grey[100],
                  child: SizedBox(
                    child: Icon(
                      Icons.done_rounded,
                      // color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ),
            SizedBox(width: 5),
            Text(
              todayProgressText ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Theme.of(context).colorScheme.background),
            ),
          ],
        ),
      ),
    );
  }
}
