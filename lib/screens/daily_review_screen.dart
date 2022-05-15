import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/helpers/hider_navbar.dart';
import 'package:read_smart/models/DailyReview.dart';
import 'package:read_smart/models/Highlight.dart';
import 'package:read_smart/providers/highlights_provider.dart';

class DailyReviewScreen extends ConsumerStatefulWidget {
  const DailyReviewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyReviewScreen> createState() => _DailyReviewScreenState();
}

class _DailyReviewScreenState extends ConsumerState<DailyReviewScreen> {
  int _selectedPageIndex = 0;
  final HideNavbar hiding = HideNavbar();
  final pageController = PageController(initialPage: 0);

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DailyReview? dailyReview =
        ref.watch(HighlightsProvider.highlightsProvider).dailyReview;
    return dailyReview!.highlights.length > 0
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white70,
                  onPressed: () => Navigator.of(context).pop()),
              centerTitle: true,
              actions: <Widget>[
                buildTrackCounter(context, (_selectedPageIndex + 1).toString(),
                    dailyReview.highlights.length.toString())
              ],
              title: Text(
                'Daily Review',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              backgroundColor: Colors.black87,
            ),
            backgroundColor: Colors.black87,
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
                    Flexible(
                      child: PageView(
                        onPageChanged: (value) => _selectPage(value),
                        controller: pageController,
                        children: dailyReview.highlights
                            .map((highlightExtended) =>
                                buildHighlightCard(highlightExtended))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: ElevatedButton(
              child: Icon(Icons.done),
              onPressed: () {
                setState(() {
                  var index = 0;
                  if (_selectedPageIndex <
                      (dailyReview.highlights.length - 1)) {
                    index = _selectedPageIndex + 1;
                  }
                  pageController.jumpToPage(index);
                  _selectPage(index);
                });
              },
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

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

  Widget buildHighlightCard(HighlightExtended highlight) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(15.0),
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.grey[900],
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 40,
                          height: 100,
                          child:
                              CachedNetworkImage(imageUrl: highlight.imageURL)),
                      SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              highlight.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(height: 5),
                            Text(
                              highlight.author,
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    highlight.highlight.text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
