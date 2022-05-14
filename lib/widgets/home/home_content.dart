import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_smart/helpers/custom_page_route.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/screens/daily_review_screen.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            _buildPrimaryCard(context),
            SizedBox(height: 18.0),
            _buildSecondaryCard(context, 'Books', null),
            SizedBox(height: 5.0),
            _buildSecondaryCard(context, 'Summaries', null),
          ],
        ));
  }

  Container _buildSecondaryCard(
      BuildContext context, String title, Function? ontap) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      child: InkWell(
        onTap: () => ontap,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xff9d6790),
          elevation: 2,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              )),
        ),
      ),
    );
  }

  Container _buildPrimaryCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          final dailyReview =
              ref.read(HighlightsProvider.highlightsProvider).dailyReview;
          if (dailyReview.highlights.isEmpty) {
            ref.read(HighlightsProvider.highlightsProvider).getDailyReview();
          }
          Navigator.of(context).push(CustomPageRoute(DailyReviewScreen()));
        },
        child: Card(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("assets/images/daily-review-bg.webp"),
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(Color(0xff466964), BlendMode.overlay),
                  opacity: 0.65
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: 13),
                  Text('Daily Review',
                      style: Theme.of(context).textTheme.titleLarge),
                  Flexible(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          ClipOval(
                            child: Material(
                              color: Colors.grey[100],
                              child: SizedBox(
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "You've completed today's review.",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
