import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../helpers/custom_page_route.dart';
import '../../providers/daily_review_provider.dart';
import '../../screens/daily_review_screen.dart';

class HeadlineCard extends ConsumerWidget {
  const HeadlineCard(
      {required this.title,
      required this.image,
      required this.body,
      this.textTop,
      this.ontap,
      Key? key})
      : super(key: key);

  final String title;
  final String? textTop;
  final Widget body;
  final ImageProvider image;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      child: InkWell(
        onTap: ontap,
        child: Card(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                    opacity: 0.65),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (textTop != null)
                    Text(
                      textTop!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  // Text(
                  //   DateFormat.yMMMMd().format(DateTime.now()),
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  SizedBox(height: 8),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: 13),
                  Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                  body
                ],
              )),
        ),
      ),
    );
  }
}
