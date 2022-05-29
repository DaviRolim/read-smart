import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({required this.title, this.ontap, Key? key})
      : super(key: key);

  final String title;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      child: InkWell(
        onTap: ontap,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          // color: Color(0xff9d6790),
          elevation: 2,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
        ),
      ),
    );
  }
}

