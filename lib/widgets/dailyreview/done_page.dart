import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/daily_review_provider.dart';

class DonePage extends ConsumerStatefulWidget {
  DonePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DonePage> createState() => _DonePageState();
}

class _DonePageState extends ConsumerState<DonePage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStreak =
        ref.read(DailyReviewProvider.dailyReviewProvider).currentStreak;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: MediaQuery.of(context).size.height * 0.55,
        child: Card(
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: 185,
                    height: 185,
                    child: CircularProgressIndicator(
                      value: controller.value,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48.0),
                    child: Column(
                      children: [
                        Text(
                          '10/10',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Highlights reviewed today!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Nice! You completed your daily Readsmart.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You\'ve reviewed ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    currentStreak.toString() +
                        (currentStreak! > 1 ? ' days' : ' day'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' in a row.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
