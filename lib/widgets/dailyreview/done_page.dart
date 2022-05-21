import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      duration: const Duration(seconds: 2),
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
    return Center(
      child: CircularProgressIndicator(
        value: controller.value,
      ),
    );
  }
}
